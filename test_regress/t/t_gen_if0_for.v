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

  // TCB widths
  localparam int unsigned ABW = 32;       // address bus width
  localparam int unsigned DBW = 32;       // data    bus width
  localparam int unsigned SLW =       8;  // selection   width
  localparam int unsigned BEW = DBW/SLW;  // byte enable width
  // response delay
  localparam int unsigned DLY = 2;

  // system signals
//  logic clk;  // clock
  logic rst;  // reset

  // response
  logic [DBW-1:0] rdt;  // read data
  logic           err;  // error response

  tcb_if #(.ABW (ABW), .DBW (DBW), .DLY (DLY)) tcb (.clk (clk), .rst (rst));

  // clock
//  initial          clk = 1'b1;
//  always #(20ns/2) clk = ~clk;

  // test sequence
  initial
  begin
    // reset sequence
    rst = 1'b1;
    repeat (2) @(posedge clk);
    #1;
    rst = 1'b0;
    repeat (1) @(posedge clk);
    fork
      begin: req
        man.req(1'b0, 32'h00000000, 4'b1111, 32'hXXXXXXXX);
        man.rsp(rdt, err);
      end: req
      begin: rsp
        sub.rsp(32'h76543210, 1'b0);
      end: rsp
    join
    repeat (4) @(posedge clk);
    if (rdt != 32'h76543210)  $stop;
    repeat (4) @(posedge clk);
    $write("*-* All Finished *-*\n");
    $finish();
  end

  // manager
  tcb_vip_man man (.tcb (tcb));

  // subordinate
  tcb_vip_sub sub (.tcb (tcb));

endmodule: t


interface tcb_if #(
  // TCB widths
  int unsigned ABW = 32,       // address bus width
  int unsigned DBW = 32,       // data    bus width
  int unsigned SLW =       8,  // selection   width
  int unsigned BEW = DBW/SLW,  // byte enable width
  // response delay
  int unsigned DLY = 1
)(
  // system signals
  input  logic clk,  // clock
  input  logic rst   // reset
);

////////////////////////////////////////////////////////////////////////////////
// I/O ports
////////////////////////////////////////////////////////////////////////////////

  // handshake
  logic           vld;  // handshake valid
  // request
  logic           wen;  // write enable
  logic [ABW-1:0] adr;  // address
  logic [BEW-1:0] ben;  // byte enable
  logic [DBW-1:0] wdt;  // write data
  // request optional
  logic           lck;  // arbitration lock
  logic           rpt;  // repeat access
  // response
  logic [DBW-1:0] rdt;  // read data
  logic           err;  // error response
  // handshake
  logic           rdy;  // handshake ready

////////////////////////////////////////////////////////////////////////////////
// internal signals (never outpus on modports)
////////////////////////////////////////////////////////////////////////////////

  logic           trn;  // transfer
  logic           idl;  // idle
  logic           rsp;  // response

  // transfer (valid and ready at the same time)
  assign trn = vld & rdy;

  // TODO: improve description
  // idle (either not valid or currently ending a cycle with a transfer)
  assign idl = ~vld | trn;

  // response valid (DLY clock periods after transfer)
  generate
  if (DLY == 0) begin: gen_rsp
    assign rsp = trn;
  end: gen_rsp
  // response delay queue
  else begin: gen_dly
    if (DLY == 1) begin: gen_rsp
      always @(posedge clk, posedge rst)
      if (rst) begin
        rsp <= 1'b0;
      end else begin
        rsp <= trn;
      end
    end: gen_rsp
    else begin: gen_dly
      logic [DLY-1:0] que;
      assign rsp = que[DLY-1];
      always @(posedge clk, posedge rst)
      if (rst) begin
        que <= '0;
      end else begin
        que <= {que[DLY-2:0], trn};
      end
    end: gen_dly
  end: gen_dly
  endgenerate

endinterface: tcb_if


