module model #(parameter
  DATA_WIDTH = 32
) (
  input [DATA_WIDTH-1:0] din,
  output logic dout
);

  logic [DATA_WIDTH-1:0] dinReversed;

  // Reverse Bits:
  always @* begin
    for (int i = 0; i < DATA_WIDTH; i++) begin
      dinReversed[i] = din[(DATA_WIDTH - 1) - i];
    end
  end

  assign dout = (dinReversed == din);

endmodule