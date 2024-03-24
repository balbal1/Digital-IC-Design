`timescale 1us/1us
module alu_tb ();
    
    localparam width_tb = 16;

    reg signed [width_tb-1:0] A_tb, B_tb;
    reg [3:0] ALU_FUN_tb;
    reg CLK_tb, RST_tb;
    wire signed [(width_tb*2)-1:0] Arith_OUT_tb;
    wire [width_tb-1:0] Logic_OUT_tb, CMP_OUT_tb;
    wire [width_tb:0] SHIFT_OUT_tb;
    wire Carry_OUT_tb, Arith_Flag_tb, Logic_Flag_tb, CMP_Flag_tb, SHIFT_Flag_tb;
    // wire [(width_tb*2)-1:0] ALU_OUT_tb = 'b0;
    integer errors = 0;

    // assign ALU_OUT_tb = Arith_OUT_tb | Logic_OUT_tb | CMP_OUT_tb | SHIFT_OUT_tb;

    ALU_TOP #(.width(width_tb)) ALU_TOP(.A(A_tb), .B(B_tb), .ALU_FUN(ALU_FUN_tb), .CLK(CLK_tb), .RST(RST_tb), .Arith_OUT(Arith_OUT_tb), .Logic_OUT(Logic_OUT_tb), .CMP_OUT(CMP_OUT_tb), .SHIFT_OUT(SHIFT_OUT_tb), .Carry_OUT(Carry_OUT_tb), .Arith_Flag(Arith_Flag_tb), .Logic_Flag(Logic_Flag_tb), .CMP_Flag(CMP_Flag_tb), .SHIFT_Flag(SHIFT_Flag_tb));

    always begin
        #4 CLK_tb = ~CLK_tb;
        #6 CLK_tb = ~CLK_tb;
    end

    initial begin
        CLK_tb = 1'b0;
        RST_tb = 1'b0;
        ALU_FUN_tb = 4'b1000;
        A_tb = 'b0;
        B_tb = 'b0;

        #20
        
        RST_tb = 1'b1;
        ALU_FUN_tb = 4'h8;
        
        $display("Test Case 1: No Operation");
        if (Arith_OUT_tb == 'd0 && Logic_OUT_tb == 'd0 && CMP_OUT_tb == 'd0 && SHIFT_OUT_tb == 'd0)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end
        
        ALU_FUN_tb = 4'h0;
        A_tb = -'d5600;
        B_tb = -'d12000;
        #10
        $display("Test Case 2: %0d + %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == -'d17600 && Carry_OUT_tb == 1'b1)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 3: %0d + %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == -'d5180 && Carry_OUT_tb == 1'b1)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        A_tb = 'd7200;
        B_tb = -'d12000;
        #10
        $display("Test Case 4: %0d + %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == -'d4800 && Carry_OUT_tb == 1'b1)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 5: %0d + %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd7620 && Carry_OUT_tb == 1'b0)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'h1;
        A_tb = -'d5600;
        B_tb = -'d12000;
        #10
        $display("Test Case 6: %0d - %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd6400 && Carry_OUT_tb == 1'b0)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 7: %0d - %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == -'d6020 && Carry_OUT_tb == 1'b1)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        A_tb = 'd7200;
        B_tb = -'d12000;
        #10
        $display("Test Case 8: %0d - %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd19200 && Carry_OUT_tb == 1'b0)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 9: %0d - %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd6780 && Carry_OUT_tb == 1'b0)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'h2;
        A_tb = -'d5600;
        B_tb = -'d12000;
        #10
        $display("Test Case 10: %0d * %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd67200000)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 11: %0d * %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == -'d2352000)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        A_tb = 'd7200;
        B_tb = -'d12000;
        #10
        $display("Test Case 12: %0d * %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == -'d86400000)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 13: %0d * %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd3024000)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'h3;
        A_tb = -'d5600;
        B_tb = -'d12000;
        #10
        $display("Test Case 14: %0d / %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd0)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 15: %0d / %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == -'d13)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        A_tb = 'd7200;
        B_tb = -'d12000;
        #10
        $display("Test Case 16: %0d / %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd0)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        B_tb = 'd420;
        #10
        $display("Test Case 17: %0d / %0d = %0d", A_tb, B_tb, Arith_OUT_tb);
        if (Arith_OUT_tb == 'd17)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        A_tb = 'h61A8;
        B_tb = 'h1388;
        ALU_FUN_tb = 4'h4;
        #10
        $display("Test Case 18: %0d and %0d = %0d", A_tb, B_tb, Logic_OUT_tb);
        if (Logic_OUT_tb == 'h0188)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'h5;
        #10
        $display("Test Case 19: %0d or %0d = %0d", A_tb, B_tb, Logic_OUT_tb);
        if (Logic_OUT_tb == 'h73A8)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'h6;
        #10
        $display("Test Case 20: %0d nand %0d = %0d", A_tb, B_tb, Logic_OUT_tb);
        if (Logic_OUT_tb == 'hFE77)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'h7;
        #10
        $display("Test Case 21: %0d nor %0d = %0d", A_tb, B_tb, Logic_OUT_tb);
        if (Logic_OUT_tb == 'h8C57)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'h9;
        #10
        $display("Test Case 22: is %0d == %0d ?", A_tb, B_tb);
        if (CMP_OUT_tb == 'h0000)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'hA;
        #10
        $display("Test Case 23: is %0d > %0d ?", A_tb, B_tb);
        if (CMP_OUT_tb == 'h0002)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'hB;
        #10
        $display("Test Case 24: is %0d < %0d ?", A_tb, B_tb);
        if (CMP_OUT_tb == 'h0000)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'hC;
        #10
        $display("Test Case 25: %0d >> 1 = %0d", A_tb, SHIFT_OUT_tb);
        if (SHIFT_OUT_tb == 'h30D4)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'hD;
        #10
        $display("Test Case 26: %0d << 1 = %0d", A_tb, SHIFT_OUT_tb);
        if (SHIFT_OUT_tb == 'hC350)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'hE;
        #10
        $display("Test Case 27: %0d >> 1 = %0d", B_tb, SHIFT_OUT_tb);
        if (SHIFT_OUT_tb == 'h09C4)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        ALU_FUN_tb = 4'hF;
        #10
        $display("Test Case 28: %0d << 1 = %0d", B_tb, SHIFT_OUT_tb);
        if (SHIFT_OUT_tb == 'h2710)
            $display("Test Passed Successfully");
        else begin
            $display("Test Failed");
            errors = errors + 1;
        end

        if (errors == 0) begin
            $display("Simulation Done: No Errors in Any Test Case!");
        end else begin
            $display("Simulation Done: %0d Erros Found in Test Cases!", errors);
        end

        $stop;

    end

endmodule