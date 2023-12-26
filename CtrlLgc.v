module ctrllgc(
  output int,
  input inta,
  inout D[0:7],
  output ino,
  output en,
  input a0,
  input wrflg,
  input rdflag,
  inout R[0:7],
  output rwadr[0:2],
  output Y[0:2],
  input S,
  output buff,
  input CLsig,
  output Mask[0:7],
  input isr[0:7],
  input irr[0:7],
  output LTIM,
  input isprior,
  output eoi,
  output ar,
  output reset);
reg intacntr[0:1];
reg A[0:14];
reg LTI;
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
reg MID[0:2];
reg EOI;
reg T[0:4];
reg Msk[0:7];//Mask register tells which registers are to be Masked 
reg ICW_OCW[0:7];
reg Sl[0:7];
reg ID[0:2];
reg rdsts[0:7];
//D[0:2] //Level to be acted upon#
if(~wrflg) begin
    en=1;
    ino=1; 
  always @(negedge wrflg) begin
    //for ICW1
    
    ICW_OCW[0:7]=D[0:7];
    case(wrncntr)
    3'b000:begin
    IC4=D[0];//If ICW4 is needed or not
    SNGL=D[1];
    LTI=D[3];
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
    wrncntr=wrncntr+1;
  end
  assign rwadr[0:2]=wrncntr[0:2]+3'b001;
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
end
  assign Mask=Msk;
  always@(rdflag) begin
    ino=0;
    en=1;
    if(~a0)begin 
    wrncntr=3'b110;
    Readint=R[0:1];
    if(R[1])begin 
      if(R[0])begin  
      rdsts[0:7]=irr[0:7];
      assign D[0:7]=rdsts[0:7];
      end
      else begin 
      rdsts=isr[0:7];
      assign D[0:7]=rdsts[0:7];
      end
    end
  end
  else begin 
    assign D[0:7]=Msk[0:7];
  end
  end    
  assign R=ICW_OCW;
  if(S)
  assign Y=ID;
  else begin
  if(Sl & isr)begin
  encode(Sl,id); 
  assign Y=id;
  end
  end 
  assign buff=bm;
  assign Mask=D;
  assign LTIM=LTI;
always @(~inta & ~SNGL & S)begin
  /*Insert condition for second pulse here */
  if(CLsig)begin 
    en=1;
    encode(isr,MID[0:2]);
    assign D[3:7]=T[0:4];
    assign D[0:2]=MID[0:2];
  end
end
always @(posedge inta)begin
  if(intacntr[1])begin
    assign reset=1;
    assign en =1;
    assign ino=0;
    if(AEOI)begin
      assign eoi=1;
    end
    else begin
      if(D[7])
      assign eoi=1;
    end
    end
  intacntr=intacntr+1; 
end
//Single or cascade mode 
//Level trigerred and call adress modes 
assign int=isprior;
assign ar=Rot;

endmodule

