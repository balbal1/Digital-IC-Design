module lOGIC_UNIT #(parameter width = 16)
(
    input wire [width-1:0] A, B,
    input wire [1:0] ALU_FUN_Lower,
    input wire Logic_Enable, CLK, RST,
    output reg [width-1:0] Logic_OUT,
    output reg Logic_Flag
);
    
    reg [width-1:0] Logic_OUT_Comb;

    always @(*) begin
        if (Logic_Enable) begin
            Logic_OUT_Comb = 'b0;
            case (ALU_FUN_Lower)
                2'b00: Logic_OUT_Comb = A & B;
                2'b01: Logic_OUT_Comb = A | B;
                2'b10: Logic_OUT_Comb = ~(A & B);
                2'b11: Logic_OUT_Comb = ~(A | B);
            endcase
        end else begin
            Logic_OUT_Comb = 'b0;
        end
    end

    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            Logic_OUT <= 'b0;
            Logic_Flag <= 1'b0;
        end else begin
            Logic_OUT <= Logic_OUT_Comb;
            Logic_Flag <= Logic_Enable;
        end
    end

endmodule