module counter (
    input wire Load, Up, Down, CLK,
    input wire [4:0] IN,
    output wire High, Low,
    output reg [4:0] Counter
);
    
    reg [4:0] mux_out = 5'b00000;

    always @(*) begin
        if (Load == 1'b1) begin
            mux_out = IN;
        end else if (Down == 1'b1 && !Low) begin
            mux_out = Counter - 1'b1;
        end else if (Up == 1'b1 && !High) begin
            mux_out = Counter + 1'b1;
        end else begin
            mux_out = Counter;
        end
    end

    always @(posedge CLK) begin
        Counter = mux_out;
    end

    assign High = (Counter == 5'b11111);
    assign Low = (Counter == 5'b00000);

endmodule