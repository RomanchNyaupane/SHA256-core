module secure_hash_algorithm(
    input wire clk, reset,
    input wire [511:0] data_in,
    input wire init,
    output wire [255:0] hash_out
);
localparam BIT_LENGTH_1 = 32;
localparam BIT_LENGTH_2 = 64;


reg [31:0] schedule_out;
reg [5:0] index;

scheduling_unit sch_u(
    .data_in(data_in),
    .index(index),
    .init(init),
    .clk(clk),
    .reset(reset),
    .schedule_out(schedule_out)
);

always @(posedge clk) begin
    if(reset) begin
        index <= 0;
    end else begin
        
    end

end

//index counter
always @(posedge clk) begin
    if(reset) index <= 0;
    else begin
        if(index == 63) index <= 0;
        else index <= index + 1;
    end
end

endmodule