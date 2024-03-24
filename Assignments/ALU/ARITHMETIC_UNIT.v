module ARITHMETIC_UNIT #(parameter width = 16)
(
    input wire signed [width-1:0] A, B,
    input wire [1:0] ALU_FUN_Lower,
    input wire Arith_Enable, CLK, RST,
    output reg signed [(width*2)-1:0] Arith_OUT,
    output reg Carry_OUT,
    output reg Arith_Flag
);
    
    reg [(width*2)-1:0] Arith_OUT_Comb;
    wire Carry_OUT_Comb;
    assign Carry_OUT_Comb = Arith_OUT_Comb[width];

    always @(*) begin
        if (Arith_Enable) begin
            Arith_OUT_Comb = 'b0;
            case (ALU_FUN_Lower)
                2'b00: Arith_OUT_Comb = A + B;
                2'b01: Arith_OUT_Comb = A - B;
                2'b10: Arith_OUT_Comb = A * B;
                2'b11: Arith_OUT_Comb = A / B;
            endcase
        end else begin
            Arith_OUT_Comb = 'b0;
        end
    end

    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            Arith_OUT <= 'b0;
            Carry_OUT <= 1'b0;
            Arith_Flag <= 1'b0;
        end else begin
            Arith_OUT <= Arith_OUT_Comb;
            Carry_OUT <= Carry_OUT_Comb;
            Arith_Flag <= Arith_Enable;
        end
    end

endmodule