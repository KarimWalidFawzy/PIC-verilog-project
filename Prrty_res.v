module Priority_resolver(
  input fn,     //fully nested mode
  input ar,      //autmatic_rotation
  input eoi,    //end of interrupt
  inout reg[0:7] irr,  //interrupt request register
  input reg[0:7] imr, // interrupt mask register
  inout reg[0:7] isr, // in service register
  output isprior,
  input inta);
  reg [0:7] irr_masked;
  reg [0:7] irrreg;
  reg [0:7] isrreg;
  reg [0:7] placeholder;
  always @(*)begin 
  irr_masked = irr & (~imr);
end
  reg [0:2] highestprty;
  reg [0:7] decoded;
  reg ispriorreg;
  reg [0:2] priorityisr;
        always @(eoi) begin
        if(ar) begin 
          decode(decoded,highestprty,1);
          ispriorreg=(decoded== irr_masked)?0:1;
          irr_masked=(decoded==irr_masked)?irr_masked:(~decoded)&(irr_masked);
          encode(irr_masked,highestprty);
          end 
  end
  always @(irr) begin
      if(fn)
      encode(irr_masked,highestprty);
    if(highestprty<priorityisr)begin 
    priorityisr=highestprty;
    ispriorreg=1;
    end
    else 
    ispriorreg=0;
   end
   assign isprior=ispriorreg;
    always @(negedge inta)begin
      placeholder=irr&0;
      irrreg=placeholder;
      placeholder=isr|3'd128;
      isrreg=placeholder;
    end
    assign irr=irrreg;
    assign isr=isrreg;

endmodule