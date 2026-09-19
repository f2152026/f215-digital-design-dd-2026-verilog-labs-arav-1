// dut.v
// Wrapper module: pick exactly ONE of the three implementations below by
// leaving it uncommented, with the other two commented out. Compile and
// run tb.v, then switch to a different implementation and repeat -- this
// lets you compare rca.v, cla4.v, and cla4_dataflow.v using the exact same
// testbench and stimulus each time.
module FA_Gate(
  input  a,
  input  b,
  input  cin,
  output sum,
  output cout
);

  wire ps, pc1, pc2;

  xor #(2,3) (ps,   a,   b);
  and #(2,3) (pc1,  a,   b);
  xor #(2,3) (sum, cin, ps);
  and #(2,3) (pc2, cin, ps);
  or  #(2,3) (cout, pc1, pc2);

endmodule
module dut(
  input  [3:0] a,
  input  [3:0] b,
  input        cin,
  output [3:0] sum,
  output       cout
);

  // ---- Option 1: delayed ripple-carry adder ----
  rca U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  // ---- Option 2: gate-level carry-lookahead adder ----
  // cla4 U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

  // ---- Option 3: dataflow carry-lookahead adder ----
  // cla4_dataflow U_IMPL (.a(a), .b(b), .cin(cin), .sum(sum), .cout(cout));

endmodule
