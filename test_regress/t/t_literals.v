// DESCRIPTION: Verilator: Test for literal values
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2012 by Iztok Jeras.

module t (/*AUTOARG*/
   // Inputs
   clk
   );

   input clk;

   // logic vector
   logic unsigned [15:0] luv;  // logic unsigned vector
   logic   signed [15:0] lsv;  // logic   signed vector

   int cnt = 0;
   bit mod = 1'b0;

   // event counter
   always @ (posedge clk) begin
      mod <= ~mod;
      cnt <= cnt + {31'b0, mod};
   end

   // finish report
   always @ (posedge clk)
   if (mod && (cnt==3)) begin
      $write("*-* All Finished *-*\n");
      $finish;
   end

/* verilator lint_off WIDTH */
   always @ (posedge clk)
   begin
      // unsized literals without base
      if (cnt==  0) begin if (~mod)  luv <= '0;     else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != '0",     luv); $stop(); end end end
      if (cnt==  1) begin if (~mod)  luv <= '1;     else begin if (luv !== 16'b1111_1111_1111_1111) begin $display("luv = 'b%b != '1",     luv); $stop(); end end end
      if (cnt==  2) begin if (~mod)  luv <= 'x;     else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'x",     luv); $stop(); end end end
      if (cnt==  3) begin if (~mod)  luv <= 'z;     else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'z",     luv); $stop(); end end end

      // unsized binary literals single character
      if (cnt==  4) begin if (~mod)  luv <= 'b0;    else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'b0",    luv); $stop(); end end end
      if (cnt==  5) begin if (~mod)  luv <= 'b1;    else begin if (luv !== 16'b0000_0000_0000_0001) begin $display("luv = 'b%b != 'b1",    luv); $stop(); end end end
      if (cnt==  6) begin if (~mod)  luv <= 'bx;    else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'bx",    luv); $stop(); end end end
      if (cnt==  7) begin if (~mod)  luv <= 'bz;    else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'bz",    luv); $stop(); end end end
      // unsized binary literals two characters
      if (cnt==  8) begin if (~mod)  luv <= 'b00;   else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'b00",   luv); $stop(); end end end
      if (cnt==  9) begin if (~mod)  luv <= 'b11;   else begin if (luv !== 16'b0000_0000_0000_0011) begin $display("luv = 'b%b != 'b11",   luv); $stop(); end end end
      if (cnt== 10) begin if (~mod)  luv <= 'bxx;   else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'bxx",   luv); $stop(); end end end
      if (cnt== 11) begin if (~mod)  luv <= 'bzz;   else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'bzz",   luv); $stop(); end end end
      if (cnt== 12) begin if (~mod)  luv <= 'b1x;   else begin if (luv !== 16'b0000_0000_0000_001x) begin $display("luv = 'b%b != 'b1x",   luv); $stop(); end end end
      if (cnt== 13) begin if (~mod)  luv <= 'b1z;   else begin if (luv !== 16'b0000_0000_0000_001z) begin $display("luv = 'b%b != 'b1z",   luv); $stop(); end end end
      if (cnt== 14) begin if (~mod)  luv <= 'bx1;   else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxx1) begin $display("luv = 'b%b != 'bx1",   luv); $stop(); end end end
      if (cnt== 15) begin if (~mod)  luv <= 'bz1;   else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzz1) begin $display("luv = 'b%b != 'bz1",   luv); $stop(); end end end

      // unsized binary literals single character
      if (cnt== 16) begin if (~mod)  luv <= 'o0;    else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'o0",    luv); $stop(); end end end
      if (cnt== 17) begin if (~mod)  luv <= 'o5;    else begin if (luv !== 16'b0000_0000_0000_0101) begin $display("luv = 'b%b != 'o5",    luv); $stop(); end end end
      if (cnt== 18) begin if (~mod)  luv <= 'ox;    else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'ox",    luv); $stop(); end end end
      if (cnt== 19) begin if (~mod)  luv <= 'oz;    else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'oz",    luv); $stop(); end end end
      // unsized binary literals two characters
      if (cnt== 20) begin if (~mod)  luv <= 'o00;   else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'o00",   luv); $stop(); end end end
      if (cnt== 21) begin if (~mod)  luv <= 'o55;   else begin if (luv !== 16'b0000_0000_0010_1101) begin $display("luv = 'b%b != 'o55",   luv); $stop(); end end end
      if (cnt== 22) begin if (~mod)  luv <= 'oxx;   else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'oxx",   luv); $stop(); end end end
      if (cnt== 23) begin if (~mod)  luv <= 'ozz;   else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'ozz",   luv); $stop(); end end end
      if (cnt== 24) begin if (~mod)  luv <= 'o5x;   else begin if (luv !== 16'b0000_0000_0010_1xxx) begin $display("luv = 'b%b != 'o5x",   luv); $stop(); end end end
      if (cnt== 25) begin if (~mod)  luv <= 'o5z;   else begin if (luv !== 16'b0000_0000_0010_1zzz) begin $display("luv = 'b%b != 'o5z",   luv); $stop(); end end end
      if (cnt== 26) begin if (~mod)  luv <= 'ox5;   else begin if (luv !== 16'bxxxx_xxxx_xxxx_x101) begin $display("luv = 'b%b != 'ox5",   luv); $stop(); end end end
      if (cnt== 27) begin if (~mod)  luv <= 'oz5;   else begin if (luv !== 16'bzzzz_zzzz_zzzz_z101) begin $display("luv = 'b%b != 'oz5",   luv); $stop(); end end end

      // unsized binary literals single character
      if (cnt== 28) begin if (~mod)  luv <= 'h0;    else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'h0",    luv); $stop(); end end end
      if (cnt== 29) begin if (~mod)  luv <= 'h9;    else begin if (luv !== 16'b0000_0000_0000_1001) begin $display("luv = 'b%b != 'h9",    luv); $stop(); end end end
      if (cnt== 30) begin if (~mod)  luv <= 'hx;    else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'hx",    luv); $stop(); end end end
      if (cnt== 31) begin if (~mod)  luv <= 'hz;    else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'hz",    luv); $stop(); end end end
      // unsized binary literals two characters
      if (cnt== 32) begin if (~mod)  luv <= 'h00;   else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'h00",   luv); $stop(); end end end
      if (cnt== 33) begin if (~mod)  luv <= 'h99;   else begin if (luv !== 16'b0000_0000_1001_1001) begin $display("luv = 'b%b != 'h99",   luv); $stop(); end end end
      if (cnt== 34) begin if (~mod)  luv <= 'hxx;   else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'hxx",   luv); $stop(); end end end
      if (cnt== 35) begin if (~mod)  luv <= 'hzz;   else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'hzz",   luv); $stop(); end end end
      if (cnt== 36) begin if (~mod)  luv <= 'h9x;   else begin if (luv !== 16'b0000_0000_1001_xxxx) begin $display("luv = 'b%b != 'h9x",   luv); $stop(); end end end
      if (cnt== 37) begin if (~mod)  luv <= 'h9z;   else begin if (luv !== 16'b0000_0000_1001_zzzz) begin $display("luv = 'b%b != 'h9z",   luv); $stop(); end end end
      if (cnt== 38) begin if (~mod)  luv <= 'hx9;   else begin if (luv !== 16'bxxxx_xxxx_xxxx_1001) begin $display("luv = 'b%b != 'hx9",   luv); $stop(); end end end
      if (cnt== 39) begin if (~mod)  luv <= 'hz9;   else begin if (luv !== 16'bzzzz_zzzz_zzzz_1001) begin $display("luv = 'b%b != 'hz9",   luv); $stop(); end end end

      // unsized binary literals single character
      if (cnt== 40) begin if (~mod)  luv <= 'd0;    else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'd0",    luv); $stop(); end end end
      if (cnt== 41) begin if (~mod)  luv <= 'd9;    else begin if (luv !== 16'b0000_0000_0000_1001) begin $display("luv = 'b%b != 'd9",    luv); $stop(); end end end
