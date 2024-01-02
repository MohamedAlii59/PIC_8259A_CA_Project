module IRR_TestBench();

  // Declare signals
  reg reset, LTIM, ir0, ir1, ir2, ir3, ir4, ir5, ir6, ir7;
  wire [7:0] irr;

  // Instantiate the module to be tested
  IRR dut (
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

  // Stimulus generation
  initial begin
    // Initialize inputs
    reset = 1;
    LTIM = 0;
    ir0 = 0;
    ir1 = 0;
    ir2 = 0;
    ir3 = 0;
    ir4 = 0;
    ir5 = 0;
    ir6 = 0;
    ir7 = 0;

    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: reset=%b, LTIM=%b, ir0-ir7=%b", reset, LTIM, {ir7,ir6,ir5,ir4,ir3,ir2,ir1,ir0});
    
    // Apply some test stimuli
    reset = 0;
    ir0 = 1; // Simulate an interrupt
    LTIM = 1; // Assuming it's edge-triggered
    
    #10; // Wait for some time
    
    // Display outputs
    $display("Output: irr=%b", irr);
    
    $finish;
  end

endmodule
