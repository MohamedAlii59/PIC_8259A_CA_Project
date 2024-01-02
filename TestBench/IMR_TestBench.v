module testbench();

  // Declare signals
  reg [7:0] Mask;
  wire [7:0] imr;

  // Instantiate the IMR module to be tested
  IMR dut (
    .Mask(Mask),
    .imr(imr)
  );

  // Stimulus generation
  initial begin
    // Initialize inputs
    Mask = 8'b00000000;

    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: Mask=%b", Mask);
    
    // Apply some test stimuli
    Mask = 8'b10101010; // Set some values for Mask
    
    #10; // Wait for some time
    
    // Display outputs
    $display("Outputs: imr=%b", imr);
    
    $finish;
  end

endmodule
