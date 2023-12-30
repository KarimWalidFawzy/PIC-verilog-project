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
  reg [0:7] placeholder;
  irr_masked=irr&(~imr);
  reg [0:2] highestprty;
  reg [0:7] decoded;
  reg [0:2] priorityisr;
  if(ar) begin 
        always @(eoi) begin
          decode(decoded,highestprty);
          if(decoded== irr_masked)
          assign isprior=0;
          else begin
            irr_masked=(~decoded)&(irr_masked);
            encode(irr_masked,highestprty);
          end 
          end 
  end
  always @(irr) begin
      encode(irr_masked,highestprty);
    if(highestprty<priorityisr)begin 
    priorityisr=highestprty;
    assign isprior=1;
    end
    else 
    assign isprior=0;
   end
    always @(negedge inta)begin
      placeholder=irr&0;
      assign irr=placeholder;
      placeholder=isr|3'd128;
      assign isr=placeholder;
    end
 

    

endmodule
