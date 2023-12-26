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
  irr_masked = irr & ~ imr;
  reg highestprty[0:2];
  reg decoded[0:7];
  reg priorityisr[0:2];
  always @ begin
    if(fn & ~ar)begin 
      encode(irr_masked,highestprty);
    end
    else begin 
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
      end
    if(highestprty<priorityisr)begin 
    priorityisr=highestprty;
    assign isprior=1;
    end
    else 
    assign isprior=0;
    always @(inta)begin
      placeholder=irr&0;
      assign irr=placeholder;
      placeholder=isr|1'd128;
      assign isr=placeholder;
    end
  end

    

endmodule