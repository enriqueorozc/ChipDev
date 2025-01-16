module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

  // FSM States:
  parameter INIT = 2'b00;
  parameter R0 = 2'b01;
  parameter R1 = 2'b10;
  parameter R2 = 2'b11;

  logic [1:0] state, nextState;

  // Sequential Loop:
  always_ff @(posedge clk) begin

    if (!resetn) begin
      state <= INIT;
    end else begin
      state <= nextState;
    end
    
  end

  // Next-State Loop (Combinational):
  always @* begin
    case (state)
      INIT: nextState = (din) ? R1 : INIT;
      R0: nextState = (din) ? R1 : R0;
      R1: nextState = (din) ? R0 : R1;
      R2: nextState = (din) ? R1 : R2;
      default: nextState = INIT;
    endcase
  end

  assign dout = (state == R0);

endmodule