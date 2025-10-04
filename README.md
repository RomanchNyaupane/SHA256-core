# SHA-256 Hardware Accelerator with AXI4-Lite Interface

## Overview

This project implements a hardware-accelerated SHA-256 cryptographic hash function using Verilog HDL, designed for FPGA deployment. The core is wrapped with an AXI4-Lite slave interface.

## Architecture

### High-Level Block Diagram

```
┌─────────────────────────────────────────────────────────┐
│                  AXI4-Lite Master                       │
│                  (ARM Processor)                        │
└──────────────────────┬──────────────────────────────────┘
                       │ AXI4-Lite Bus
┌──────────────────────▼──────────────────────────────────┐
│         myip_slave_lite_v1_0_S00_AXI                    │
│         (AXI Wrapper Module)                            │
│  ┌────────────────────────────────────────────────┐    │
│  │  Control Registers (slv_reg0 - slv_reg69)     │    │
│  │  • Input Data: reg0-reg15 (512 bits)          │    │
│  │  • Hash Output: reg16-reg23 (256 bits)        │    │
│  │  • Control: reg24 (init signal)               │    │
│  │  • Status: reg25 (hash_ready)                 │    │
│  └───────────────────┬────────────────────────────┘    │
└────────────────────────┼────────────────────────────────┘
                         │
┌────────────────────────▼────────────────────────────────┐
│         secure_hash_algorithm                           │
│         (SHA-256 Core)                                  │
│  ┌──────────────────────────────────────────────┐      │
│  │  State Machine: IDLE → BUSY → DONE          │      │
│  └──────────────────────────────────────────────┘      │
│  ┌──────────────┐  ┌──────────────┐  ┌─────────┐      │
│  │ Scheduling   │  │  K-Values    │  │ Hash    │      │
│  │ Unit         │  │  ROM         │  │ Engine  │      │
│  └──────────────┘  └──────────────┘  └─────────┘      │
└─────────────────────────────────────────────────────────┘
```

### Data Flow

1. **Input**: 512-bit data block written to registers 0-15
2. **Control**: Init signal triggers hash computation
3. **Processing**: 64 rounds of SHA-256 algorithm
4. **Output**: 256-bit hash result stored in registers 16-23
5. **Status**: Ready flag set in register 25

---

## Module Descriptions

### 1. `myip_slave_lite_v1_0_S00_AXI`
**File**: `axi_wrapper.v`

AXI4-Lite slave interface wrapper that handles bus transactions and register management.

**Key Features**:
- Write state machine with Idle, Waddr, Wdata states
- Read state machine with Idle, Raddr, Rdata states
- 70 × 32-bit slave registers
- Byte-enable support via write strobes
- Instantiates SHA-256 core

---

### 2. `secure_hash_algorithm`
**File**: `sha256_main.v`

Core SHA-256 hashing engine implementing the complete algorithm.

**Features**:
- Initial hash values (H0-H7)
- 64-round computation
- State machine: IDLE, BUSY, DONE
- Working variables: a, b, c, d, e, f, g, h
- Integration with scheduling unit and K-values ROM

**Functions**:
- `right_rotate`: Circular right rotation
- `sigma0`, `sigma1`: SHA-256 Σ functions
- `choice`: Ch(x, y, z) function
- `majority`: Maj(x, y, z) function

---

### 3. `scheduling_unit`
**File**: `scheduling_unit.v`

Message schedule generator that expands the 512-bit input block into 64 × 32-bit words.

**Operation**:
- First 16 words: Direct from input (W[0] to W[15])
- Remaining 48 words: Computed using σ0 and σ1 functions
- Formula: `W[t] = σ1(W[t-2]) + W[t-7] + σ0(W[t-15]) + W[t-16]`

**Functions**:
- `sigma0`: σ0(x) = ROTR⁷(x) ⊕ ROTR¹⁸(x) ⊕ SHR³(x)
- `sigma1`: σ1(x) = ROTR¹⁷(x) ⊕ ROTR¹⁹(x) ⊕ SHR¹⁰(x)

---

### 4. `k_values`
**File**: `k_values.v`

ROM module containing the 64 constant values (K0-K63) used in SHA-256.

**Implementation**:
- Combinational logic with case statement
- 6-bit index input
- 32-bit constant output
- Values derived from cube roots of first 64 primes

---

## Register Map

### Address Space: 0x000 - 0x114 (70 registers × 4 bytes)

| Address | Register | Access | Description |
|---------|----------|--------|-------------|
| 0x000   | slv_reg0 | R/W | Input data [31:0] / Length field |
| 0x004   | slv_reg1 | R/W | Input data [63:32] |
| 0x008   | slv_reg2 | R/W | Input data [95:64] |
| 0x00C   | slv_reg3 | R/W | Input data [127:96] |
| 0x010   | slv_reg4 | R/W | Input data [159:128] |
| 0x014   | slv_reg5 | R/W | Input data [191:160] |
| 0x018   | slv_reg6 | R/W | Input data [223:192] |
| 0x01C   | slv_reg7 | R/W | Input data [255:224] |
| 0x020   | slv_reg8 | R/W | Input data [287:256] |
| 0x024   | slv_reg9 | R/W | Input data [319:288] |
| 0x028   | slv_reg10 | R/W | Input data [351:320] |
| 0x02C   | slv_reg11 | R/W | Input data [383:352] |
| 0x030   | slv_reg12 | R/W | Input data [415:384] |
| 0x034   | slv_reg13 | R/W | Input data [447:416] |
| 0x038   | slv_reg14 | R/W | Input data [479:448] |
| 0x03C   | slv_reg15 | R/W | Input data [511:480] |
| 0x040   | slv_reg16 | RO | Hash output [31:0] |
| 0x044   | slv_reg17 | RO | Hash output [63:32] |
| 0x048   | slv_reg18 | RO | Hash output [95:64] |
| 0x04C   | slv_reg19 | RO | Hash output [127:96] |
| 0x050   | slv_reg20 | RO | Hash output [159:128] |
| 0x054   | slv_reg21 | RO | Hash output [191:160] |
| 0x058   | slv_reg22 | RO | Hash output [223:192] |
| 0x05C   | slv_reg23 | RO | Hash output [255:224] |
| 0x060   | slv_reg24 | R/W | Control: bit[0] = init |
| 0x064   | slv_reg25 | RO | Status: bit[0] = hash_ready |
| 0x068+  | slv_reg26-69 | R/W | Reserved for future use |

---

## Future Enhancements

- [ ] Multi-block message support
- [ ] DMA interface
- [ ] Interrupt generation on completion
- [ ] HMAC-SHA256 implementation
- [ ] Power optimization
- [ ] Support for SHA-224, SHA-384, SHA-512
- [ ] Padding logic in hardware
- [ ] Performance counters
