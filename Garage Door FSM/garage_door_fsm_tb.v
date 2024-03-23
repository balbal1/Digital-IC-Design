module garage_door_fsm_tb();

    wire UP_M_tb, DN_M_tb;
    reg UP_Max_tb, DN_Max_tb, Activate_tb, CLK_tb, RST_tb;

    garage_door_fsm garage_door_fsm(.UP_M(UP_M_tb), .DN_M(DN_M_tb), .UP_Max(UP_Max_tb), .DN_Max(DN_Max_tb), .Activate(Activate_tb), .CLK(CLK_tb), .RST(RST_tb));

    always #5 CLK_tb = ~CLK_tb;

    initial begin
        RST_tb = 1;
        CLK_tb = 0;
        Activate_tb = 0;
        UP_Max_tb = 0;
        DN_Max_tb = 0;

        #20

        RST_tb = 0;
        DN_Max_tb = 1;

        #10

        Activate_tb = 1;

        #10

        Activate_tb = 0;
        DN_Max_tb = 0;

        #50

        UP_Max_tb = 1;

        #20

        Activate_tb = 1;

        #10

        Activate_tb = 0;
        UP_Max_tb = 0;

        #50

        DN_Max_tb = 1;

        #20

        $stop();
    
    end

endmodule