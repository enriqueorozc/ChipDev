module model #(parameter
  DATA_WIDTH = 32
) (
  input  [DATA_WIDTH-1:0] din,
  output logic [$clog2(DATA_WIDTH):0] dout
);
  
  logic activeCount;

  always @* begin

    // Initialization:
    dout = {$clog2(DATA_WIDTH){1'b0}};
    activeCount = 1'b1;

    for (int i = (DATA_WIDTH - 1); i >= 0; i--) begin

      // Case 0: Count Trailing Zeros
      if (activeCount == 1'b1 && din[i] == 1'b0) begin
        dout++;
      end

      // Case 1: Turn Off Counter
      else if (activeCount == 1'b1 && din[i] == 1'b1) begin
        dout = {$clog2(DATA_WIDTH){1'b0}};
        activeCount = 1'b0;
      end

      // Case 2: Turn On Counter
      else if (activeCount == 1'b0 && din[i] == 1'b0) begin
        dout = 1;
        activeCount = 1'b1;
      end 

    end
  end

endmodule