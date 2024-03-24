module Control_FSM #(parameter DATA_WIDTH = 8) (
    input Data_Valid, Par_En, Ser_Done, CLK, RST,
    input [DATA_WIDTH-1:0] P_Data,
    output Busy, Ser_En,
    output [1:0] Mux_Sel
);

    localparam IDLE   = 3'b000;
    localparam START  = 3'b101;
    localparam DATA   = 3'b111;
    localparam PARITY = 3'b110;
    localparam STOP   = 3'b100;
    
    reg [2:0] current_state = IDLE, next_state = IDLE;

    assign Busy = current_state[2];
    assign Mux_Sel = current_state[1:0];
    assign Ser_En = (current_state == DATA);

    always @(posedge CLK) begin
        if (!RST)
            current_state = IDLE;
        else
            current_state = next_state;
    end

    always @(*) begin
        case (current_state)
            IDLE: begin
                if (Data_Valid)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: next_state = DATA;
            DATA: begin
                if (Ser_Done)
                    if (Par_En)
                        next_state = PARITY;
                    else
                        next_state = STOP;
                else
                    next_state = DATA;
            end
            PARITY: next_state = STOP;
            STOP: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
    
endmodule