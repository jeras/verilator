// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2009 by Iztok Jeras.

module t (/*AUTOARG*/
  // Inputs
  clk
);

  input clk;

  // parameters for array sizes
  localparam WA = 6;  // address dimension size
  localparam WB = 8;  // bit     dimension size

  integer n;
  integer i;

  // 2D packed arrays
  logic        [WA-1:0] [WB-1:0] array_bg;  // big endian array
  /* verilator lint_off LITENDIAN */
  logic        [0:WA-1] [0:WB-1] array_lt;  // little endian array
  /* verilator lint_on LITENDIAN */

  integer cnt = 0;

  // event counter
  always @ (posedge clk)
  begin
    cnt <= cnt + 1;
  end

  // finish report
  always @ (posedge clk)
  if (cnt==1) begin
    $write("*-* All Finished *-*\n");
    $finish;
  end

  initial begin
    // big endian array
    if ($dimensions (array_bg   ) != 2    ) $stop;
    if ($bits       (array_bg   ) != WA*WB) $stop;
    // dimension 1
    if ($left       (array_bg, 1) != WA-1 ) $stop;
    if ($right      (array_bg, 1) != 0    ) $stop;
    if ($low        (array_bg, 1) != 0    ) $stop;
    if ($high       (array_bg, 1) != WA-1 ) $stop;
    if ($increment  (array_bg, 1) != 1    ) $stop;
    if ($size       (array_bg, 1) != WA   ) $stop;
    // dimension 2
    if ($left       (array_bg, 2) != WB-1 ) $stop;
    if ($right      (array_bg, 2) != 0    ) $stop;
    if ($low        (array_bg, 2) != 0    ) $stop;
    if ($high       (array_bg, 2) != WB-1 ) $stop;
    if ($increment  (array_bg, 2) != 1    ) $stop;
    if ($size       (array_bg, 2) != WB   ) $stop;

    // little endian array
    if ($dimensions (array_lt   ) != 2    ) $stop;
    if ($bits       (array_lt   ) != WA*WB) $stop;
    // dimension 1
    if ($left       (array_lt, 1) != 0    ) $stop;
    if ($right      (array_lt, 1) != WA-1 ) $stop;
    if ($low        (array_lt, 1) != 0    ) $stop;
    if ($high       (array_lt, 1) != WA-1 ) $stop;
    if ($increment  (array_lt, 1) != -1   ) $stop;
    if ($size       (array_lt, 1) != WA   ) $stop;
    // dimension 2
    if ($left       (array_lt, 2) != 0    ) $stop;
    if ($right      (array_lt, 2) != WB-1 ) $stop;
    if ($low        (array_lt, 2) != 0    ) $stop;
    if ($high       (array_lt, 2) != WB-1 ) $stop;
    if ($increment  (array_lt, 2) != -1   ) $stop;
    if ($size       (array_lt, 2) != WB   ) $stop;
  end

endmodule
