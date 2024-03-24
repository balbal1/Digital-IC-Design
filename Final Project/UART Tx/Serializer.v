module Serializer #(parameter DATA_WIDTH = 8) (
    input Ser_En, Data_Valid, CLK,
    input [DATA_WIDTH-1:0] P_Data,
    output Ser_Done,
    output reg Ser_Data
);
    
    reg [DATA_WIDTH-1:0] Sampled_Data = 0;
    reg [2:0] counter = 3'b000;

    assign Ser_Done = (counter == DATA_WIDTH-1);

    always @(posedge CLK) begin
        if (Ser_Done) begin
            counter = 3'b000;
        end else begin
            if (Data_Valid)
                Sampled_Data = P_Data;
            if (Ser_En)
                counter = counter + 1;
        end
    end

    always @(*) begin
        case (counter)
            3'b000: Ser_Data = Sampled_Data[0];
            3'b001: Ser_Data = Sampled_Data[1];
            3'b010: Ser_Data = Sampled_Data[2];
            3'b011: Ser_Data = Sampled_Data[3];
            3'b100: Ser_Data = Sampled_Data[4];
            3'b101: Ser_Data = Sampled_Data[5];
            3'b110: Ser_Data = Sampled_Data[6];
            3'b111: Ser_Data = Sampled_Data[7];
            default: Ser_Data = 1'b1;
        endcase
    end

endmodule