// TODO: this should be legal code
//      if (cnt== 42) begin if (~mod)  luv <= 'dx;    else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'dx",    luv); $stop(); end end end
//      if (cnt== 43) begin if (~mod)  luv <= 'dz;    else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'dz",    luv); $stop(); end end end
      // unsized binary literals two characters
      if (cnt== 45) begin if (~mod)  luv <= 'd00;   else begin if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 'd00",   luv); $stop(); end end end
      if (cnt== 46) begin if (~mod)  luv <= 'd99;   else begin if (luv !== 16'b0000_0000_0110_0011) begin $display("luv = 'b%b != 'd99",   luv); $stop(); end end end
//    if (cnt== 47) begin if (~mod)  luv <= 'dxx;   else begin if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 'dxx",   luv); $stop(); end end end
//    if (cnt== 48) begin if (~mod)  luv <= 'dzz;   else begin if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 'dzz",   luv); $stop(); end end end
/* verilator lint_on WIDTH */

//      // unsized binary literals single character
//      if (cnt==0)  if (mod)  luv = 15'b0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'b0",  luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'b1;   if (luv !== 16'b0000_0000_0000_0001) begin $display("luv = 'b%b != 15'b1",  luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'bx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'bx",  luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'bz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'bz",  luv); $stop(); end end end
//      // unsized binary literals two characters
//      if (cnt==0)  if (mod)  luv = 15'b00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'b00", luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'b11;  if (luv !== 16'b0000_0000_0000_0011) begin $display("luv = 'b%b != 15'b11", luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'bxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'bxx", luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'bzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'bzz", luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'b1x;  if (luv !== 16'b0000_0000_0000_001x) begin $display("luv = 'b%b != 15'b1x", luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'b1z;  if (luv !== 16'b0000_0000_0000_001z) begin $display("luv = 'b%b != 15'b1z", luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'bx1;  if (luv !== 16'b0xxx_xxxx_xxxx_xxx1) begin $display("luv = 'b%b != 15'bx1", luv); $stop(); end end end
//      if (cnt==0)  if (mod)  luv = 15'bz1;  if (luv !== 16'b0zzz_zzzz_zzzz_zzz1) begin $display("luv = 'b%b != 15'bz1", luv); $stop(); end end end
//
//      // unsized binary literals single character
//      luv = 15'o0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'o0",  luv); $stop(); end end end
//      luv = 15'o5;   if (luv !== 16'b0000_0000_0000_0101) begin $display("luv = 'b%b != 15'o5",  luv); $stop(); end end end
//      luv = 15'ox;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'ox",  luv); $stop(); end end end
//      luv = 15'oz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'oz",  luv); $stop(); end end end
//      // unsized binary literals two characters
//      luv = 15'o00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'o00", luv); $stop(); end end end
//      luv = 15'o55;  if (luv !== 16'b0000_0000_0010_1101) begin $display("luv = 'b%b != 15'o55", luv); $stop(); end end end
//      luv = 15'oxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'oxx", luv); $stop(); end end end
//      luv = 15'ozz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'ozz", luv); $stop(); end end end
//      luv = 15'o5x;  if (luv !== 16'b0000_0000_0010_1xxx) begin $display("luv = 'b%b != 15'o5x", luv); $stop(); end end end
//      luv = 15'o5z;  if (luv !== 16'b0000_0000_0010_1zzz) begin $display("luv = 'b%b != 15'o5z", luv); $stop(); end end end
//      luv = 15'ox5;  if (luv !== 16'b0xxx_xxxx_xxxx_x101) begin $display("luv = 'b%b != 15'ox5", luv); $stop(); end end end
//      luv = 15'oz5;  if (luv !== 16'b0zzz_zzzz_zzzz_z101) begin $display("luv = 'b%b != 15'oz5", luv); $stop(); end end end
//
//      // unsized binary literals single character
//      luv = 15'h0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'h0",  luv); $stop(); end end end
//      luv = 15'h9;   if (luv !== 16'b0000_0000_0000_1001) begin $display("luv = 'b%b != 15'h9",  luv); $stop(); end end end
//      luv = 15'hx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'hx",  luv); $stop(); end end end
//      luv = 15'hz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'hz",  luv); $stop(); end end end
//      // unsized binary literals two characters
//      luv = 15'h00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'h00", luv); $stop(); end end end
//      luv = 15'h99;  if (luv !== 16'b0000_0000_1001_1001) begin $display("luv = 'b%b != 15'h99", luv); $stop(); end end end
//      luv = 15'hxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'hxx", luv); $stop(); end end end
//      luv = 15'hzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'hzz", luv); $stop(); end end end
//      luv = 15'h9x;  if (luv !== 16'b0000_0000_1001_xxxx) begin $display("luv = 'b%b != 15'h9x", luv); $stop(); end end end
//      luv = 15'h9z;  if (luv !== 16'b0000_0000_1001_zzzz) begin $display("luv = 'b%b != 15'h9z", luv); $stop(); end end end
//      luv = 15'hx9;  if (luv !== 16'b0xxx_xxxx_xxxx_1001) begin $display("luv = 'b%b != 15'hx9", luv); $stop(); end end end
//      luv = 15'hz9;  if (luv !== 16'b0zzz_zzzz_zzzz_1001) begin $display("luv = 'b%b != 15'hz9", luv); $stop(); end end end
//
//      // unsized binary literals single character
//      luv = 15'd0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'd0",  luv); $stop(); end end end
//      luv = 15'd9;   if (luv !== 16'b0000_0000_0000_1001) begin $display("luv = 'b%b != 15'd9",  luv); $stop(); end end end
//      luv = 15'dx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'dx",  luv); $stop(); end end end
//      luv = 15'dz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'dz",  luv); $stop(); end end end
//      // unsized binary literals two characters
//      luv = 15'd00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("luv = 'b%b != 15'd00", luv); $stop(); end end end
//      luv = 15'd99;  if (luv !== 16'b0000_0000_0110_0011) begin $display("luv = 'b%b != 15'd99", luv); $stop(); end end end
////    luv = 15'dxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("luv = 'b%b != 15'dxx", luv); $stop(); end end end
////    luv = 15'dzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("luv = 'b%b != 15'dzz", luv); $stop(); end end end




