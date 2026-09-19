// tb.v
// Self-checking testbench for the 4-bit ALU

module tb;

  // DUT inputs
  reg [3:0] t_a;
  reg [3:0] t_b;
  reg       t_op;

  // DUT output
  wire [3:0] t_result;

  // Expected result
  reg [3:0] expected;

  // Counters
  integer errors;
  integer total;

  // Loop variables
  integer a_val;
  integer b_val;

  // Instantiate ALU
  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Waveform dump configuration
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Watch signals while simulation runs
  initial begin
    $monitor(
      $time,
      " a=%b b=%b op=%b | result=%b",
      t_a, t_b, t_op, t_result
    );
  end

  // Main self-checking test
  initial begin

    errors = 0;
    total  = 0;

    // Test both operations for every possible pair of 4-bit operands
    for (a_val = 0; a_val < 16; a_val = a_val + 1) begin

      for (b_val = 0; b_val < 16; b_val = b_val + 1) begin

        // -------------------------
        // Test addition: op = 0
        // -------------------------

        t_a  = a_val;
        t_b  = b_val;
        t_op = 0;

        expected = a_val + b_val;

        #1;

        total = total + 1;

        if (t_result !== expected) begin

          $display(
            "FAIL: ADD  a=%0d b=%0d | got=%0d expected=%0d",
            a_val, b_val, t_result, expected
          );

          errors = errors + 1;

        end

        // -------------------------
        // Test subtraction: op = 1
        // -------------------------

        t_a  = a_val;
        t_b  = b_val;
        t_op = 1;

        expected = a_val - b_val;

        #1;

        total = total + 1;

        if (t_result !== expected) begin

          $display(
            "FAIL: SUB  a=%0d b=%0d | got=%0d expected=%0d",
            a_val, b_val, t_result, expected
          );

          errors = errors + 1;

        end

      end

    end

    // Final summary
    $display("");
    $write(
      "SUMMARY: %0d/%0d tests passed",
      total - errors,
      total
    );

    if (errors == 0)
      $display(" — ALL TESTS PASSED");
    else
      $display(" — %0d test(s) failed", errors);

    $finish;

  end

endmodule