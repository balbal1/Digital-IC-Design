module LSFR (
    input wire DATA, ACTIVE, CLK, RST,
    output wire Valid,
    output reg CRC
);
    
    reg [7:0] register, register_comb;
    reg CRC_comb;
    integer i;
    parameter taps = 8'b01000100;

    assign Valid =  RST ? ~ACTIVE : 1'b0;

    always @(posedge CLK, negedge RST) begin
        if (!RST) begin
            register <= 8'hD8;
            CRC <= 1'b0;
        end else begin
            register <= register_comb;
            CRC <= CRC_comb;
        end
    end

    always @(*) begin
        if (ACTIVE) begin
            CRC_comb = 1'b0;
            register_comb[7] = register[0] ^ DATA;
            for (i = 0; i < 7; i = i + 1) begin
                if (taps[i] == 1'b1)
                    register_comb[i] = register[i+1] ^ register_comb[7];
                else
                    register_comb[i] = register[i+1];
            end
        end else begin
            {register_comb[6:0], CRC_comb} = register;
        end
    end

endmodule