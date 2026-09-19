// and_df.v
// 2-input AND gate, dataflow modeling

module and_df (
  input  a,
  input  b,
  output y
);

  assign #2 y = a & b;

endmodule