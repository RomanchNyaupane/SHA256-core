module myip_slave_lite_v1_0_S00_AXI #
(
parameter integer C_S_AXI_DATA_WIDTH	= 32,
parameter integer C_S_AXI_ADDR_WIDTH	= 9
)
(
input wire  S_AXI_ACLK,
input wire  S_AXI_ARESETN,
input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_AWADDR,
input wire [2 : 0] S_AXI_AWPROT,
input wire  S_AXI_AWVALID,
output wire  S_AXI_AWREADY,
input wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_WDATA,
input wire [(C_S_AXI_DATA_WIDTH/8)-1 : 0] S_AXI_WSTRB,
input wire  S_AXI_WVALID,
output wire  S_AXI_WREADY,
output wire [1 : 0] S_AXI_BRESP,
output wire  S_AXI_BVALID,
input wire  S_AXI_BREADY,
input wire [C_S_AXI_ADDR_WIDTH-1 : 0] S_AXI_ARADDR,
input wire [2 : 0] S_AXI_ARPROT,
input wire  S_AXI_ARVALID,
output wire  S_AXI_ARREADY,
output wire [C_S_AXI_DATA_WIDTH-1 : 0] S_AXI_RDATA,
output wire [1 : 0] S_AXI_RRESP,
output wire  S_AXI_RVALID,
input wire  S_AXI_RREADY
);

// AXI4LITE signals
reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_awaddr;
reg  	axi_awready;
reg  	axi_wready;
reg [1 : 0] 	axi_bresp;
reg  	axi_bvalid;
reg [C_S_AXI_ADDR_WIDTH-1 : 0] 	axi_araddr;
reg  	axi_arready;
reg [1 : 0] 	axi_rresp;
reg  	axi_rvalid;

localparam integer ADDR_LSB = (C_S_AXI_DATA_WIDTH/32) + 1;
localparam integer OPT_MEM_ADDR_BITS = 6;

reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg0;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg1;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg2;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg3;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg4;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg5;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg6;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg7;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg8;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg9;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg10;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg11;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg12;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg13;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg14;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg15;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg16;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg17;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg18;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg19;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg20;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg21;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg22;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg23;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg24;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg25;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg26;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg27;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg28;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg29;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg30;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg31;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg32;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg33;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg34;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg35;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg36;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg37;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg38;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg39;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg40;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg41;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg42;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg43;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg44;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg45;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg46;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg47;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg48;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg49;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg50;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg51;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg52;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg53;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg54;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg55;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg56;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg57;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg58;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg59;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg60;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg61;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg62;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg63;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg64;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg65;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg66;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg67;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg68;
reg [C_S_AXI_DATA_WIDTH-1:0]	slv_reg69;
integer	 byte_index;

assign S_AXI_AWREADY	= axi_awready;
assign S_AXI_WREADY	= axi_wready;
assign S_AXI_BRESP	= axi_bresp;
assign S_AXI_BVALID	= axi_bvalid;
assign S_AXI_ARREADY	= axi_arready;
assign S_AXI_RRESP	= axi_rresp;
assign S_AXI_RVALID	= axi_rvalid;

reg [1:0] state_write;
reg [1:0] state_read;

localparam Idle = 2'b00,Raddr = 2'b10,Rdata = 2'b11 ,Waddr = 2'b10,Wdata = 2'b11;

