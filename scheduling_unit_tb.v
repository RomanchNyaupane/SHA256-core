module scheduling_unit_tb();
    reg [511:0] data_in;
    reg [5:0] index;
    reg init;
    reg clk, reset;
    wire [31:0] schedule_out;

    scheduling_unit sch_u(
        .data_in(data_in),
        .index(index),
        .init(init),
        .clk(clk),
        .reset(reset),
        .schedule_out(schedule_out)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        init =0;
        index = 0;
        #20;

        @(negedge clk);
        #2reset = 0;
        init = 1;
        //index = 0;
        data_in = 512'h68_65_6c_6c_6f_80_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_00_28;
        
        @(negedge clk);
        init = 0;
        //index = 1;

        forever begin
            @(posedge clk);
            if(reset) index = 0;
            else index = index + 1;
            if(index == 63) $finish;
        end
        

    end
endmodule