module model #(parameter
  DATA_WIDTH = 32
) (
  input clk,
  input resetn,
  input [DATA_WIDTH-1:0] din,
  output logic [DATA_WIDTH-1:0] dout
);

  // [1] = Second, [0] = First
  logic [1:0] [DATA_WIDTH-1:0] priorityQueue;

  always_ff @(posedge clk) begin

    if (!resetn) begin
      priorityQueue[0] <= 0;
      priorityQueue[1] <= 0;
    end else begin

      if (din > priorityQueue[0]) begin
        priorityQueue[0] <= din;
        priorityQueue[1] <= priorityQueue[0];
      end else if (din > priorityQueue[1]) begin
        priorityQueue[1] <= din;
      end

    end

  end

  assign dout = priorityQueue[1];

endmodule