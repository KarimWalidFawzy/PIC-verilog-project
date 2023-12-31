module testbench();

  // Declare signals
  reg inta, a0, wrflg, rdflag, S, CLsig, isprior, isr, irr, reset;
  reg [7:0] D, R, Mask;
  wire [2:0] rwadr, Y;
  wire int, ino, en, buff, LTIM, eoi, ar;

  // Instantiate the module to be tested
  ctrllgc dut (
    .int(int),
    .inta(inta),
    .D(D),
    .ino(ino),
    .en(en),
    .a0(a0),
    .wrflg(wrflg),
    .rdflag(rdflag),
    .R(R),
    .rwadr(rwadr),
    .Y(Y),
    .S(S),
    .buff(buff),
    .CLsig(CLsig),
    .Mask(Mask),
    .isr(isr),
    .irr(irr),
    .LTIM(LTIM),
    .isprior(isprior),
    .eoi(eoi),
    .ar(ar),
    .reset(reset)
  );

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
    isr = 8'b0;
    irr = 8'b0;
    reset = 0;
    
    // Apply some values to D and R
    D = 8'b10101010;
    R = 8'b11001100;

    #10; // Wait for stabilization
    
    // Display initial inputs
    $display("Initial Inputs: inta=%b, a0=%b, wrflg=%b, rdflag=%b, S=%b, CLsig=%b, isprior=%b, isr=%b, irr=%b, reset=%b", inta, a0, wrflg, rdflag, S, CLsig, isprior, isr, irr, reset);
    $display("Initial Data: D=%b, R=%b", D, R);

    // Apply some test stimuli
    inta = 1;
    wrflg = 1;
    S = 1;
    isr = 8'b10101010;
    #10; // Wait for some time
    
    // Display outputs
    $display("Outputs: int=%b, ino=%b, en=%b, buff=%b, LTIM=%b, eoi=%b, ar=%b", int, ino, en, buff, LTIM, eoi, ar);
    
    $finish;
  end

endmodule
