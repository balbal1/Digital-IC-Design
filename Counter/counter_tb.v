module counter_tb ();
    
    wire High_tb, Low_tb;
    wire [4:0] Counter_tb;
    reg Load_tb, Up_tb, Down_tb, CLK_tb;
    reg [4:0] IN_tb;

    counter counter(.Load(Load_tb), .Up(Up_tb), .Down(Down_tb), .CLK(CLK_tb), .IN(IN_tb), .High(High_tb), .Low(Low_tb), .Counter(Counter_tb));

    always #5 CLK_tb = ~CLK_tb;

    initial begin
        CLK_tb = 1'b0;
        Load_tb = 1'b0;
        Up_tb = 1'b0;
        Down_tb = 1'b0;
        IN_tb = 1'b0;

        #20

        Load_tb = 1'b1;
        IN_tb = 5'b00101;

        #10

        if (Counter_tb != 5'b00101) begin
            $display("Error in Test case 1");
        end
        Load_tb = 1'b0;
        Down_tb = 1'b1;

        #60
        
        if (Counter_tb != 5'b0000) begin
            $display("Error in Test case 2");
        end
        Down_tb = 1'b0;
        Up_tb = 1'b1;

        #60

        if (Counter_tb != 5'b00110) begin
            $display("Error in Test case 3");
        end
        Load_tb = 1'b1;
        IN_tb = 5'b11101;

        #10
        
        if (Counter_tb != 5'b11101) begin
            $display("Error in Test case 4");
        end
        Load_tb = 1'b0;

        #30

        if (Counter_tb != 5'b11111) begin
            $display("Error in Test case 5");
        end
        Down_tb = 1'b1;

        #40
        
        if (Counter_tb != 5'b11011) begin
            $display("Error in Test case 6");
        end

        $stop;
    end

endmodule