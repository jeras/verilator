// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2012 by Iztok Jeras.

module t (/*AUTOARG*/
   // Inputs
   clk
   );

   input clk;

   integer cnt = 0;
   integer mod = 0;

   // event counter
   always @ (posedge clk)
   if (cnt==10) begin
      cnt <= 0;
      mod <= mod + 1;
   end else begin
      cnt <= cnt + 1;
   end

   // finish report
   always @ (posedge clk)
   if (mod==3) begin
      $write("*-* All Finished *-*\n");
      $finish;
   end

   // anonymous type variable declaration
   enum logic [2:0] {red=1, orange, yellow, green, blue, indigo, violet} rainbow7;

   // named type
   typedef enum logic {OFF, ON} t_switch;
   t_switch switch;

   // numbering examples
   enum int {father, mother, son[2], doughter, gerbil, dog[3]=10, cat[2:5]=20, car[3:1]=30} family;

   // test of raibow7 type
   always @ (posedge clk)
   if (mod==0) begin
      // write value to array
      if      (cnt== 0)  begin
         rainbow7 <= rainbow7.first();
         // check number
         if (rainbow7.num()  !== 7      ) begin $display("%d", rainbow7.num() ); $stop(); end
         if (rainbow7        !== 3'bxxx ) begin $display("%b", rainbow7       ); $stop(); end
      end
      else if (cnt== 1)  begin
         if (rainbow7        !== 3'd1   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== red    ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "red"   ) begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
      else if (cnt== 2)  begin
         if (rainbow7        !== 3'd2   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== orange ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "orange") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
      else if (cnt== 3)  begin
         if (rainbow7        !== 3'd3   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== yellow ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "yellow") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
      else if (cnt== 4)  begin
         if (rainbow7        !== 3'd4   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== green  ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "green" ) begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
      else if (cnt== 5)  begin
         if (rainbow7        !== 3'd5   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== blue   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "blue"  ) begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
      else if (cnt== 6)  begin
         if (rainbow7        !== 3'd6   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== indigo ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "indigo") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
      else if (cnt== 7)  begin
         if (rainbow7        !== 3'd7   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== violet ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "violet") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
      else if (cnt== 8)  begin
         if (rainbow7        !== 3'd1   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== red    ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "red"   ) begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.next();
      end
   end
   else if (mod==1) begin
      // write value to array
      if      (cnt== 0)  begin
         rainbow7 <= rainbow7.last();
         // check number
         if (rainbow7.num()  !== 7      ) begin $display("%d", rainbow7.num() ); $stop(); end
      end
      else if (cnt== 1)  begin
         if (rainbow7        !== 3'd7   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== violet ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "violet") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
      else if (cnt== 2)  begin
         if (rainbow7        !== 3'd6   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== indigo ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "indigo") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
      else if (cnt== 3)  begin
         if (rainbow7        !== 3'd5   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== blue   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "blue"  ) begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
      else if (cnt== 4)  begin
         if (rainbow7        !== 3'd4   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== green  ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "green" ) begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
      else if (cnt== 5)  begin
         if (rainbow7        !== 3'd3   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== yellow ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "yellow") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
      else if (cnt== 6)  begin
         if (rainbow7        !== 3'd2   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== orange ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "orange") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
      else if (cnt== 7)  begin
         if (rainbow7        !== 3'd1   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== red    ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "red"   ) begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
      else if (cnt== 8)  begin
         if (rainbow7        !== 3'd7   ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7        !== violet ) begin $display("%b", rainbow7       ); $stop(); end
         if (rainbow7.name() != "violet") begin $display("%s", rainbow7.name()); $stop(); end
         rainbow7 <= rainbow7.prev();
      end
   end

   // test of t_switch type
   always @ (posedge clk)
   if (mod==0) begin
      // write value to array
      if      (cnt== 0)  begin
         switch <= switch.first();
         // check number
         if (switch.num()  !== 2   ) begin $display("%d", switch.num() ); $stop(); end
         if (switch        !== 1'bx) begin $display("%b", switch       ); $stop(); end
      end
      else if (cnt== 1)  begin
         if (switch        !== 1'b0) begin $display("%b", switch       ); $stop(); end
         if (switch        !== OFF ) begin $display("%b", switch       ); $stop(); end
         if (switch.name() != "OFF") begin $display("%s", switch.name()); $stop(); end
         switch <= switch.next();
      end
      else if (cnt== 2)  begin
         if (switch        !== 1'b1) begin $display("%b", switch       ); $stop(); end
         if (switch        !== ON  ) begin $display("%b", switch       ); $stop(); end
         if (switch.name() != "ON" ) begin $display("%s", switch.name()); $stop(); end
         switch <= switch.next();
      end
      else if (cnt== 3)  begin
         if (switch        !== 1'b0) begin $display("%b", switch       ); $stop(); end
         if (switch        !== OFF ) begin $display("%b", switch       ); $stop(); end
         if (switch.name() != "OFF") begin $display("%s", switch.name()); $stop(); end
         switch <= switch.next();
      end
   end else if (mod==1) begin
      // write value to array
      if      (cnt== 0)  begin
         rainbow7 <= rainbow7.last();
         // check number
         if (switch.num()  !== 2   ) begin $display("%d", switch.num() ); $stop(); end
      end
      else if (cnt== 1)  begin
         if (switch        !== 1'b1) begin $display("%b", switch       ); $stop(); end
         if (switch        !== ON  ) begin $display("%b", switch       ); $stop(); end
         if (switch.name() != "ON" ) begin $display("%s", switch.name()); $stop(); end
         switch <= switch.prev();
      end
      else if (cnt== 2)  begin
         if (switch        !== 1'b0) begin $display("%b", switch       ); $stop(); end
         if (switch        !== OFF ) begin $display("%b", switch       ); $stop(); end
         if (switch.name() != "OFF") begin $display("%s", switch.name()); $stop(); end
         switch <= switch.prev();
      end
      else if (cnt== 3)  begin
         if (switch        !== 1'b1) begin $display("%b", switch       ); $stop(); end
         if (switch        !== ON  ) begin $display("%b", switch       ); $stop(); end
         if (switch.name() != "ON" ) begin $display("%s", switch.name()); $stop(); end
         switch <= switch.prev();
      end
   end

endmodule
