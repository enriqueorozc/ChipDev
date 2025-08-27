module model (
  input clk,
  input resetn,
  output logic div2,
  output logic div4,
  output logic div6
);

  logic clockCount2;
  logic [1:0] clockCount4;
  logic [3:0] clockCount6;

  always_ff @(posedge clk) begin
    if (!resetn) begin
      clockCount2 <= 0;
      clockCount4 <= 0;
      clockCount6 <= 0;
    end else begin
      clockCount2 <= clockCount2 + 1;
      clockCount4 <= clockCount4 + 1;
      clockCount6 <= (clockCount6 + 1) % 6;
    end
  end

  // Maintaining Duty Cycle:
  assign div2 = (clockCount2 == 1);
  assign div4 = (clockCount4 == 1 || clockCount4 == 2);
  assign div6 = (clockCount6 == 1 || clockCount6 == 2 || clockCount6 == 3);

endmodule