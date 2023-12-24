module ctrllgc(
  output int,
  input inta,
  input irrs,
  input isrs,
  inout D[0:7],
  output ino,
  output en,
  output a0,
  input wrflg,
  input rdflag,
  inout R[0:7],
  output rwadr[0:2],
  output Y[0:2],
  input S,
  output buff,
  input CLsig,
  output Mask[0:7],

  );
reg A[0:14];
reg LTIM;
reg uPM;
reg AEOI;
wire icwflg;
wire rdflg;
reg bm;
reg IC4;
reg SNGL;
reg wrncntr[0:2];
reg s;
reg Rot;
reg Spec;
reg L[0:2];
reg EOI;
reg T[0:4];
reg Msk[0:7];//Mask register tells which registers are to be Masked 
reg ICW_OCW[0:7];
reg Sl[0:7];
reg ID[0:2];
//D[0:2] //Level to be acted upon#
if(~wrflg) begin
  always @(negedge wrflg) begin
    //for ICW1
    en=1;
    ino=0; 
    ICW_OCW[0:7]=D[0:7];
    case(wrncntr)
    3'b000:begin
    IC4=D[0];//If ICW4 is needed or not
    SNGL=D[1];
    LTIM=D[3];
    A[4:6]=D[5:7];
    end 
    3'b001:begin
      if(uPM)
      T[0:4]=D[3:7];
      else
      A[7:14]=D[0:7];
      ICW_OCW=D;
    end 
    3'b010:begin 
      if(S)
      ID[0:2]=D[0:2];
      else 
      Sl[0:7]=D[0:7];
      ICW_OCW=D;
    end 
    3'b011:begin
      D[4:7]=4'b0000;
      uPM=D[0];
      AEOI=D[1];
      bm=D[3];
      if(bm)begin 
        s= ~D[2];
        assign S=s;
      end 
      ICW_OCW=D;
    end 
    3'b100:;
    3'b101:;
    3'b111:;
    3'b110:;
    endcase
  end
  always@(~wrflg)
  if(wrncntr==100)begin 
    ICW_OCW=D;
    Msk=D;
  end
  if(wrncntr==101)begin
    L[0:2]=D[0:2];
    EOI=D[5];
    Rot=D[7];
    Spec=D[6];
    ICW_OCW=D;
   end
  if(wrncntr==110)begin 
    ICW_OCW=D;
  end   
  assign R=ICW_OCW;
  assign Y=ID;
  assign buff=bm;
  assign Mask=D;
  
//Single or cascade mode 
//Level trigerred and call adress modes 
end


endmodule

