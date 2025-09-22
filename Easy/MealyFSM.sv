module model (
  input logic clk,
  input logic resetn,
  input logic din,
  input logic cen,
  output logic doutx,
  output logic douty 
);

  // FSM States:
  typedef enum logic [2:0] {
    S0,
    S1,
    S2
  } statetype;

  statetype state, nextState;

  // Value Registers:
  logic dinFF, cenFF;

  // Next-State + Reset Logic (Sequential):
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
  always_comb begin
    case (state)
      S0: nextState = (din == dinFF) ? S1 : S0;
      S1: nextState = (din == dinFF) ? S2 : S0;
      S2: nextState = (din == dinFF) ? S2 : S0;
    endcase
  end

  assign doutx = (cenFF) && (state == S1 || state == S2);
  assign douty = (cenFF) && (state == S2); 

endmodule