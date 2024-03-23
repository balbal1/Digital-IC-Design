module LFST_tb ();
    
    reg DATA_tb, ACTIVE_tb, CLK_tb, RST_tb;
    wire CRC_tb, Valid_tb;

    reg [7:0] test_cases [0:9];
    reg [7:0] expected_outputs [0:9];
    integer i, j;

    LSFR LSFR(.DATA(DATA_tb), .ACTIVE(ACTIVE_tb), .CLK(CLK_tb), .RST(RST_tb), .CRC(CRC_tb), .Valid(Valid_tb));
    integer success_count = 0;
    
    always #5 CLK_tb = ~CLK_tb;

    initial begin
        CLK_tb = 0;
        ACTIVE_tb = 0;
        $readmemh("DATA_h.txt", test_cases);
        $readmemh("Expec_Out_h.txt", expected_outputs);

        for (j = 0; j < 10; j = j + 1) begin
            reset();
            input_data(test_cases[j]);
            check_output(expected_outputs[j]);
        end

        $display("success count: %0d", success_count);

        $stop;
    
    end

    task reset; begin
        RST_tb = 0;
        #10
        RST_tb = 1;
    end
    endtask

    task input_data (input [7:0] IN_Seed); begin
        ACTIVE_tb = 1;
        for (i = 0; i < 8; i = i + 1) begin
            DATA_tb = IN_Seed[i];
            #10;
        end
    end
    endtask

    task check_output (input [7:0] OUT_Seed); begin
        ACTIVE_tb = 0;
        for (i = 0; i < 8; i = i + 1) begin
            #10
            if (CRC_tb !== OUT_Seed[i])
                $display("Error at case %0h, index: %0d, CRC: %1b, expected: %1b", OUT_Seed, i, CRC_tb, OUT_Seed[i]);
            else
                success_count = success_count + 1;
        end
    end
    endtask


endmodule