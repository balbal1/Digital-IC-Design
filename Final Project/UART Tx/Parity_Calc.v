module Parity_Calc #(parameter DATA_WIDTH = 8) (
    input Data_Valid, Par_Typ,
    input [DATA_WIDTH-1:0] P_Data,
    output reg Par_Bit
);

    always @(posedge Data_Valid) begin
        if (Par_Typ)
            Par_Bit = !(^P_Data);
        else
            Par_Bit = ^P_Data;
    end
    
endmodule