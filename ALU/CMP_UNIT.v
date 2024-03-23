module CMP_UNIT #(parameter width = 16)
(
    input wire [width-1:0] A, B,
    input wire [1:0] ALU_FUN_Lower,
    input wire CMP_Enable, CLK, RST,
    output reg [width-1:0] CMP_OUT,
    output reg CMP_Flag
);
    
    reg [width-1:0] CMP_OUT_Comb;

    always @(*) begin
        if (CMP_Enable) begin
            CMP_OUT_Comb = 'b0;
            case (ALU_FUN_Lower)
                2'b00: CMP_OUT_Comb = 'b0;
                2'b01: begin
                    if (A == B)
                        CMP_OUT_Comb = 'b1;
                    else
                        CMP_OUT_Comb = 'b0;
                end
                2'b10: begin
                    if (A > B)
                        CMP_OUT_Comb = 'b10;
                    else
                        CMP_OUT_Comb = 'b0;
                end
                2'b11: begin
                    if (A < B)
                        CMP_OUT_Comb = 'b11;
                    else
                        CMP_OUT_Comb = 'b0;
                end
            endcase
        end else begin
            CMP_OUT_Comb = 'b0;
        end
    end

    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            CMP_OUT <= 'b0;
            CMP_Flag <= 1'b0;
        end else begin
            CMP_OUT <= CMP_OUT_Comb;
            CMP_Flag <= CMP_Enable;
        end
    end

endmodule