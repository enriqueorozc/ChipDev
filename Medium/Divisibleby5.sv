module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

  // FSM States:
  parameter INIT = 3'b000;
  parameter R0 = 3'b001;
  parameter R1 = 3'b010;
  parameter R2 = 3'b011;
  parameter R3 = 3'b100;
  parameter R4 = 3'b101;
  parameter R5 = 3'b110;

  logic [2:0] state, nextState;

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
      INIT: nextState = (din) ? R1 : R0;
      R0: nextState = (din) ? R1 : R0;
      R1: nextState = (din) ? R3 : R2;
      R2: nextState = (din) ? R0 : R4;
      R3: nextState = (din) ? R2 : R1;
      R4: nextState = (din) ? R4 : R3;
      default: nextState = INIT;
    endcase
  end

  assign dout = (state == R0);

endmodule