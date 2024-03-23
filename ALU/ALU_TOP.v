module ALU_TOP #(parameter width = 16)
(
    input wire [width-1:0] A, B,
    input wire [3:0] ALU_FUN,
    input wire CLK, RST,
    output wire [(width*2)-1:0] Arith_OUT,
    output wire [width-1:0] Logic_OUT, CMP_OUT,
    output wire [width:0] SHIFT_OUT,
    output wire Carry_OUT, Arith_Flag, Logic_Flag, CMP_Flag, SHIFT_Flag
);

    wire Arith_Enable, Logic_Enable, CMP_Enable, SHIFT_Enable;
    wire [1:0] ALU_FUN_Upper, ALU_FUN_Lower;

    assign ALU_FUN_Upper = ALU_FUN[3:2];
    assign ALU_FUN_Lower = ALU_FUN[1:0];

    Decoder Decoder(.ALU_FUN_Upper(ALU_FUN_Upper), .Arith_Enable(Arith_Enable), .Logic_Enable(Logic_Enable), .CMP_Enable(CMP_Enable), .SHIFT_Enable(SHIFT_Enable));
    ARITHMETIC_UNIT #(.width(width)) ARITHMETIC_UNIT(.A(A), .B(B), .ALU_FUN_Lower(ALU_FUN_Lower), .Arith_Enable(Arith_Enable), .CLK(CLK), .RST(RST), .Arith_OUT(Arith_OUT), .Carry_OUT(Carry_OUT), .Arith_Flag(Arith_Flag));
    lOGIC_UNIT #(.width(width)) lOGIC_UNIT(.A(A), .B(B), .ALU_FUN_Lower(ALU_FUN_Lower), .Logic_Enable(Logic_Enable), .CLK(CLK), .RST(RST), .Logic_OUT(Logic_OUT), .Logic_Flag(Logic_Flag));
    CMP_UNIT #(.width(width)) CMP_UNIT(.A(A), .B(B), .ALU_FUN_Lower(ALU_FUN_Lower), .CMP_Enable(CMP_Enable), .CLK(CLK), .RST(RST), .CMP_OUT(CMP_OUT), .CMP_Flag(CMP_Flag));
    SHIFT_UNIT #(.width(width)) SHIFT_UNIT(.A(A), .B(B), .ALU_FUN_Lower(ALU_FUN_Lower), .SHIFT_Enable(SHIFT_Enable), .CLK(CLK), .RST(RST), .SHIFT_OUT(SHIFT_OUT), .SHIFT_Flag(SHIFT_Flag));

endmodule