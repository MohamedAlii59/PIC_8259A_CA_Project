module READwritelogicandDbbfr_TestBench();

  // Declare signals for buffer module
  
  // Declare signals for R_WCtrllgc module
  reg rdn, wrn, A0, CSn;
  wire wrflg, rdflg, b0;
  reg [2:0] cadr;
  wire [7:0] WR;
  reg [7:0] WR_drive;
  reg [7:0] ireg;
  // Instantiate the R_WCtrllgc module to be tested
  READwritelogicandDbbfr dut_READwritelogicandDbbfr (
    .rdn(rdn),
    .wrn(wrn),
    .A0(A0),
    .CSn(CSn),
    .wrflg(wrflg),
    .rdflag(rdflg),
    .cadr(cadr[2:0]),
    .WR(WR[7:0]),
    .b0(b0)
  );
  assign WR=WR_drive;
  // Stimulus generation for buffer module
  initial begin
    // Initialize inputs for buffer module
    rdn = 0;
    wrn = 0;
    A0 = 0;
    CSn = 0;
    cadr = 3'b000;
    WR_drive = 8'b00000000;
    ireg = 8'b00000000;

    #20; // Wait for stabilization
    
    // Apply some test stimuli for R_WCtrllgc module
    rdn = 1;
    wrn = 1;
    A0 = 1;
    CSn = 1;
    cadr = 3'b111;
    WR_drive = 8'b10101010; // Simulate some data
    
    #20; // Wait for some time
    
    // Display outputs for R_WCtrllgc module
    $display("R_WCtrllgc Module Outputs: wrflg=%b, rdflg=%b, b0=%b", wrflg, rdflg, b0);
    
    $finish;
  end

endmodule
