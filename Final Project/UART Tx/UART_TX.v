module UART_TX #(parameter DATA_WIDTH = 8) (
    input Data_Valid, Par_En, Par_Typ, CLK, RST,
    input [DATA_WIDTH-1:0] P_Data,
    output Busy,
    output reg TX_Out
);
    
    wire Ser_En, Ser_Done, Ser_Data, Par_Bit;
    wire [1:0] Mux_Sel;

    Control_FSM #(.DATA_WIDTH(DATA_WIDTH)) Control_FSM(.Data_Valid(Data_Valid), .Par_En(Par_En), .Ser_Done(Ser_Done), .CLK(CLK), .RST(RST), .P_Data(P_Data), .Busy(Busy), .Ser_En(Ser_En), .Mux_Sel(Mux_Sel));
    Serializer #(.DATA_WIDTH(DATA_WIDTH)) Serializer(.Ser_En(Ser_En), .Data_Valid(Data_Valid), .CLK(CLK), .P_Data(P_Data), .Ser_Data(Ser_Data), .Ser_Done(Ser_Done));
    Parity_Calc #(.DATA_WIDTH(DATA_WIDTH)) Parity_Calc(.Data_Valid(Data_Valid), .Par_Typ(Par_Typ), .P_Data(P_Data), .Par_Bit(Par_Bit));

    always @(*) begin
        case (Mux_Sel)
            2'b00: TX_Out = 1'b1;
            2'b01: TX_Out = 1'b0;
            2'b10: TX_Out = Par_Bit;
            2'b11: TX_Out = Ser_Data;
            default: TX_Out = 1'b1;
        endcase
    end

endmodule