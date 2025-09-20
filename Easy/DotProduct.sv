module model (
    input [7:0] din,
    input clk,
    input resetn,
    output reg [17:0] dout,
    output reg run
);

  // Counter Register:
  logic [2:0] count;

  // Array + Partial Additions Registers:
  logic [7:0] numbers [5:0];
  logic [15:0] a1b1, a2b2, a3b3;

  // Counter Logic (Sequential):
  always_ff @(posedge clk) begin
    if (!resetn || count == 5) begin
      count <= 0;
    end else begin
      count <= count + 1;
    end
  end
  
  // Receiving Numbers:
  always_ff @(posedge clk) begin
    if (!resetn) begin
      numbers[0] <= 0;
      numbers[1] <= 0;
      numbers[2] <= 0;
      numbers[3] <= 0;
      numbers[4] <= 0;
      numbers[5] <= 0;
    end else begin
      numbers[count] <= din;
    end
  end

  // Combinational Logic:
  assign run = (count == 0);
  assign a1b1 = (run) ? numbers[0] * numbers[3] : a1b1;
  assign a2b2 = (run) ? numbers[1] * numbers[4] : a2b2;
  assign a3b3 = (run) ? numbers[2] * numbers[5] : a3b3;
  assign dout = a1b1 + a2b2 + a3b3;

endmodule