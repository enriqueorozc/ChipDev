module model (
  input clk,
  input resetn,
  input din,
  output logic dout
);

  logic [3:0] bitHistory;

  always_ff @(posedge clk) begin

    if (!resetn)
      bitHistory <= 0;
    else
      bitHistory <= {bitHistory[2:0], din};

  end

  assign dout = (bitHistory == 4'b1010);

endmodule