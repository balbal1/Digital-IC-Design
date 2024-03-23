module register_file (
    input wire [15:0] WrData,
    input wire [3:0] Address,
    input wire WrEn, RdEn, CLK, RST,
    output reg [15:0] RdData
);

    reg [15:0] Reg_File [0:7];

    always @(*) begin
        if (RdEn) begin
            case (Address)
                4'h0: RdData <= Reg_File[0];
                4'h1: RdData <= Reg_File[1];
                4'h2: RdData <= Reg_File[2];
                4'h3: RdData <= Reg_File[3];
                4'h4: RdData <= Reg_File[4];
                4'h5: RdData <= Reg_File[5];
                4'h6: RdData <= Reg_File[6];
                4'h7: RdData <= Reg_File[7];
            endcase
        end else begin
            RdData = 16'b0;
        end
    end

    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            Reg_File[0] <= 16'b0;
            Reg_File[1] <= 16'b0;
            Reg_File[2] <= 16'b0;
            Reg_File[3] <= 16'b0;
            Reg_File[4] <= 16'b0;
            Reg_File[5] <= 16'b0;
            Reg_File[6] <= 16'b0;
            Reg_File[7] <= 16'b0;
        end else if (WrEn) begin
            case (Address)
                4'h0: Reg_File[0] <= WrData;
                4'h1: Reg_File[1] <= WrData;
                4'h2: Reg_File[2] <= WrData;
                4'h3: Reg_File[3] <= WrData;
                4'h4: Reg_File[4] <= WrData;
                4'h5: Reg_File[5] <= WrData;
                4'h6: Reg_File[6] <= WrData;
                4'h7: Reg_File[7] <= WrData;
            endcase
        end
    end

endmodule