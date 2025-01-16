// Bonus Version - Same Cycle As Edge

module model (
  input clk,
  input resetn,
  input din,
  output dout
);

  logic inLast;

  always_ff @(posedge clk) begin

    if (!resetn) begin
      inLast <= 0;
    end else begin
      inLast <= din;
    end

  end

  assign dout = (!inLast && din);

endmodule