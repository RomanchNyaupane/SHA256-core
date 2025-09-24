module scheduling_unit(
    input wire [511:0] data_in,
    input wire [5:0] index,
    input wire init,
    input wire clk, reset,
    output reg [31:0] schedule_out
);
localparam BIT_LENGTH_1 = 32;

function [BIT_LENGTH_1-1:0] right_rotate;
    input [BIT_LENGTH_1-1:0] value;
    input [4:0] amount;
    right_rotate = (value >> amount) | (value << (BIT_LENGTH_1 - amount));
endfunction

function [BIT_LENGTH_1-1:0] right_shift;
    input [BIT_LENGTH_1-1:0] value;
    input [4:0] amount;
    right_shift = value >> amount;
endfunction

function [BIT_LENGTH_1 - 1:0] sigma0;
    input [BIT_LENGTH_1 - 1:0] w_value;
    sigma0 = right_rotate(w_value, 7) ^ right_rotate(w_value, 18) ^ right_shift(w_value, 3);
endfunction

function [BIT_LENGTH_1 - 1:0] sigma1;
    input [BIT_LENGTH_1 - 1:0] w_value;
    sigma1 = right_rotate(w_value, 17) ^ right_rotate(w_value, 19) ^ right_shift(w_value, 10);
endfunction

reg [31:0] W [0:15];
reg [31:0] W_temp [0:15];
reg [31:0] w_new;

integer i;

//output logic
always @(*) begin
    if(index<16)
        schedule_out = W[index];
    else
        schedule_out = w_new;
end

always @(posedge clk) begin
    if(reset) begin
        for (i = 0; i<16 ; i=i+1) begin
            W[i] <= 32'b0;
        end
    end else begin
        W[00] <= W_temp[00];
        W[01] <= W_temp[01];
        W[02] <= W_temp[02];
        W[03] <= W_temp[03];
        W[04] <= W_temp[04];
        W[05] <= W_temp[05];
        W[06] <= W_temp[06];
        W[07] <= W_temp[07];
        W[08] <= W_temp[08];
        W[09] <= W_temp[09];
        W[10] <= W_temp[10];
        W[11] <= W_temp[11];
        W[12] <= W_temp[12];
        W[13] <= W_temp[13];
        W[14] <= W_temp[14];
        W[15] <= W_temp[15];
    end
end

always @(*) begin

     if(init) begin
        W_temp[00] = data_in[511:480];
        W_temp[01] = data_in[479:448];
        W_temp[02] = data_in[447:416];
        W_temp[03] = data_in[415:384];
        W_temp[04] = data_in[383:352];
        W_temp[05] = data_in[351:320];
        W_temp[06] = data_in[319:288];
        W_temp[07] = data_in[287:256];
        W_temp[08] = data_in[255:224];
        W_temp[09] = data_in[223:192];
        W_temp[10] = data_in[191:160];
        W_temp[11] = data_in[159:128];
        W_temp[12] = data_in[127:096];
        W_temp[13] = data_in[095:064];
        W_temp[14] = data_in[063:032];
        W_temp[15] = data_in[031:000];
    end
    if (index > 15) begin
        W_temp[00] = W[01];
        W_temp[01] = W[02];
        W_temp[02] = W[03];
        W_temp[03] = W[04];
        W_temp[04] = W[05];
        W_temp[05] = W[06];
        W_temp[06] = W[07];
        W_temp[07] = W[08];
        W_temp[08] = W[09];
        W_temp[09] = W[10];
        W_temp[10] = W[11];
        W_temp[11] = W[12];
        W_temp[12] = W[13];
        W_temp[13] = W[14];
        W_temp[14] = W[15];
        W_temp[15] = w_new;
    end
end

always @(*) begin
    w_new = sigma1(W[14]) + W[9] + sigma0(W[1]) + W[0];
end

endmodule