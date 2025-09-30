module k_values(
    input wire [5:0] index,
    output reg [31:0] k_out
);
always @(*) begin
    case(index) 
        00: k_out = 32'h428a2f98;
        01: k_out = 32'h71374491;
        02: k_out = 32'hb5c0fbcf;
        03: k_out = 32'he9b5dba5;
        04: k_out = 32'h3956c25b;
        05: k_out = 32'h59f111f1;
        06: k_out = 32'h923f82a4;
        07: k_out = 32'hab1c5ed5;
        08: k_out = 32'hd807aa98;
        09: k_out = 32'h12835b01;
        10: k_out = 32'h243185be;
        11: k_out = 32'h550c7dc3;
        12: k_out = 32'h72be5d74;
        13: k_out = 32'h80deb1fe;
        14: k_out = 32'h9bdc06a7;
        15: k_out = 32'hc19bf174;
        16: k_out = 32'he49b69c1;
        17: k_out = 32'hefbe4786;
        18: k_out = 32'h0fc19dc6;
        19: k_out = 32'h240ca1cc;
        20: k_out = 32'h2de92c6f;
        21: k_out = 32'h4a7484aa;
        22: k_out = 32'h5cb0a9dc;
        23: k_out = 32'h76f988da;
        24: k_out = 32'h983e5152;
        25: k_out = 32'ha831c66d;
        26: k_out = 32'hb00327c8;
        27: k_out = 32'hbf597fc7;
        28: k_out = 32'hc6e00bf3;
        29: k_out = 32'hd5a79147;
        30: k_out = 32'h06ca6351;
        31: k_out = 32'h14292967;
        32: k_out = 32'h27b70a85;
        33: k_out = 32'h2e1b2138;
        34: k_out = 32'h4d2c6dfc;
        35: k_out = 32'h53380d13;
        36: k_out = 32'h650a7354;
        37: k_out = 32'h766a0abb;
        38: k_out = 32'h81c2c92e;
        39: k_out = 32'h92722c85;
        40: k_out = 32'ha2bfe8a1;
        41: k_out = 32'ha81a664b;
        42: k_out = 32'hc24b8b70;
        43: k_out = 32'hc76c51a3;
        44: k_out = 32'hd192e819;
        45: k_out = 32'hd6990624;
        46: k_out = 32'hf40e3585;
        47: k_out = 32'h106aa070;
        48: k_out = 32'h19a4c116;
        49: k_out = 32'h1e376c08;
        50: k_out = 32'h2748774c;
        51: k_out = 32'h34b0bcb5;
        52: k_out = 32'h391c0cb3;
        53: k_out = 32'h4ed8aa4a;
        54: k_out = 32'h5b9cca4f;
        55: k_out = 32'h682e6ff3;
        56: k_out = 32'h748f82ee;
        57: k_out = 32'h78a5636f;
        58: k_out = 32'h84c87814;
        59: k_out = 32'h8cc70208;
        60: k_out = 32'h90befffa;
        61: k_out = 32'ha4506ceb;
        62: k_out = 32'hbef9a3f7;
        63: k_out = 32'hc67178f2;
        default: k_out = 32'b0;
    endcase
end

endmodule