module PICtestbench();

  // Declare signals
  wire [7:0] D;
  reg [7:0] D_drive;
  reg NRD, NWR, NCS, A0, NINTA, NSP_EN, reset;
  reg [7:0] IR;
  wire INT, en, ino, fn,NSP_EN_wire, buff, rdflg, S,wrflg, CLsig, LTIM, eoi, ar, isprior;
  wire [2:0] CAS;
  wire [7:0] WR;
  reg [2:0] CAS_drive;
  wire [7:0] PCadr, R, Mask, irr, isr, imr;
  wire [2:0] cadr, Y;
  IMR dut_0(
    .Mask(Mask[7:0]),
    .imr(imr[7:0])
  );
    DATAbusbuffer dut_1 (
    .D(D[7:0]),
    .PCadr(PCadr[7:0]),
    .en(en),
    .ino(ino)
  );
  CtrlLgc dut_2 (
    .INT(int),
    .NINTA(inta),
    .D(D[7:0]),
    .ino(ino),
    .en(en),
    .A0(a0),
    .wrflg(wrflg),
    .rdflg(rdflag),
    .WR(R[7:0]),
    .rwadr(rwadr),
    .Y(Y[2:0]),
    .S(S),
    .buff(buff),
    .CLsig(CLsig),
    .Mask(Mask[7:0]),
    .isr(isr[7:0]),
    .irr(irr[7:0]),
    .LTIM(LTIM),
    .isprior(isprior),
    .eoi(eoi),
    .ar(ar),
    .reset(reset)
    );
    wire ir0,ir1,ir2,ir3,ir4,ir5,ir6,ir7;
    assign ir0=IR[0];
    assign ir1=IR[1];
    assign ir2=IR[2];
    assign ir3=IR[3];
    assign ir4=IR[4];
    assign ir5=IR[5];
    assign ir6=IR[6];
    assign ir7=IR[7];
  IRR dut_3 (
    .reset(reset),
    .LTIM(LTIM),
    .ir0(ir0),
    .ir1(ir1),
    .ir2(ir2),
    .ir3(ir3),
    .ir4(ir4),
    .ir5(ir5),
    .ir6(ir6),
    .ir7(ir7),
    .irr(irr[7:0])
  );
    Prrty_res dut_4 (
    .fn(fn),
    .ar(ar),
    .eoi(eoi),
    .irr(irr[7:0]),
    .imr(imr[7:0]),
    .isr(isr[7:0]),
    .isprior(isprior),
    .NINTA(inta)
  );
    READwritelogicandDbbfr dut_READwritelogicandDbbfr (
    .NRD(rdn),
    .NWR(wrn),
    .A0(A0),
    .NCS(CSn),
    .wrflg(wrflg),
    .rdflag(rdflg),
    .cadr(cadr[2:0]),
    .WR(WR[7:0]),
    .b0(b0)
  );
  Cascade_cmpr dut_5 (
    .CAS(CAS[2:0]),
    .NSP_EN(SPENn),
    .CLsig(CLsig),
    .Y(Y[2:0]),
    .buff(buff),
    .S(S));
  // Instantiate the Intel8257A module to be tested
  PIC dut (
    .D(D[7:0]),
    .NRD(NRD),
    .NWR(NWR),
    .NCS(NCS),
    .CAS(CAS[2:0]),
    .A0(A0),
    .NINTA(NINTA),
    .IR(IR[7:0]),
    .INT(INT),
    .NSP_EN(NSP_EN)
  );
  assign D=D_drive;
  assign CAS=CAS_drive;
  // Instantiate other instantiated modules here (buffer, R_WCtrllgc, etc.)

  // Stimulus generation
  initial begin
    // Initialize inputs
    D_drive = 8'b00000000;
    NRD = 0;
    NWR = 0;
    NCS = 0;
    A0 = 0;
    NINTA = 0;
    NSP_EN = 0;
    reset = 0;
    IR = 8'b00000000; // Simulate IR values as needed

    #10; // Wait for stabilization

    // Apply some test stimuli
    // Change input values as needed and apply test scenarios

    $finish;
  end

endmodule
