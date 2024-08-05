module model #(parameter
  DATA_WIDTH = 16,
  MAX = 99
) (
  input clk,
  input reset, start, stop,
  output logic [DATA_WIDTH-1:0] count
);

  logic activeCount;

  always_ff @(posedge clk) begin

    if (reset) begin
      activeCount <= 0;
      count <= 0;
    end else if (stop) begin
      activeCount <= 0;
    end else if (start || activeCount) begin
      count <= (count == MAX) ? 0 : (count + 1);
      activeCount <= 1;
    end 

  end

endmodule