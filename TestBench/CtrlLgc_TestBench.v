module CtrlLgc_TestBench();

  // Declare signals
  reg inta, a0, wrflg, rdflag, S, CLsig, isprior; 
  reg internal_reset;
  wire reset;
  wire [7:0] D,R;
  wire  [7:0] Mask,isr,irr;
  wire [2:0] rwadr, Y;
  reg [7:0] D_drive,R_drive,Mask_drive,isr_drive,irr_drive,rw_drive;
  reg [2:0] Y_drive;
  wire int, ino, en, buff, LTIM, eoi, ar;
  assign reset=internal_reset;
  // Instantiate the module to be tested
  CtrlLgc dut (
    .int(int),
    .inta(inta),
    .D(D[7:0]),
    .ino(ino),
    .en(en),
    .a0(a0),
    .wrflg(wrflg),
    .rdflag(rdflag),
    .R(R[7:0]),
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
    assign D=D_drive;
    assign R=R_drive;
    assign Mask=Mask_drive;
    assign isr=isr_drive;
    assign irr=irr_drive; 
    assign rwadr=rw_drive;
    assign Y=Y_drive;   
  // Stimulus generation
  initial begin
    // Initialize inputs
    inta = 0;
    a0 = 0;
    wrflg = 0;
    rdflag = 0;
    S = 0;
    CLsig = 0;
    isprior = 0;
    isr_drive = 8'b0;
    irr_drive = 8'b0;
    internal_reset = 0;
    
    // Apply some values to D and R
    D_drive = 8'b10101010;
    R_drive = 8'b11001100;

    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: inta=%b, a0=%b, wrflg=%b, rdflag=%b, S=%b, CLsig=%b, isprior=%b, isr=%b, irr=%b, reset=%b", inta, a0, wrflg, rdflag, S, CLsig, isprior, isr, irr, reset);
    $display("Initial Data: D=%b, R=%b", D, R);

    // Apply some test stimuli
    inta = 1;
    wrflg = 1;
    S = 1;
    isr_drive = 8'b10101010;
    #10; // Wait for some time
    
    // Display outputs
    $display("Outputs: int=%b, ino=%b, en=%b, buff=%b, LTIM=%b, eoi=%b, ar=%b", int, ino, en, buff, LTIM, eoi, ar);
    
    $finish;
  end

endmodule
