module SHIFT_UNIT #(parameter width = 16)
(
    input wire [width-1:0] A, B,
    input wire [1:0] ALU_FUN_Lower,
    input wire SHIFT_Enable, CLK, RST,
    output reg [width:0] SHIFT_OUT,
    output reg SHIFT_Flag
);
    
    reg [width:0] SHIFT_OUT_Comb;

    always @(*) begin
        if (SHIFT_Enable) begin
            SHIFT_OUT_Comb = 'b0;
            case (ALU_FUN_Lower)
                2'b00: SHIFT_OUT_Comb = A >> 1;
                2'b01: SHIFT_OUT_Comb = A << 1;
                2'b10: SHIFT_OUT_Comb = B >> 1;
                2'b11: SHIFT_OUT_Comb = B << 1;
            endcase
        end else begin
            SHIFT_OUT_Comb = 'b0;
        end
    end

    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            SHIFT_OUT <= 'b0;
            SHIFT_Flag <= 1'b0;
        end else begin
            SHIFT_OUT <= SHIFT_OUT_Comb;
            SHIFT_Flag <= SHIFT_Enable;
        end
    end

endmodule