module ISR_TestBench();

  // Declare signals
  reg [7:0] irr;
  wire [7:0] isr;
  reg isprior;

  // Instantiate the module to be tested
  ISR dut (
    .irr(irr[7:0]),
    .isr(isr[7:0]),
    .isprior(isprior)
  );

  // Stimulus generation
  initial begin
    // Initialize inputs
    irr = 8'b00000000;
    isprior = 0;

    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: irr=%b, isprior=%b", irr, isprior);
    
    // Apply some test stimuli
    isprior = 1;
    irr = 8'b10101010; // Simulate some interrupt request bits
    
    #10; // Wait for some time
    
    // Display outputs
    $display("Outputs: isr=%b", isr);
    
    $finish;
  end

endmodule
