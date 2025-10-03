`timescale 1ns / 1ps

module tb_myip();

    // Parameters
    parameter integer C_S00_AXI_DATA_WIDTH = 32;
    parameter integer C_S00_AXI_ADDR_WIDTH = 9;
    parameter CLK_PERIOD = 10; // 100MHz clock
    
    // Clock and Reset
    reg s00_axi_aclk;
    reg s00_axi_aresetn;
    
    // AXI4-Lite Write Address Channel
    reg [C_S00_AXI_ADDR_WIDTH-1:0] s00_axi_awaddr;
    reg [2:0] s00_axi_awprot;
    reg s00_axi_awvalid;
    wire s00_axi_awready;
    
    // AXI4-Lite Write Data Channel
    reg [C_S00_AXI_DATA_WIDTH-1:0] s00_axi_wdata;
    reg [(C_S00_AXI_DATA_WIDTH/8)-1:0] s00_axi_wstrb;
    reg s00_axi_wvalid;
    wire s00_axi_wready;
    
    // AXI4-Lite Write Response Channel
    wire [1:0] s00_axi_bresp;
    wire s00_axi_bvalid;
    reg s00_axi_bready;
    
    // AXI4-Lite Read Address Channel
    reg [C_S00_AXI_ADDR_WIDTH-1:0] s00_axi_araddr;
    reg [2:0] s00_axi_arprot;
    reg s00_axi_arvalid;
    wire s00_axi_arready;
    
    // AXI4-Lite Read Data Channel
    wire [C_S00_AXI_DATA_WIDTH-1:0] s00_axi_rdata;
    wire [1:0] s00_axi_rresp;
    wire s00_axi_rvalid;
    reg s00_axi_rready;
    
    // Instantiate DUT
    myip #(
        .C_S00_AXI_DATA_WIDTH(C_S00_AXI_DATA_WIDTH),
        .C_S00_AXI_ADDR_WIDTH(C_S00_AXI_ADDR_WIDTH)
    ) dut (
        .s00_axi_aclk(s00_axi_aclk),
        .s00_axi_aresetn(s00_axi_aresetn),
        .s00_axi_awaddr(s00_axi_awaddr),
        .s00_axi_awprot(s00_axi_awprot),
        .s00_axi_awvalid(s00_axi_awvalid),
        .s00_axi_awready(s00_axi_awready),
        .s00_axi_wdata(s00_axi_wdata),
        .s00_axi_wstrb(s00_axi_wstrb),
        .s00_axi_wvalid(s00_axi_wvalid),
        .s00_axi_wready(s00_axi_wready),
        .s00_axi_bresp(s00_axi_bresp),
        .s00_axi_bvalid(s00_axi_bvalid),
        .s00_axi_bready(s00_axi_bready),
        .s00_axi_araddr(s00_axi_araddr),
        .s00_axi_arprot(s00_axi_arprot),
        .s00_axi_arvalid(s00_axi_arvalid),
        .s00_axi_arready(s00_axi_arready),
        .s00_axi_rdata(s00_axi_rdata),
        .s00_axi_rresp(s00_axi_rresp),
        .s00_axi_rvalid(s00_axi_rvalid),
        .s00_axi_rready(s00_axi_rready)
    );
    
    // Clock generation
    initial begin
        s00_axi_aclk = 0;
        forever #(CLK_PERIOD/2) s00_axi_aclk = ~s00_axi_aclk;
    end
    
    // AXI Write Task
    task axi_write;
        input [C_S00_AXI_ADDR_WIDTH-1:0] addr;
        input [C_S00_AXI_DATA_WIDTH-1:0] data;
        begin
            @(posedge s00_axi_aclk);
            s00_axi_awaddr = addr;
            s00_axi_awvalid = 1;
            s00_axi_awprot = 3'b000;
            
            s00_axi_wdata = data;
            s00_axi_wvalid = 1;
            s00_axi_wstrb = 4'hF;
            s00_axi_bready = 1;
            
            // Wait for address ready
            wait(s00_axi_awready);
            @(posedge s00_axi_aclk);
            s00_axi_awvalid = 0;
            
            // Wait for data ready
            wait(s00_axi_wready);
            @(posedge s00_axi_aclk);
            s00_axi_wvalid = 0;
            
            // Wait for write response
            wait(s00_axi_bvalid);
            @(posedge s00_axi_aclk);
            s00_axi_bready = 0;
            
            $display("Time=%0t: AXI Write - Addr=0x%h, Data=0x%h", $time, addr, data);
        end
    endtask
    
    // AXI Read Task
    task axi_read;
        input [C_S00_AXI_ADDR_WIDTH-1:0] addr;
        output [C_S00_AXI_DATA_WIDTH-1:0] data;
        begin
            @(posedge s00_axi_aclk);
            s00_axi_araddr = addr;
            s00_axi_arvalid = 1;
            s00_axi_arprot = 3'b000;
            s00_axi_rready = 1;
            
            // Wait for address ready
            wait(s00_axi_arready);
            @(posedge s00_axi_aclk);
            s00_axi_arvalid = 0;
            
            // Wait for read data valid
            wait(s00_axi_rvalid);
            data = s00_axi_rdata;
            @(posedge s00_axi_aclk);
            s00_axi_rready = 0;
            
            $display("Time=%0t: AXI Read - Addr=0x%h, Data=0x%h", $time, addr, data);
        end
    endtask
    
    // Test SHA-256 with known input
    task test_sha256;
        input [511:0] message;
        input [255:0] expected_hash;
        reg [31:0] read_data;
        reg [255:0] result_hash;
        integer i;
        begin
            $display("\n=== Starting SHA-256 Test ===");
            $display("Input Message: 0x%h", message);
            
            // Write 16 x 32-bit words (512 bits total) to registers 0-15
            for (i = 0; i < 16; i = i + 1) begin
                axi_write(i * 4, message[i*32 +: 32]);
            end
            
            // Trigger hash computation by writing to control register (reg 18, addr 72)
            $display("Triggering hash computation...");
            axi_write(72, 32'h00000001); // Set init bit
            
            // Poll status register (reg 25, addr 100) for completion
            read_data = 0;
            while (read_data[0] == 0) begin
                #(CLK_PERIOD * 10); // Wait some cycles
                axi_read(100, read_data);
                if (read_data[0] == 1) begin
                    $display("Hash computation completed!");
                end
            end
            
            // Read hash result from registers 16-23 (addresses 64-92)
            for (i = 0; i < 8; i = i + 1) begin
                axi_read(64 + (i * 4), read_data);
                result_hash[i*32 +: 32] = read_data;
            end
            
            $display("Result Hash: 0x%h", result_hash);
            $display("Expected Hash: 0x%h", expected_hash);
            
            // Compare result
            if (result_hash == expected_hash) begin
                $display("*** TEST PASSED ***");
            end else begin
                $display("*** TEST FAILED ***");
            end
            
            // Clear init bit
            axi_write(72, 32'h00000000);
            #(CLK_PERIOD * 10);
        end
    endtask
    
    // Main test sequence
    initial begin
        // Initialize signals
        s00_axi_aresetn = 0;
        s00_axi_awaddr = 0;
        s00_axi_awprot = 0;
        s00_axi_awvalid = 0;
        s00_axi_wdata = 0;
        s00_axi_wstrb = 0;
        s00_axi_wvalid = 0;
        s00_axi_bready = 0;
        s00_axi_araddr = 0;
        s00_axi_arprot = 0;
        s00_axi_arvalid = 0;
        s00_axi_rready = 0;
        
        // Wait for some time
        #(CLK_PERIOD * 5);
        
        // Release reset
        s00_axi_aresetn = 1;
        #(CLK_PERIOD * 5);
        
        // Test Case 1: Empty string (all zeros - represents padded empty message)
        // SHA-256("") = e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
        test_sha256(
            512'h8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000,
            256'he3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855
        );
        
        // Test Case 2: "abc" (pre-padded)
        // SHA-256("abc") = ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
        test_sha256(
            512'h6162638000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000018,
            256'hba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad
        );
        
        // Test Case 3: Custom test pattern
        test_sha256(
            512'h0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef,
            256'h0 // Replace with expected hash if known
        );
        
        // Finish simulation
        #(CLK_PERIOD * 100);
        $display("\n=== Simulation Complete ===");
        $finish;
    end
    
    // Timeout watchdog
    initial begin
        #(CLK_PERIOD * 100000);
        $display("ERROR: Simulation timeout!");
        $finish;
    end
    
    // Optional: Dump waveforms
    initial begin
        $dumpfile("tb_myip.vcd");
        $dumpvars(0, tb_myip);
    end

endmodule