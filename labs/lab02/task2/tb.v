// tb.v
// Testbench for the parameterized ROM

module tb;

  // sel needs 3 bits because DEPTH = 8
  reg [2:0] t_sel;

  // dout comes from the DUT
  wire [7:0] t_dout;

  // Instantiate LUT with parameter override
  // IMPORTANT: instance is named DUT so the given
  // $dumpvars(0, DUT) line works unchanged.
  lut #(
    .WIDTH(8),
    .DEPTH(8)
  ) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Test every valid address
  integer i;

  initial begin
    for (i = 0; i < 8; i = i + 1) begin

      t_sel = i;

      #5;

      if (t_dout !== i * i)
        $display("FAIL: sel=%0d, expected=%0d, got=%0d",
                 i, i * i, t_dout);
      else
        $display("PASS: sel=%0d, dout=%0d",
                 i, t_dout);

    end

    $finish;
  end

  // Monitor signals
  initial
    $monitor($time, " sel=%b | dout=%d", t_sel, t_dout);

endmodule