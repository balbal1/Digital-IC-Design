module garage_door_fsm (
    input wire UP_Max, DN_Max, Activate, CLK, RST,
    output reg UP_M, DN_M
);

    localparam IDLE = 00,
               Mv_Up = 01,
               Mv_Dn = 10;

    reg [1:0] current_state, next_state;

    always @(posedge CLK) begin
        current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            2'b00: begin
                if (Activate) begin
                    if (UP_Max)
                        next_state = 2'b10;
                    else if (DN_Max)
                        next_state = 2'b01;
                    else
                        next_state = 2'b00;
                end
            end
            2'b01: begin
                if (UP_Max)
                    next_state = 2'b00;
                else
                    next_state = 2'b01;
            end
            2'b10: begin
                if (DN_Max)
                    next_state = 2'b00;
                else
                    next_state = 2'b10;
            end
            default: next_state = 2'b00;
        endcase
    end

    always @(*) begin
        UP_M = 0;
        DN_M = 0;
        case (current_state)
            2'b01: UP_M = 1;
            2'b10: DN_M = 1;
        endcase
    end

endmodule