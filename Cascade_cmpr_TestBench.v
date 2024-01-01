module Cascade_cmpr_TestBench();

  // Declare signals
  reg [2:0] CAS, Y;
  reg SPENn, buff;
  wire CLsig, S;

  // Instantiate the module to be tested
  Cascade_cmpr dut (
    .CAS(CAS),
    .SPENn(SPENn),
    .CLsig(CLsig),
    .Y(Y),
    .buff(buff),
    .S(S));

  // Stimulus generation
  initial begin
    // Initialize inputs
    CAS = 3'b000;
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
