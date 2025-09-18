module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

  // FSM States:
  localparam 
    S0 = 3'b000,
    S1 = 3'b001,
    S10 = 3'b010,
    S101 = 3'b011,
    S1010 = 3'b100;
  
  logic [2:0] state, nextState;

  // Next-State Logic (Combinational):
  always_comb begin
    case (state)

      S0: begin
        nextState = (din) ? S1 : S0;
      end

      S1: begin
        nextState = (din) ? S1 : S10;
      end

      S10: begin
        nextState = (din) ? S101 : S0;
      end

      S101: begin
        nextState = (din) ? S1 : S1010;
      end

      S1010: begin
        nextState = (din) ? S101 : S0;
      end

      default: nextState = S0;
    endcase
  end

  // Next-State Logic (Sequential):
  always_ff @(posedge clk) begin
    if (!resetn) begin
      state <= S0;
    end else begin
      state <= nextState;
    end
  end

  assign dout = (state == S1010);

endmodule