// and_beh_intra.v
// 2-input AND gate, behavioral modeling
// Intra-assignment delay

module and_beh_intra (
  input  a,
  input  b,
  output reg y
);

  always @(*) begin
    y = #2 a & b;
  end

endmodule