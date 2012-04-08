// DESCRIPTION: Verilator: SystemVerilog interface test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2012 by Iztok Jeras.

module t (/*AUTOARG*/
   // Inputs
   clk
   );

   input clk;

   // counters
   int cnt;
   int cnt_src;
   int cnt_drn;

   // add all counters
   assign cnt = cnt_src + cnt_drn + inf.cnt;

   // finish report
   always @ (posedge clk)
   if (cnt == 3*16) begin
      $write("*-* All Finished *-*\n");
      $finish;
   end

   // interface instance
   handshake inf;

   // source instance
   source #(
      .RW  (8),
      .RP  (8'b)  // 
   ) source (
      .clk  (clk),
      .rst  (rst),
      .inf  (inf),
      .cnt  (cnt_src)
   );

   // drain instance
   drain #(
      .RW  (8),
      .RP  (8'b)  // 
   ) drain (
      .clk  (clk),
      .rst  (rst),
      .inf  (inf),
      .cnt  (cnt_drn)
   );

endmodule : t


// interface definition
interface handshake #(
   parameter int unsigned WC = 32
)(
   input logic clk,
   input logic rst
);

   // modport signals
   logic req;  // request
   logic grt;  // grant
   logic inc;  // increment

   // local signals
   integer cnt;  // counter

   // source
   modport src (
      output req,
      input  grt
   );

   // drain
   modport drn (
      input  req,
      output grt
   );

   // incremet condition
   assign inc = req & grt;

   // local logic (counter)
   always @ (posedge clk, posedge rst)
   if (rst) cnt <= '0;
   else     cnt <= cnt + inc;

endinterface : handshake


// source module
module source #(
   // random generator parameters
   parameter int unsigned RW,    // LFSR width
   parameter bit [RW-1:0] RP,    // LFSR polinom
   parameter bit [RW-1:0] RR='1  // LFSR reset state
)(
   input logic    clk,
   input logic    rst,
   handshake.src  inf
   output integer cnt;
);

   // LFSR
   [RW-1:0] rnd;

   // LFSR in Galois form
   always @ (posedge clk, posedge rst)
   if (rst) rnd <= RR;
   else     rnd <= {rnd[0], rnd[RW-1:1]} ^ ({RW{rnd[0]}} & RP);

   // counter
   always @ (posedge clk, posedge rst)
   if (rst) cnt <= 32'd0;
   else     cnt <= cnt + (inf.req & inf.grt);

   // request signal
   assign inf.req = rnd[0];

endmodule : source


// drain module
module drain #(
   // random generator parameters
   parameter int unsigned RW,    // LFSR width
   parameter bit [RW-1:0] RP,    // LFSR polinom
   parameter bit [RW-1:0] RR='1  // LFSR reset state
)(
   input logic    clk,
   input logic    rst,
   handshake.drn  inf
   output integer cnt;
);

   // LFSR
   [RW-1:0] rnd;

   // LFSR in Galois form
   always @ (posedge clk, posedge rst)
   if (rst) rnd <= RR;
   else     rnd <= {rnd[0], rnd[RW-1:1]} ^ ({RW{rnd[0]}} & RP);

   // counter
   always @ (posedge clk, posedge rst)
   if (rst) cnt <= 32'd0;
   else     cnt <= cnt + (inf.req & inf.grt);

   // grant signal
   assign inf.grt = rnd[0];

endmodule : drain
