`include "k_values.v"
`include "scheduling_unit.v"
module secure_hash_algorithm(
    input wire clk, reset,
    input wire [511:0] data_in,
    input wire init,
    output reg [255:0] hash_out
);
localparam BIT_LENGTH_1 = 32;
localparam BIT_LENGTH_2 = 64;

//initial hash values
parameter [BIT_LENGTH_1-1:0] H0 = 32'h6a09e667;
parameter [BIT_LENGTH_1-1:0] H1 = 32'hbb67ae85;
parameter [BIT_LENGTH_1-1:0] H2 = 32'h3c6ef372;
parameter [BIT_LENGTH_1-1:0] H3 = 32'ha54ff53a;
parameter [BIT_LENGTH_1-1:0] H4 = 32'h510e527f;
parameter [BIT_LENGTH_1-1:0] H5 = 32'h9b05688c;
parameter [BIT_LENGTH_1-1:0] H6 = 32'h1f83d9ab;
parameter [BIT_LENGTH_1-1:0] H7 = 32'h5be0cd19;

//function definitions
function [BIT_LENGTH_1-1:0] right_rotate;
    input [BIT_LENGTH_1-1:0] value;
    input [4:0] amount;
    right_rotate = (value >> amount) | (value << (BIT_LENGTH_1 - amount));
endfunction

function [BIT_LENGTH_1-1:0] sigma0;
    input [BIT_LENGTH_1-1:0] value;
    sigma0 = right_rotate(value, 2) ^ right_rotate(value, 13) ^ right_rotate(value, 22);
endfunction

function [BIT_LENGTH_1-1:0] sigma1;
    input [BIT_LENGTH_1-1:0] value;
    sigma1 = right_rotate(value, 6) ^ right_rotate(value, 11) ^ right_rotate(value, 25);
endfunction

function [BIT_LENGTH_1-1:0] choice;
    input [BIT_LENGTH_1-1:0] value1, value2, value3;
    choice = (value1 & value2) ^ (~value1 & value3);
endfunction

function [BIT_LENGTH_1-1:0] majority;
    input [BIT_LENGTH_1-1:0] value1, value2, value3;
    majority = (value1 & value2) ^ (value1 & value3) ^ (value2 & value3);
endfunction

//state machine declarations
localparam IDLE = 1, BUSY = 2, DONE = 3;
reg [1:0] state, next_state;

//hash value registers
reg [BIT_LENGTH_1-1:0] hash [0:7];
reg [BIT_LENGTH_1-1:0] a,b,c,d,e,f,g,h;


//counters and control signals declaration
reg [5:0] index;
reg count_ctrl;
reg count_reset;
reg hash_start;
reg output_enable;

//module related declarations
wire [31:0] schedule_out;
wire sch_init;
scheduling_unit sch_u(
    .data_in(data_in),
    .index(index),
    .init(sch_init),
    .clk(clk),
    .reset(reset),
    .schedule_out(schedule_out)
);
wire [31:0] k_val;
k_values k_v(
    .index(index),
    .k_out(k_val)
);

assign sch_init = init? 1: 0;
//state transition
always @(posedge clk) begin
    if(reset) begin
        index <= 0;
        state <= IDLE;
        count_ctrl <= 0;
        hash_start <= 0;
        //sch_init <= 0;
    end else begin
        state <= next_state;
        hash_out <= output_enable ? {a+H0,b+H1,c+H2,d+H3,e+H4,f+H5,g+H6,h+H7}: 256'b0;
    end
end

//state logic
always @ * begin
    count_reset = 0;
    //sch_init = 0;
    output_enable = 0;

    case(state)
        IDLE:begin
            if(init) begin
                next_state = BUSY;
                //sch_init = 1;
                hash_start = 1;
                //count_ctrl = 1;
            end else begin
                next_state = IDLE;
                //sch_init = 0;
                hash_start = 0;
                count_ctrl = 0;
            end
        end

        BUSY:begin
            if(index == 63) begin
                next_state = DONE;
                count_ctrl = 0;
                hash_start = 0;
            end else begin
                next_state = BUSY;
                count_ctrl = 1;
            end
        end
        DONE:begin
            count_reset = 1;
            next_state = IDLE;
            output_enable = 1;
        end
    endcase
end

//hash function
always @(posedge clk) begin
    if(reset) begin
        index <= 0;
        state <= IDLE;
        count_ctrl <= 0;
        hash_start <= 0;
        //sch_init <= 0;
    end else begin
        // loading initial hash values to the registers
        if (state == IDLE && init) begin
             a <= H0;
             b <= H1;
             c <= H2;
             d <= H3;
             e <= H4;
             f <= H5;
             g <= H6;
             h <= H7;
        end else begin
            if(hash_start & ~init) begin
                //t1 = h + Σ1(e) + Ch(e,f,g) + Kt + Wt -> done directly
                //t2 = Σ0(a) + Maj(a,b,c) -> done directly
                h <= g;
                g <= f;
                f <= e;
                e <= d + h + sigma1(e) + choice(e,f,g) + k_val + schedule_out;
                d <= c;
                c <= b;
                b <= a;
                a <= h + sigma1(e) + choice(e,f,g) + k_val + schedule_out + sigma0(a) + majority(a,b,c);
            end
        end
    end
end

//index counter
always @(posedge clk) begin
    if(reset)begin
        index <= 0;
        state <= IDLE;
        count_ctrl <= 0;
        hash_start <= 0;
        //sch_init <= 0;
    end
    else begin
            index <= (index + count_ctrl) & {6{~count_reset}};
    end
end

endmodule