//      // unsized binary literals single character
//      lsv = 'sb0;     if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'sb0",    lsv); $stop(); end end end
//      lsv = 'sb1;     if (lsv !== 16'b1111_1111_1111_1111) begin $display("lsv = 'b%b != 'sb1",    lsv); $stop(); end end end
//      lsv = 'sbx;     if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'sbx",    lsv); $stop(); end end end
//      lsv = 'sbz;     if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'sbz",    lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 'sb00;    if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'sb00",   lsv); $stop(); end end end
//      lsv = 'sb11;    if (lsv !== 16'b1111_1111_1111_1111) begin $display("lsv = 'b%b != 'sb11",   lsv); $stop(); end end end
//      lsv = 'sbxx;    if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'sbxx",   lsv); $stop(); end end end
//      lsv = 'sbzz;    if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'sbzz",   lsv); $stop(); end end end
//      lsv = 'sb1x;    if (lsv !== 16'b1111_1111_1111_111x) begin $display("lsv = 'b%b != 'sb1x",   lsv); $stop(); end end end
//      lsv = 'sb1z;    if (lsv !== 16'b1111_1111_1111_111z) begin $display("lsv = 'b%b != 'sb1z",   lsv); $stop(); end end end
//      lsv = 'sbx1;    if (lsv !== 16'bxxxx_xxxx_xxxx_xxx1) begin $display("lsv = 'b%b != 'sbx1",   lsv); $stop(); end end end
//      lsv = 'sbz1;    if (lsv !== 16'bzzzz_zzzz_zzzz_zzz1) begin $display("lsv = 'b%b != 'sbz1",   lsv); $stop(); end end end
//
//      // unsized binary literals single character
//      lsv = 'so0;     if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'so0",    lsv); $stop(); end end end
//      lsv = 'so5;     if (lsv !== 16'b1111_1111_1111_1101) begin $display("lsv = 'b%b != 'so5",    lsv); $stop(); end end end
//      lsv = 'sox;     if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'sox",    lsv); $stop(); end end end
//      lsv = 'soz;     if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'soz",    lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 'so00;    if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'so00",   lsv); $stop(); end end end
//      lsv = 'so55;    if (lsv !== 16'b1111_1111_1110_1101) begin $display("lsv = 'b%b != 'so55",   lsv); $stop(); end end end
//      lsv = 'soxx;    if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'soxx",   lsv); $stop(); end end end
//      lsv = 'sozz;    if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'sozz",   lsv); $stop(); end end end
//      lsv = 'so5x;    if (lsv !== 16'b0000_0000_0010_1xxx) begin $display("lsv = 'b%b != 'so5x",   lsv); $stop(); end end end
//      lsv = 'so5z;    if (lsv !== 16'b0000_0000_0010_1zzz) begin $display("lsv = 'b%b != 'so5z",   lsv); $stop(); end end end
//      lsv = 'sox5;    if (lsv !== 16'bxxxx_xxxx_xxxx_x101) begin $display("lsv = 'b%b != 'sox5",   lsv); $stop(); end end end
//      lsv = 'soz5;    if (lsv !== 16'bzzzz_zzzz_zzzz_z101) begin $display("lsv = 'b%b != 'soz5",   lsv); $stop(); end end end
//
//      // unsized binary literals single character
//      lsv = 'sh0;     if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'sh0",    lsv); $stop(); end end end
//      lsv = 'sh9;     if (lsv !== 16'b1111_1111_1111_1001) begin $display("lsv = 'b%b != 'sh9",    lsv); $stop(); end end end
//      lsv = 'shx;     if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'shx",    lsv); $stop(); end end end
//      lsv = 'shz;     if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'shz",    lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 'sh00;    if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'sh00",   lsv); $stop(); end end end
//      lsv = 'sh99;    if (lsv !== 16'b1111_1111_1001_1001) begin $display("lsv = 'b%b != 'sh99",   lsv); $stop(); end end end
//      lsv = 'shxx;    if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'shxx",   lsv); $stop(); end end end
//      lsv = 'shzz;    if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'shzz",   lsv); $stop(); end end end
//      lsv = 'sh9x;    if (lsv !== 16'b0000_0000_1001_xxxx) begin $display("lsv = 'b%b != 'sh9x",   lsv); $stop(); end end end
//      lsv = 'sh9z;    if (lsv !== 16'b0000_0000_1001_zzzz) begin $display("lsv = 'b%b != 'sh9z",   lsv); $stop(); end end end
//      lsv = 'shx9;    if (lsv !== 16'bxxxx_xxxx_xxxx_1001) begin $display("lsv = 'b%b != 'shx9",   lsv); $stop(); end end end
//      lsv = 'shz9;    if (lsv !== 16'bzzzz_zzzz_zzzz_1001) begin $display("lsv = 'b%b != 'shz9",   lsv); $stop(); end end end
//
//      // unsized binary literals single character
//      lsv = 'sd0;     if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'sd0",    lsv); $stop(); end end end
//      lsv = 'sd9;     if (lsv !== 16'b0000_0000_0000_1001) begin $display("lsv = 'b%b != 'sd9",    lsv); $stop(); end end end
//      lsv = 'sdx;     if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'sdx",    lsv); $stop(); end end end
//      lsv = 'sdz;     if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'sdz",    lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 'sd00;    if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 'sd00",   lsv); $stop(); end end end
//      lsv = 'sd99;    if (lsv !== 16'b0000_0000_0110_0011) begin $display("lsv = 'b%b != 'sd99",   lsv); $stop(); end end end
////    lsv = 'sdxx;    if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 'sdxx",   lsv); $stop(); end end end
////    lsv = 'sdzz;    if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 'sdzz",   lsv); $stop(); end end end
//
//
//      // unsized binary literals single character
//      lsv = 15'sb0;   if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'sb0",  lsv); $stop(); end end end
//      lsv = 15'sb1;   if (lsv !== 16'b0000_0000_0000_0001) begin $display("lsv = 'b%b != 15'sb1",  lsv); $stop(); end end end
//      lsv = 15'sbx;   if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'sbx",  lsv); $stop(); end end end
//      lsv = 15'sbz;   if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'sbz",  lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 15'sb00;  if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'sb00", lsv); $stop(); end end end
//      lsv = 15'sb11;  if (lsv !== 16'b0000_0000_0000_0011) begin $display("lsv = 'b%b != 15'sb11", lsv); $stop(); end end end
//      lsv = 15'sbxx;  if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'sbxx", lsv); $stop(); end end end
//      lsv = 15'sbzz;  if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'sbzz", lsv); $stop(); end end end
//      lsv = 15'sb1x;  if (lsv !== 16'b0000_0000_0000_001x) begin $display("lsv = 'b%b != 15'sb1x", lsv); $stop(); end end end
//      lsv = 15'sb1z;  if (lsv !== 16'b0000_0000_0000_001z) begin $display("lsv = 'b%b != 15'sb1z", lsv); $stop(); end end end
//      lsv = 15'sbx1;  if (lsv !== 16'b0xxx_xxxx_xxxx_xxx1) begin $display("lsv = 'b%b != 15'sbx1", lsv); $stop(); end end end
//      lsv = 15'sbz1;  if (lsv !== 16'b0zzz_zzzz_zzzz_zzz1) begin $display("lsv = 'b%b != 15'sbz1", lsv); $stop(); end end end
//
//      // unsized binary literals single character
//      lsv = 15'so0;   if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'so0",  lsv); $stop(); end end end
//      lsv = 15'so5;   if (lsv !== 16'b0000_0000_0000_0101) begin $display("lsv = 'b%b != 15'so5",  lsv); $stop(); end end end
//      lsv = 15'sox;   if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'sox",  lsv); $stop(); end end end
//      lsv = 15'soz;   if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'soz",  lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 15'so00;  if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'so00", lsv); $stop(); end end end
//      lsv = 15'so55;  if (lsv !== 16'b0000_0000_0010_1101) begin $display("lsv = 'b%b != 15'so55", lsv); $stop(); end end end
//      lsv = 15'soxx;  if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'soxx", lsv); $stop(); end end end
//      lsv = 15'sozz;  if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'sozz", lsv); $stop(); end end end
//      lsv = 15'so5x;  if (lsv !== 16'b0000_0000_0010_1xxx) begin $display("lsv = 'b%b != 15'so5x", lsv); $stop(); end end end
//      lsv = 15'so5z;  if (lsv !== 16'b0000_0000_0010_1zzz) begin $display("lsv = 'b%b != 15'so5z", lsv); $stop(); end end end
//      lsv = 15'sox5;  if (lsv !== 16'b0xxx_xxxx_xxxx_x101) begin $display("lsv = 'b%b != 15'sox5", lsv); $stop(); end end end
//      lsv = 15'soz5;  if (lsv !== 16'b0zzz_zzzz_zzzz_z101) begin $display("lsv = 'b%b != 15'soz5", lsv); $stop(); end end end
//
//      // unsized binary literals single character
//      lsv = 15'sh0;   if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'sh0",  lsv); $stop(); end end end
//      lsv = 15'sh9;   if (lsv !== 16'b0000_0000_0000_1001) begin $display("lsv = 'b%b != 15'sh9",  lsv); $stop(); end end end
//      lsv = 15'shx;   if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'shx",  lsv); $stop(); end end end
//      lsv = 15'shz;   if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'shz",  lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 15'sh00;  if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'sh00", lsv); $stop(); end end end
//      lsv = 15'sh99;  if (lsv !== 16'b0000_0000_1001_1001) begin $display("lsv = 'b%b != 15'sh99", lsv); $stop(); end end end
//      lsv = 15'shxx;  if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'shxx", lsv); $stop(); end end end
//      lsv = 15'shzz;  if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'shzz", lsv); $stop(); end end end
//      lsv = 15'sh9x;  if (lsv !== 16'b0000_0000_1001_xxxx) begin $display("lsv = 'b%b != 15'sh9x", lsv); $stop(); end end end
//      lsv = 15'sh9z;  if (lsv !== 16'b0000_0000_1001_zzzz) begin $display("lsv = 'b%b != 15'sh9z", lsv); $stop(); end end end
//      lsv = 15'shx9;  if (lsv !== 16'b0xxx_xxxx_xxxx_1001) begin $display("lsv = 'b%b != 15'shx9", lsv); $stop(); end end end
//      lsv = 15'shz9;  if (lsv !== 16'b0zzz_zzzz_zzzz_1001) begin $display("lsv = 'b%b != 15'shz9", lsv); $stop(); end end end
//
//      // unsized binary literals single character
//      lsv = 15'sd0;   if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'sd0",  lsv); $stop(); end end end
//      lsv = 15'sd9;   if (lsv !== 16'b0000_0000_0000_1001) begin $display("lsv = 'b%b != 15'sd9",  lsv); $stop(); end end end
//      lsv = 15'sdx;   if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'sdx",  lsv); $stop(); end end end
//      lsv = 15'sdz;   if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'sdz",  lsv); $stop(); end end end
//      // unsized binary literals two characters
//      lsv = 15'sd00;  if (lsv !== 16'b0000_0000_0000_0000) begin $display("lsv = 'b%b != 15'sd00", lsv); $stop(); end end end
//      lsv = 15'sd99;  if (lsv !== 16'b0000_0000_0110_0011) begin $display("lsv = 'b%b != 15'sd99", lsv); $stop(); end end end
////    lsv = 15'sdxx;  if (lsv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("lsv = 'b%b != 15'sdxx", lsv); $stop(); end end end
////    lsv = 15'sdzz;  if (lsv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("lsv = 'b%b != 15'sdzz", lsv); $stop(); end end end
   end

endmodule // test
