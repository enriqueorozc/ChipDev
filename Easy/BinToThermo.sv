module model (
  input [7:0] din,
  output reg [255:0] dout
);

  always_comb begin
    for (int i = 0; i < 256; i++) begin
      dout[i] = (i < (din + 1));
    end
  end

endmodule