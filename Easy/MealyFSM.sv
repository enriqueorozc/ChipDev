module model (
  input logic clk,
  input logic resetn,
  input logic din,
  input logic cen,
  output logic doutx,
  output logic douty 
);

  // FSM States:
  parameter S0 = 2'b00;
  parameter S1 = 3'b01;
  parameter S2 = 3'b10;

  logic [1:0] state, nextState;

  // Input Registers:
  logic dinFF, cenFF;

  // Sequential Loop:
  always_ff @(posedge clk) begin

    if (!resetn) begin
      state <= S0;
      dinFF <= 0;
      cenFF <= 0;
    end else begin
      state <= nextState;
      dinFF <= din;
      cenFF <= cen;
    end

  end

  // Next-State Logic (Combinational):
  always @* begin
    case (state)
      S0: nextState = (din == dinFF) ? S1 : S0;
      S1: nextState = (din == dinFF) ? S2 : S0;
      S2: nextState = (din == dinFF) ? S2 : S0; 
      default: nextState = S0;
    endcase
  end

  // Output Logic:
  assign doutx = (cenFF) ? (state == S1 | state == S2) : 0;
  assign douty = (cenFF) ? (state == S2) : 0;

endmodule