// and_beh_before.v
// 2-input AND gate, behavioral modeling
// Delay before assignment

module and_beh_before (
  input  a,
  input  b,
  output reg y
);

  always @(*) begin
    #2 y = a & b;
  end

endmodule