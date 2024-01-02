module Prrty_res_TestBench();

  // Declare signals
  reg fn, ar, eoi, inta;
  reg [7:0] imr;
  wire [7:0] isr,irr;
  reg [7:0] isr_drive,irr_drive;
  wire isprior;

  // Instantiate the module to be tested
  Prrty_res dut (
    .fn(fn),
    .ar(ar),
    .eoi(eoi),
    .irr(irr[7:0]),
    .imr(imr[7:0]),
    .isr(isr[7:0]),
    .isprior(isprior),
    .inta(inta)
  );

  // Stimulus generation
  initial begin
    // Initialize inputs
    fn = 0;
    ar = 0;
    eoi = 0;
    inta = 0;
    irr_drive = 8'b00000000;
    imr = 8'b11111111;
    isr_drive = 8'b00000000;

    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: fn=%b, ar=%b, eoi=%b, inta=%b, irr=%b, imr=%b, isr=%b", fn, ar, eoi, inta, irr, imr, isr);
    
    // Apply some test stimuli
    fn = 1;
    ar = 1;
    eoi = 1;
    inta = 1;
    irr_drive = 8'b10101010; // Simulate some interrupt request bits
    
    #10; // Wait for some time
    
    // Display outputs
    $display("Output: isprior=%b", isprior);
    
    $finish;
  end

endmodule