always @(posedge S_AXI_ACLK)                                 
begin                                 
    if (S_AXI_ARESETN == 1'b0)                                 
    begin                                 
        axi_awready <= 0;                                 
        axi_wready <= 0;                                 
        axi_bvalid <= 0;                                 
        axi_bresp <= 0;                                 
        axi_awaddr <= 0;                                 
        state_write <= Idle;                                 
    end                                 
    else                                  
    begin                                 
        case(state_write)                                 
        Idle:                                      
            begin                                 
            if(S_AXI_ARESETN == 1'b1)                                  
                begin                                 
                axi_awready <= 1'b1;                                 
                axi_wready <= 1'b1;                                 
                state_write <= Waddr;                                 
                end                                 
            else state_write <= state_write;                                 
            end                                 
        Waddr:        //At this state, slave is ready to receive address along with corresponding control signals and first data packet. Response valid is also handled at this state                                 
            begin                                 
            if (S_AXI_AWVALID && S_AXI_AWREADY)                                 
                begin                                 
                axi_awaddr <= S_AXI_AWADDR;                                 
                if(S_AXI_WVALID)                                  
                    begin                                   
                    axi_awready <= 1'b1;                                 
                    state_write <= Waddr;                                 
                    axi_bvalid <= 1'b1;                                 
                    end                                 
                else                                  
                    begin                                 
                    axi_awready <= 1'b0;                                 
                    state_write <= Wdata;                                 
                    if (S_AXI_BREADY && axi_bvalid) axi_bvalid <= 1'b0;                                 
                    end                                 
                end                                 
            else                                  
                begin                                 
                state_write <= state_write;                                 
                if (S_AXI_BREADY && axi_bvalid) axi_bvalid <= 1'b0;                                 
                end                                 
            end                                 
        Wdata:        //At this state, slave is ready to receive the data packets until the number of transfers is equal to burst length                                 
            begin                                 
            if (S_AXI_WVALID)                                 
                begin                                 
                state_write <= Waddr;                                 
                axi_bvalid <= 1'b1;                                 
                axi_awready <= 1'b1;                                 
                end                                 
            else                                  
                begin                                 
                state_write <= state_write;                                 
                if (S_AXI_BREADY && axi_bvalid) axi_bvalid <= 1'b0;                                 
                end                                              
            end                                 
        endcase                                 
    end                                 
    end                                 

always @( posedge S_AXI_ACLK )
begin
if ( S_AXI_ARESETN == 1'b0 )
begin
    slv_reg0 <= 0;
    slv_reg1 <= 0;
    slv_reg2 <= 0;
    slv_reg3 <= 0;
    slv_reg4 <= 0;
    slv_reg5 <= 0;
    slv_reg6 <= 0;
    slv_reg7 <= 0;
    slv_reg8 <= 0;
    slv_reg9 <= 0;
    slv_reg10 <= 0;
    slv_reg11 <= 0;
    slv_reg12 <= 0;
    slv_reg13 <= 0;
    slv_reg14 <= 0;
    slv_reg15 <= 0;
    slv_reg16 <= 0;
    slv_reg17 <= 0;
    slv_reg18 <= 0;
    slv_reg19 <= 0;
    slv_reg20 <= 0;
    slv_reg21 <= 0;
    slv_reg22 <= 0;
    slv_reg23 <= 0;
    slv_reg24 <= 0;
    slv_reg25 <= 0;
    slv_reg26 <= 0;
    slv_reg27 <= 0;
    slv_reg28 <= 0;
    slv_reg29 <= 0;
    slv_reg30 <= 0;
    slv_reg31 <= 0;
    slv_reg32 <= 0;
    slv_reg33 <= 0;
    slv_reg34 <= 0;
    slv_reg35 <= 0;
    slv_reg36 <= 0;
    slv_reg37 <= 0;
    slv_reg38 <= 0;
    slv_reg39 <= 0;
    slv_reg40 <= 0;
    slv_reg41 <= 0;
    slv_reg42 <= 0;
    slv_reg43 <= 0;
    slv_reg44 <= 0;
    slv_reg45 <= 0;
    slv_reg46 <= 0;
    slv_reg47 <= 0;
    slv_reg48 <= 0;
    slv_reg49 <= 0;
    slv_reg50 <= 0;
    slv_reg51 <= 0;
    slv_reg52 <= 0;
    slv_reg53 <= 0;
    slv_reg54 <= 0;
    slv_reg55 <= 0;
    slv_reg56 <= 0;
    slv_reg57 <= 0;
    slv_reg58 <= 0;
    slv_reg59 <= 0;
    slv_reg60 <= 0;
    slv_reg61 <= 0;
    slv_reg62 <= 0;
    slv_reg63 <= 0;
    slv_reg64 <= 0;
    slv_reg65 <= 0;
    slv_reg66 <= 0;
    slv_reg67 <= 0;
    slv_reg68 <= 0;
    slv_reg69 <= 0;
end 
else begin
if (S_AXI_WVALID)
    begin
    case ( (S_AXI_AWVALID) ? S_AXI_AWADDR[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] : axi_awaddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] )
        7'h00:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 0
            slv_reg0[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h01:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 1
            slv_reg1[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h02:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 2
            slv_reg2[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h03:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 3
            slv_reg3[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h04:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 4
            slv_reg4[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h05:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 5
            slv_reg5[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h06:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 6
            slv_reg6[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h07:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 7
            slv_reg7[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h08:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 8
            slv_reg8[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h09:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 9
            slv_reg9[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h0A:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 10
            slv_reg10[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h0B:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 11
            slv_reg11[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h0C:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 12
            slv_reg12[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h0D:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 13
            slv_reg13[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h0E:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 14
            slv_reg14[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h0F:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 15
            slv_reg15[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        /*
        7'h10:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 16
            slv_reg16[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h11:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 17
            slv_reg17[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h12:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 18
            slv_reg18[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h13:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 19
            slv_reg19[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h14:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 20
            slv_reg20[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h15:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 21
            slv_reg21[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h16:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 22
            slv_reg22[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h17:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 23
            slv_reg23[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        */
        7'h18:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 24
            slv_reg24[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        /*
        7'h19:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 25
            slv_reg25[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end
        */
        7'h1A:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 26
            slv_reg26[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h1B:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 27
            slv_reg27[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h1C:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 28
            slv_reg28[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h1D:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 29
            slv_reg29[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h1E:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 30
            slv_reg30[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h1F:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 31
            slv_reg31[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h20:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 32
            slv_reg32[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end
        7'h21:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 33
            slv_reg33[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h22:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 34
            slv_reg34[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h23:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 35
            slv_reg35[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h24:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 36
            slv_reg36[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h25:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 37
            slv_reg37[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h26:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 38
            slv_reg38[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h27:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 39
            slv_reg39[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h28:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 40
            slv_reg40[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h29:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 41
            slv_reg41[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h2A:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 42
            slv_reg42[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h2B:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 43
            slv_reg43[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h2C:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 44
            slv_reg44[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h2D:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 45
            slv_reg45[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h2E:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 46
            slv_reg46[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h2F:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 47
            slv_reg47[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h30:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 48
            slv_reg48[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h31:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 49
            slv_reg49[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h32:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 50
            slv_reg50[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h33:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 51
            slv_reg51[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h34:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 52
            slv_reg52[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h35:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 53
            slv_reg53[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h36:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 54
            slv_reg54[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h37:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 55
            slv_reg55[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h38:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 56
            slv_reg56[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h39:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 57
            slv_reg57[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h3A:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 58
            slv_reg58[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h3B:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 59
            slv_reg59[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h3C:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 60
            slv_reg60[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h3D:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 61
            slv_reg61[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h3E:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 62
            slv_reg62[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h3F:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 63
            slv_reg63[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h40:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 64
            slv_reg64[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h41:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 65
            slv_reg65[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h42:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 66
            slv_reg66[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h43:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 67
            slv_reg67[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h44:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 68
            slv_reg68[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        7'h45:
        for ( byte_index = 0; byte_index <= (C_S_AXI_DATA_WIDTH/8)-1; byte_index = byte_index+1 )
            if ( S_AXI_WSTRB[byte_index] == 1 ) begin
            // Respective byte enables are asserted as per write strobes 
            // Slave register 69
            slv_reg69[(byte_index*8) +: 8] <= S_AXI_WDATA[(byte_index*8) +: 8];
            end  
        default : begin
                    slv_reg0 <= slv_reg0;
                    slv_reg1 <= slv_reg1;
                    slv_reg2 <= slv_reg2;
                    slv_reg3 <= slv_reg3;
                    slv_reg4 <= slv_reg4;
                    slv_reg5 <= slv_reg5;
                    slv_reg6 <= slv_reg6;
                    slv_reg7 <= slv_reg7;
                    slv_reg8 <= slv_reg8;
                    slv_reg9 <= slv_reg9;
                    slv_reg10 <= slv_reg10;
                    slv_reg11 <= slv_reg11;
                    slv_reg12 <= slv_reg12;
                    slv_reg13 <= slv_reg13;
                    slv_reg14 <= slv_reg14;
                    slv_reg15 <= slv_reg15;
                    slv_reg16 <= slv_reg16;
                    slv_reg17 <= slv_reg17;
                    slv_reg18 <= slv_reg18;
                    slv_reg19 <= slv_reg19;
                    slv_reg20 <= slv_reg20;
                    slv_reg21 <= slv_reg21;
                    slv_reg22 <= slv_reg22;
                    slv_reg23 <= slv_reg23;
                    slv_reg24 <= slv_reg24;
                    slv_reg25 <= slv_reg25;
                    slv_reg26 <= slv_reg26;
                    slv_reg27 <= slv_reg27;
                    slv_reg28 <= slv_reg28;
                    slv_reg29 <= slv_reg29;
                    slv_reg30 <= slv_reg30;
                    slv_reg31 <= slv_reg31;
                    slv_reg32 <= slv_reg32;
                    slv_reg33 <= slv_reg33;
                    slv_reg34 <= slv_reg34;
                    slv_reg35 <= slv_reg35;
                    slv_reg36 <= slv_reg36;
                    slv_reg37 <= slv_reg37;
                    slv_reg38 <= slv_reg38;
                    slv_reg39 <= slv_reg39;
                    slv_reg40 <= slv_reg40;
                    slv_reg41 <= slv_reg41;
                    slv_reg42 <= slv_reg42;
                    slv_reg43 <= slv_reg43;
                    slv_reg44 <= slv_reg44;
                    slv_reg45 <= slv_reg45;
                    slv_reg46 <= slv_reg46;
                    slv_reg47 <= slv_reg47;
                    slv_reg48 <= slv_reg48;
                    slv_reg49 <= slv_reg49;
                    slv_reg50 <= slv_reg50;
                    slv_reg51 <= slv_reg51;
                    slv_reg52 <= slv_reg52;
                    slv_reg53 <= slv_reg53;
                    slv_reg54 <= slv_reg54;
                    slv_reg55 <= slv_reg55;
                    slv_reg56 <= slv_reg56;
                    slv_reg57 <= slv_reg57;
                    slv_reg58 <= slv_reg58;
                    slv_reg59 <= slv_reg59;
                    slv_reg60 <= slv_reg60;
                    slv_reg61 <= slv_reg61;
                    slv_reg62 <= slv_reg62;
                    slv_reg63 <= slv_reg63;
                    slv_reg64 <= slv_reg64;
                    slv_reg65 <= slv_reg65;
                    slv_reg66 <= slv_reg66;
                    slv_reg67 <= slv_reg67;
                    slv_reg68 <= slv_reg68;
                    slv_reg69 <= slv_reg69;
                end
    endcase
    end
end
end    

// Implement read state machine
always @(posedge S_AXI_ACLK)                                       
begin                                       
    if (S_AXI_ARESETN == 1'b0)                                       
    begin                                       
        //asserting initial values to all 0's during reset                                       
        axi_arready <= 1'b0;                                       
        axi_rvalid <= 1'b0;                                       
        axi_rresp <= 1'b0;                                       
        state_read <= Idle;                                       
    end                                       
    else                                       
    begin                                       
        case(state_read)                                       
        Idle:     //Initial state inidicating reset is done and ready to receive read/write transactions                                       
            begin                                                
            if (S_AXI_ARESETN == 1'b1)                                        
                begin                                       
                state_read <= Raddr;                                       
                axi_arready <= 1'b1;                                       
                end                                       
            else state_read <= state_read;                                       
            end                                       
        Raddr:        //At this state, slave is ready to receive address along with corresponding control signals                                       
            begin                                       
            if (S_AXI_ARVALID && S_AXI_ARREADY)                                       
                begin                                       
                state_read <= Rdata;                                       
                axi_araddr <= S_AXI_ARADDR;                                       
                axi_rvalid <= 1'b1;                                       
                axi_arready <= 1'b0;                                       
                end                                       
            else state_read <= state_read;                                       
            end                                       
        Rdata:        //At this state, slave is ready to send the data packets until the number of transfers is equal to burst length                                       
            begin                                           
            if (S_AXI_RVALID && S_AXI_RREADY)                                       
                begin                                       
                axi_rvalid <= 1'b0;                                       
                axi_arready <= 1'b1;                                       
                state_read <= Raddr;                                       
                end                                       
            else state_read <= state_read;                                       
            end                                       
        endcase                                       
        end                                       
    end                                         
// Implement memory mapped register select and read logic generation
assign S_AXI_RDATA = (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h0) ? slv_reg0 : (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h1) ? slv_reg1 : (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h2) ? slv_reg2 : (axi_araddr[ADDR_LSB+OPT_MEM_ADDR_BITS:ADDR_LSB] == 2'h3) ? slv_reg3 :0;  


// Add user logic here
wire [511:0] data_in;
wire init;
wire [255:0] hash_out;
wire hash_ready;
secure_hash_core u_secure_hash_core (
    .clk(S_AXI_ACLK),
    .reset(S_AXI_ARESETN),
    .data_in({slv_reg15,slv_reg14,slv_reg13, slv_reg12, slv_reg11, slv_reg10, slv_reg9, slv_reg8, slv_reg7, slv_reg6, slv_reg5, slv_reg4, slv_reg3, slv_reg2, slv_reg1, slv_reg0}),
    .init(slv_reg18[0]),
    .hash_out(hash_out),
    .hash_ready(hash_ready)
);

always @(posedge clk) begin
    if(hash_ready) begin
        slv_reg16 <= hash_out[31:0];
        slv_reg17 <= hash_out[63:32];
        slv_reg18 <= hash_out[95:64];
        slv_reg19 <= hash_out[127:96];
        slv_reg20 <= hash_out[159:128];
        slv_reg21 <= hash_out[191:160];
        slv_reg22 <= hash_out[223:192];
        slv_reg23 <= hash_out[255:224];

        slv_reg25 <= {31'b0, hash_ready}; //status
    end
end

// User logic ends

endmodule
