// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2003 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

module t (/*AUTOARG*/
   // Inputs
   clk
   );
   input clk;

   localparam int unsigned DLY = 3;

   logic [7:0] cyc = '0;
   logic [7:0] tmp [0:DLY-1] = '{DLY{'0}};
   logic [7:0] out;

   always @ (posedge clk) begin
      $write("[%0t] cyc=%02X out=%02X\n", $time, cyc, out);
      for (int unsigned i=0; i<DLY; i++) begin
         $write("[%0t] tmp=%p\n", $time, tmp[i]);
      end
      cyc <= cyc + 1;
      if      (cyc==8'd0)  begin  if (out != 8'd0)  $stop;  end
      else if (cyc==8'd1)  begin  if (out != 8'd0)  $stop;  end
      else if (cyc==8'd2)  begin  if (out != 8'd0)  $stop;  end
      else if (cyc==8'd3)  begin  if (out != 8'd0)  $stop;  end
      else if (cyc==8'd4)  begin  if (out != 8'd1)  $stop;  end
      else if (cyc==8'd5)  begin  if (out != 8'd2)  $stop;  end
      else if (cyc==8'd6) begin
         $write("*-* All Finished *-*\n");
         $finish;
      end
   end

   // delay line
   generate
   if (DLY == 0) begin

      assign out = cyc;

   end else begin

     always_ff @(posedge clk)
     begin
        tmp[0] <= cyc;
     end

     for (genvar i=1; i<DLY; i++) begin

        always_ff @(posedge clk)
        begin
           tmp[i] <= tmp[i-1];
        end

     end

     assign out = tmp[DLY-1];

  end
  endgenerate

endmodule
