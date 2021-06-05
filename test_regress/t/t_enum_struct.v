// DESCRIPTION: Verilator: SystemVerilog Test of enumerations of a struct
// packed type.
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2009 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

module t (/*AUTOARG*/);

   // RISC-V ISA encoding
   // func3 R-type (immediate)
   typedef enum logic [3-1:0] {
      ADD  = 3'b000,  // func7[5] ? SUB : ADD
      SL   = 3'b001,  //
      SLT  = 3'b010,  //
      SLTU = 3'b011,  //
      XOR  = 3'b100,  //
      SR   = 3'b101,  // func7[5] ? SRA : SRL
      OR   = 3'b110,  //
      AND  = 3'b111   //
   } op32_r_func3_t;

   // ALU operation structure {func7[5], func3}
   typedef struct packed {
      logic          f7_5;
      op32_r_func3_t f3;
   } alu_t;

   // ALU operation enumeration {func7[5], func3}
   typedef enum alu_t {
      AO_ADD  = {1'b0, ADD },  // addition
      AO_SUB  = {1'b1, ADD },  // subtraction
      AO_SLL  = {1'b?, SL  },  // shift left logical
      AO_SLT  = {1'b?, SLT },  // set less then   signed (not greater then or equal)
      AO_SLTU = {1'b?, SLTU},  // set less then unsigned (not greater then or equal)
      AO_XOR  = {1'b?, XOR },  // logic XOR
      AO_SRL  = {1'b0, SR  },  // shift right logical
      AO_SRA  = {1'b1, SR  },  // shift right arithmetic
      AO_OR   = {1'b?, OR  },  // logic OR
      AO_AND  = {1'b?, AND }   // logic AND
   } alu_et;

   // enumerated command
   alu_t  cmd;
   // decoded operation
   string op;

   initial begin
 
      for (int unsigned i=0; i<16; i++) begin

          cmd = i[3:0];

	  unique casez (cmd)
             // adder based instructions
             AO_ADD : op = "additiona";
             AO_SUB : op = "subtraction";
             AO_SLT : op = "set less then";
             AO_SLTU: op = "set less then unsigned";
             // bitwise logical operations
             AO_AND : op = "and";
             AO_OR  : op = "or";
             AO_XOR : op = "xor";
             // barrel shifter
             AO_SRA : op = "shift right arithmetic";
             AO_SRL : op = "shift right logical";
             AO_SLL : op = "shift left logical";
             default: op = "undefined";
          endcase      

	  if (op == "undefined") $stop;

      end

      $write("*-* All Finished *-*\n");
      $finish;
   end

endmodule
