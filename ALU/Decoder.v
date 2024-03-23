module Decoder (
    input wire [1:0] ALU_FUN_Upper,
    output reg Arith_Enable, Logic_Enable, CMP_Enable, SHIFT_Enable
);
    
    always @(*) begin
        Arith_Enable = 1'b0;
        Logic_Enable = 1'b0;
        CMP_Enable = 1'b0;
        SHIFT_Enable = 1'b0;
        case (ALU_FUN_Upper)
            2'b00: Arith_Enable = 1'b1;
            2'b01: Logic_Enable = 1'b1;
            2'b10: CMP_Enable = 1'b1;
            2'b11: SHIFT_Enable = 1'b1;
        endcase
    end

endmodule