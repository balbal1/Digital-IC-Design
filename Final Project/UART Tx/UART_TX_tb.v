module UART_TX_tb ();

    localparam DATA_WIDTH_tb = 8;

    reg Data_Valid_tb, Par_En_tb, Par_Typ_tb, CLK_tb, RST_tb;
    reg [DATA_WIDTH_tb-1:0] P_Data_tb;
    wire Busy_tb, TX_Out_tb;

    UART_TX #(.DATA_WIDTH(DATA_WIDTH_tb)) UART_TX(.Data_Valid(Data_Valid_tb), .Par_En(Par_En_tb), .Par_Typ(Par_Typ_tb), .CLK(CLK_tb), .RST(RST_tb), .P_Data(P_Data_tb), .Busy(Busy_tb), .TX_Out(TX_Out_tb));

    always #5 CLK_tb = ~CLK_tb;

    initial begin
        CLK_tb = 1'b0;
        RST_tb = 1'b1;
        Data_Valid_tb = 1'b0;
        Par_En_tb = 1'b0;
        Par_Typ_tb = 1'b0;
        P_Data_tb = 8'h00;

        #10
        RST_tb = 1'b0;
        #10
        RST_tb = 1'b1;
        #40

        // test with no parity
        P_Data_tb = 8'h57;
        Data_Valid_tb = 1'b1;
        #10
        Data_Valid_tb = 1'b0;
        #100

        // test with even parity
        P_Data_tb = 8'hA2;
        Par_En_tb = 1'b1;
        Data_Valid_tb = 1'b1;
        #10
        Data_Valid_tb = 1'b0;
        #110

        // test with odd parity
        P_Data_tb = 8'h6E;
        Par_Typ_tb = 1'b1;
        Data_Valid_tb = 1'b1;
        #10
        Data_Valid_tb = 1'b0;
        #110
        
        $stop();
    end

endmodule