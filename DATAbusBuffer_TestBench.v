module testbench();

  // Declare signals
  reg [7:0] D;
  reg inta;
  reg [7:0] PCadr;
  reg [1:0] counter;
  wire [7:0] bfr;
  wire Mode;
  reg isr; // Assuming isr is an output
  
  // Instantiate the module to be tested
  buffer dut (
    .D(D),
    .inta(inta),
    .PCadr(PCadr),
    .counter(counter),
    .bfr(bfr),
    .Mode(Mode),
    .isr(isr)
  );

  // Stimulus generation
  initial begin
    // Initialize inputs
    D = 8'b00000000;
    inta = 0;
    PCadr = 8'b00000000;
    counter = 2'b00; // Assuming the initial state of counter
    
    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: D=%b, inta=%b, PCadr=%b, counter=%b", D, inta, PCadr, counter);
    
    // Apply some test stimuli
    inta = 1;
    D = 8'b10101010; // Some data
    counter = 2'b10; // Assuming the counter state changes for a test case
    
    #10; // Wait for some time
    
    // Display outputs
    $display("Outputs: bfr=%b, Mode=%b, isr=%b", bfr, Mode, isr);
    
    $finish;
  end

endmodule
