
module compare(
  input prts[0:23],
  input irr[0:7],
  output highestprty[0:2]);
  reg h[0:2];
  case(irr)
  8'b00000000:
  assign highestprty=3'b111;
  8'b00000001:begin 
    h[0:2]=prts[0:2];
  end
  8'b00000010:begin 
    h[0:2]=prts[3:5];
  end
  8'b00000011:begin 
    if(prts[0:2]<prts[3:5]) begin
    h[0:2]=prts[0:2];end
    else
    h[0:2]=prts[0:2];   
  end
  8'b00000100:begin 
    h[0:2]=prts[6:8];
  end
  8'b00000101:begin 
    if(prts[0:2]<)
  end
  8'b00000111:
  
  endcase
  assign highestprty=h; 
endmodule

module Priority_resolver(
  input fn,     //fully nested mode
  input ar,      //autmatic_rotation
  input eoi,    //end of interrupt
  input reg[0:7] irr,  //interrupt request register
  input reg[0:7] imr, // interrupt mask register
  input reg[0:7] isr, // in service register
  output isprior);
  reg [0:7] irr_masked;
  irr_masked = irr & ~ imr;
  reg prtyir[0:23];
  reg highestprty[0:2];
  reg priorityisr[0:2];
  always @ begin
    if(fn & ~ar)begin 
      prtyir[0:2]=3'b000;
      prtyir[3:5]=3'b001;
      prtyir[6:8]=3'b010;
      prtyir[9:11]=3'b011;
      prtyir[12:14]=3'b100;
      prtyir[15:17]=3'b101;
      prtyir[18:20]=3'b110;
      prtyir[21:23]=3'b111;
      compare(prtyir,irr,highestprty);
    end
    else begin 
      if(ar) begin

      compare(prtyir,irr,highestprty);
      end
    end
    if(highestprty<priorityisr)begin 
    priorityisr=highestprty;
    assign isprior=1;
    end
  end

    

endmodule