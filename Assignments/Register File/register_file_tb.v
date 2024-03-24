module register_file_tb ();
    
    reg [15:0] WrData_tb;
    reg [3:0] Address_tb;
    reg WrEn_tb, RdEn_tb, CLK_tb, RST_tb;
    wire [15:0] RdData_tb;

    register_file register_file(.WrData(WrData_tb), .Address(Address_tb), .WrEn(WrEn_tb), .RdEn(RdEn_tb), .CLK(CLK_tb), .RST(RST_tb), .RdData(RdData_tb));

    always #5 CLK_tb = ~CLK_tb;

    initial begin
        CLK_tb = 1'b0;
        RST_tb = 1'b0;
        WrEn_tb = 1'b0;
        RdEn_tb = 1'b0;
        WrData_tb = 16'b0;
        Address_tb = 4'b0;

        #20

        RST_tb = 1'b1;
        RdEn_tb = 1'b1;
        #10
        if (RdData_tb != 16'b0) begin
            $display("Error in Test Case 1");
        end

        RdEn_tb = 1'b0;
        WrEn_tb = 1'b1;
        Address_tb = 4'h3;
        WrData_tb = 16'h57C2;
        #10

        WrEn_tb = 1'b0;
        RdEn_tb = 1'b1;
        WrData_tb = 16'b0;
        #10
        if (RdData_tb != 16'h57C2) begin
            $display("Error in Test Case 2");
        end

        RdEn_tb = 1'b0;
        WrEn_tb = 1'b1;
        Address_tb = 4'h5;
        WrData_tb = 16'hA86D;
        #10

        WrEn_tb = 1'b0;
        RdEn_tb = 1'b1;
        WrData_tb = 16'b0;
        #10
        if (RdData_tb != 16'hA86D) begin
            $display("Error in Test Case 3");
        end

        Address_tb = 4'h3;
        #10
        if (RdData_tb != 16'h57C2) begin
            $display("Error in Test Case 4");
        end

        $stop;
    end

endmodule