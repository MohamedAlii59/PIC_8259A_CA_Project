module Cascade_cmpr_TestBench();

  // Declare signals
  reg [2:0] CAS_drive;
  wire [2:0] CAS;
  reg  [2:0] Y;
  reg SPENn, buff;
  wire CLsig, S;

  // Instantiate the module to be tested
  Cascade_cmpr dut (
    .CAS(CAS[2:0]),
    .SPENn(SPENn),
    .CLsig(CLsig),
    .Y(Y[2:0]),
    .buff(buff),
    .S(S));
  assign CAS=CAS_drive;
  // Stimulus generation
  initial begin
    // Initialize inputs
    CAS_drive= 3'b000;
    SPENn = 0;
    Y = 3'b001;
    buff = 1'b0;
    
    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial: CAS=%b, SPENn=%b, Y=%b, buff=%b", CAS, SPENn, Y, buff);

    // Test case
    SPENn = 1;
    buff = 1;
    #10; // Wait for some time
    
    // Display outputs
    $display("Outputs: CLsig=%b, S=%b", CLsig, S);
    
    $finish;
  end

endmodule
