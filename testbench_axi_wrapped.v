`timescale 1ns / 1ps

module tb_myip();
    localparam T = 10;
    
    reg s00_axi_aclk;
    reg s00_axi_aresetn;
    

    wire s00_axi_awready;
    reg [8:0] s00_axi_awaddr;
    reg [2:0] s00_axi_awprot;
    reg s00_axi_awvalid;
    
    wire s00_axi_wready;
    reg [31:0] s00_axi_wdata;
    reg [3:0] s00_axi_wstrb;
    reg s00_axi_wvalid;
    
    reg s00_axi_bready;
    wire [1:0] s00_axi_bresp;
    wire s00_axi_bvalid;
    
    wire s00_axi_arready;
    reg [8:0] s00_axi_araddr;
    reg [2:0] s00_axi_arprot;
    reg s00_axi_arvalid;
    
    reg s00_axi_rready;
    wire [31:0] s00_axi_rdata;
    wire [1:0] s00_axi_rresp;
    wire s00_axi_rvalid;
    
    myip #(
        .C_S00_AXI_DATA_WIDTH(32),
        .C_S00_AXI_ADDR_WIDTH(9)
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
    
    always begin
        s00_axi_aclk = 0;
        #(T/2);
        s00_axi_aclk = 1;
        #(T/2);
    end
    
    initial begin
        // *** Initial value ***
        s00_axi_awaddr = 0;
        s00_axi_awprot = 0;
        s00_axi_awvalid = 0;
        s00_axi_wdata = 0;
        s00_axi_wstrb = 0;
        s00_axi_wvalid = 0;
        s00_axi_bready = 1;
        s00_axi_araddr = 0;
        s00_axi_arprot = 0;
        s00_axi_arvalid = 0;
        s00_axi_rready = 1;
        
        //reset
        s00_axi_aresetn = 0;
        #(T*5);
        s00_axi_aresetn = 1;
        #(T*5);
        
        $display("Test Case 1: SHA-256(abc) ");
        
        // "abc" padded: 0x61626380 00000000 ... 00000018
        axi_write(9'h00, 32'h00000018);  //reg0: length in bits (24 bit)
        axi_write(9'h04, 32'h00000000);  //reg1
        axi_write(9'h08, 32'h00000000);  //reg2
        axi_write(9'h0c, 32'h00000000);  //reg3
        axi_write(9'h10, 32'h00000000);  //reg4
        axi_write(9'h14, 32'h00000000);  //reg5
        axi_write(9'h18, 32'h00000000);  //reg6
        axi_write(9'h1c, 32'h00000000);  //reg7
        axi_write(9'h20, 32'h00000000);  //reg8
        axi_write(9'h24, 32'h00000000);  //reg9
        axi_write(9'h28, 32'h00000000);  //reg10
        axi_write(9'h2c, 32'h00000000);  //reg11
        axi_write(9'h30, 32'h00000000);  //reg12
        axi_write(9'h34, 32'h00000000);  //reg13
        axi_write(9'h38, 32'h00000000);  //reg14
        axi_write(9'h3c, 32'h61626380);  //reg15: "abc" + padding start
        
        //start hash computation
        axi_write(9'h60, 32'h00000001);  //reg18: init = 1
        
        #20
        axi_write(9'h60, 32'h00000000);  //reg18: init = 1
        
        //wait for computation (adjust time as needed)
        #(T*100);
        
        //read status register
        axi_read(9'h64);  //reg25: status (hash_ready)
        #(T*2);
        $display("Status = 0x%h", s00_axi_rdata);
        
        //read hash result (8 x 32-bit words = 256 bits)
        axi_read(9'h40);  //reg16
        #(T*2);
        $display("Hash[31:0]  = 0x%h", s00_axi_rdata);
        
        axi_read(9'h44);  // reg17
        #(T*2);
        $display("Hash[63:32]    = 0x%h", s00_axi_rdata);
        
        axi_read(9'h48);  // reg18
        #(T*2);
        $display("Hash[95:64]    = 0x%h", s00_axi_rdata);
        
        axi_read(9'h4c);  // reg19
        #(T*2);
        $display("Hash[127:96]   = 0x%h", s00_axi_rdata);
        
        axi_read(9'h50);  // reg20
        #(T*2);
        $display("Hash[159:128]  = 0x%h", s00_axi_rdata);
        
        axi_read(9'h54);  // reg21
        #(T*2);
        $display("Hash[191:160]  = 0x%h", s00_axi_rdata);
        
        axi_read(9'h58);  // reg22
        #(T*2);
        $display("Hash[223:192]  = 0x%h", s00_axi_rdata);
        
        axi_read(9'h5c);  // reg23
        #(T*2);
        $display("Hash[255:224]  = 0x%h", s00_axi_rdata);
        
        $display("Expected: ba7816bf 8f01cfea 414140de 5dae2223 b00361a3 96177a9c b410ff61 f20015ad");
        
        #(T*10);
        
        // Test Case 2: Empty string (padded)
        $display("\n=== Test Case 2: SHA-256('') - Empty String ===");
        
        //write 512-bit input for empty string
        axi_write(9'h00, 32'h80000000);  //reg0: padding start
        axi_write(9'h04, 32'h00000000);  //reg1
        axi_write(9'h08, 32'h00000000);  //reg2
        axi_write(9'h0c, 32'h00000000);  //reg3
        axi_write(9'h10, 32'h00000000);  //reg4
        axi_write(9'h14, 32'h00000000);  //reg5
        axi_write(9'h18, 32'h00000000);  //reg6
        axi_write(9'h1c, 32'h00000000);  //reg7
        axi_write(9'h20, 32'h00000000);  //reg8
        axi_write(9'h24, 32'h00000000);  //reg9
        axi_write(9'h28, 32'h00000000);  //reg10
        axi_write(9'h2c, 32'h00000000);  //reg11
        axi_write(9'h30, 32'h00000000);  //reg12
        axi_write(9'h34, 32'h00000000);  //reg13
        axi_write(9'h38, 32'h00000000);  //reg14
        axi_write(9'h3c, 32'h00000000);  //reg15: length = 0 bits
        
        //start hash computation
        axi_write(9'h48, 32'h00000001);  // reg18: init = 1
        
        //wait for computation
        #(T*100);
        
        //read status register
        axi_read(9'h64);  // reg25: status
        #(T*2);
        $display("Status = 0x%h", s00_axi_rdata);
        
        //read hash result
        axi_read(9'h40);  // reg16
        #(T*2);
        $display("Hash[31:0]     = 0x%h", s00_axi_rdata);
        
        axi_read(9'h44);  // reg17
        #(T*2);
        $display("Hash[63:32]    = 0x%h", s00_axi_rdata);
        
        axi_read(9'h48);  // reg18
        #(T*2);
        $display("Hash[95:64]    = 0x%h", s00_axi_rdata);
        
        axi_read(9'h4c);  // reg19
        #(T*2);
        $display("Hash[127:96]   = 0x%h", s00_axi_rdata);
        
        axi_read(9'h50);  // reg20
        #(T*2);
        $display("Hash[159:128]  = 0x%h", s00_axi_rdata);
        
        axi_read(9'h54);  // reg21
        #(T*2);
        $display("Hash[191:160]  = 0x%h", s00_axi_rdata);
        
        axi_read(9'h58);  // reg22
        #(T*2);
        $display("Hash[223:192]  = 0x%h", s00_axi_rdata);
        
        axi_read(9'h5c);  // reg23
        #(T*2);
        $display("Hash[255:224]  = 0x%h", s00_axi_rdata);
        
        $display("Expected: e3b0c442 98fc1c14 9afbf4c8 996fb924 27ae41e4 649b934c a495991b 7852b855");
        
        #(T*10);
        $display("\n=== Simulation Complete ===");
        $finish;
    end
    
    //AXI Write
    task axi_write;
        input [8:0] awaddr;
        input [31:0] wdata;
        begin
            //address
            s00_axi_awaddr = awaddr;
            s00_axi_awvalid = 1;
            #T;
            s00_axi_awvalid = 0;
            //data
            s00_axi_wdata = wdata;
            s00_axi_wstrb = 4'hf;
            s00_axi_wvalid = 1;
            #T;
            s00_axi_wvalid = 0;
            #T;
        end
    endtask
    
    //AXI Read 
    task axi_read;
        input [8:0] araddr;
        begin
            s00_axi_araddr = araddr;
            s00_axi_arvalid = 1;
            #T;
            s00_axi_arvalid = 0;
            #T;
        end
    endtask

endmodule