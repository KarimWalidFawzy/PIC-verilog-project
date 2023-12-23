module Priority_resolver(
  input fn,     //fully nested mode
  input ar,      //autmatic_rotation
  input eoi,    //end of interrupt
  input reg[7:0] irr,  //interrupt request register
  input reg[7:0] imr, // interrupt mask register
  output rep[7:0] isr, // in service register
);
  reg [7:0] irr_masked;
  irr_masked = irr & ~ imr;
  always @ begin
    if(fn)
    

endmodule
