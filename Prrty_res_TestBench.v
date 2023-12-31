module testbench();

  // Declare signals
  reg fn, ar, eoi, inta;
  reg [7:0] irr, imr, isr;
  wire isprior;

  // Instantiate the module to be tested
  Priority_resolver dut (
    .fn(fn),
    .ar(ar),
    .eoi(eoi),
    .irr(irr),
    .imr(imr),
    .isr(isr),
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
    irr = 8'b00000000;
    imr = 8'b11111111;
    isr = 8'b00000000;

    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: fn=%b, ar=%b, eoi=%b, inta=%b, irr=%b, imr=%b, isr=%b", fn, ar, eoi, inta, irr, imr, isr);
    
    // Apply some test stimuli
    fn = 1;
    ar = 1;
    eoi = 1;
    inta = 1;
    irr = 8'b10101010; // Simulate some interrupt request bits
    
    #10; // Wait for some time
    
    // Display outputs
    $display("Output: isprior=%b", isprior);
    
    $finish;
  end

endmodule