module tcb_vip_man (
  // TCB interface
  tcb_if tcb
);

  initial  tcb.vld = 1'b0;

  // request
  task req (
    // request
    input  logic               wen,
    input  logic [tcb.ABW-1:0] adr,
    input  logic [tcb.BEW-1:0] ben,
    input  logic [tcb.DBW-1:0] wdt,
    // request optional
    input  logic               lck = 1'b0,
    input  logic               rpt = 1'b0,
    // timing idle
    input  int unsigned        idl = 0
  );
    // request timing
    repeat (idl) @(posedge tcb.clk);
    // drive transfer
    #1;
    // hanshake
    tcb.vld = 1'b1;
    // request
    tcb.wen = wen;
    tcb.adr = adr;
    tcb.ben = ben;
    tcb.wdt = wdt;
    // request optional
    tcb.lck = lck;
    tcb.rpt = rpt;
    // backpressure
    do begin
      @(posedge tcb.clk);
    end while (~tcb.rdy);
    // drive idle/undefined
    #1;
    // handshake
    tcb.vld = 1'b0;
    // request
    tcb.wen = 'x;
    tcb.adr = 'x;
    tcb.ben = 'x;
    tcb.wdt = 'x;
    // request optional
    tcb.lck = 'x;
    tcb.rpt = 'x;
  endtask: req

  // response task
  task rsp (
    output logic [tcb.DBW-1:0] rdt,
    output logic               err
  );
    // response delay
    do begin
      @(posedge tcb.clk);
    end while (~tcb.rsp);
    // response
    rdt = tcb.rdt;
    err = tcb.err;
  endtask: rsp

  // generic write
  task write (
    // request
    input  logic [tcb.ABW-1:0] adr,
    input  logic [tcb.BEW-1:0] ben,
    input  logic [tcb.DBW-1:0] dat,
    // response
    output logic               err,
    // request optional
    input  logic               lck = 1'b0,
    input  logic               rpt = 1'b0
  );
    // ignored value
    logic [tcb.DBW-1:0] rdt;
    // request
    req (
      .wen (1'b1),
      .adr (adr),
      .ben (ben),
      .wdt (dat),
      .lck (lck),
      .rpt (rpt)
    );
    // response
    rsp (
      .rdt (rdt),
      .err (err)
    );
  endtask: write

  // generic read
  task read (
    // request
    input  logic [tcb.ABW-1:0] adr,
    input  logic [tcb.BEW-1:0] ben,
    output logic [tcb.DBW-1:0] dat,
    // response
    output logic               err,
    // request optional
    input  logic               lck = 1'b0,
    input  logic               rpt = 1'b0
  );
    // request
    req (
      .wen (1'b0),
      .adr (adr),
      .ben (ben),
      .wdt ('x),
      .lck (lck),
      .rpt (rpt)
    );
    // response
    rsp (
      .rdt (dat),
      .err (err)
    );
  endtask: read

endmodule: tcb_vip_man


module tcb_vip_sub (
  // TCB interface
  tcb_if tcb
);

  // response pipeline
  logic [tcb.DBW-1:0] tmp_rdt;
  logic               tmp_err;
  logic [tcb.DBW-1:0] pip_rdt [0:tcb.DLY-1];
  logic               pip_err [0:tcb.DLY-1];

  // request
  task req (
    output logic               wen,
    output logic [tcb.ABW-1:0] adr,
    output logic [tcb.BEW-1:0] ben,
    output logic [tcb.DBW-1:0] wdt,
    output logic               lck,
    output logic               rpt
  );
    // check for backpressure
    do begin
      @(posedge tcb.clk);
    end while (~tcb.rdy);
    // idle
    wen = tcb.wen;
    adr = tcb.adr;
    ben = tcb.ben;
    wdt = tcb.wdt;
    lck = tcb.lck;
    rpt = tcb.rpt;
  endtask: req

  // response
  task rsp (
    // tcb signals
    input  logic [tcb.DBW-1:0] rdt,
    input  logic               err,
    // timing
    input  int unsigned        tmg = 0
  );
    // response
    tmp_rdt = rdt;
    tmp_err = err;
    if (tmg == 0) begin
      // ready
      tcb.rdy = 1'b1;
      // wait for transfer
      do begin
        @(posedge tcb.clk);
      end while (~tcb.trn);
    end
    // idle
    #1;
    tmp_rdt = 'x;
    tmp_err = 'x;
  endtask: rsp

  generate
  if (tcb.DLY == 0) begin

    initial begin
      $display("tcb.DLY == 0: DLY = %d", tcb.DLY);
    end

    assign tcb.rdt = tcb.rsp ? tmp_rdt : 'x;
    assign tcb.err = tcb.rsp ? tmp_err : 'x;

  end else begin

    initial begin
      $display("else: DLY = %d", tcb.DLY);
    end

    always_ff @(posedge tcb.clk)
    if (tcb.trn) begin
      pip_rdt[0] <= tmp_rdt;
      pip_err[0] <= tmp_err;
    end else begin
      pip_rdt[0] <= 'x;
      pip_err[0] <= 1'bx;
    end

    for (genvar i=1; i<tcb.DLY; i++) begin

      initial begin
        $display("for: DLY = %d, genvar i = %d", tcb.DLY, i);
      end

      always_ff @(posedge tcb.clk)
      begin
        // --Verilator debug line
        $display("DLY = %d, genvar i = %d", tcb.DLY, i);
        pip_rdt[i] <= pip_rdt[i-1];
        pip_err[i] <= pip_err[i-1];
      end

    end

    assign tcb.rdt = tcb.rsp ? pip_rdt[tcb.DLY-1] : 'x;
    assign tcb.err = tcb.rsp ? pip_err[tcb.DLY-1] : 'x;

  end
  endgenerate

endmodule: tcb_vip_sub
