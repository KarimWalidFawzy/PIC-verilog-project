module ctrllgc(int,inta,irrs,isrs,dbb)
wire icwflg;
wire rdflg;
//reg ICW1[0:7];
//reg T[0:7];
//reg irpriority[0:2];
//reg ICW2[0:7];
//reg ICW3[0:7];
//reg M[0:7];
//reg ICW4[0:7];
//reg OCW1[0:7];
//wire SL;
//reg OCW2[0:7];
//reg zero; 
//wire R;
//wire IC4;
//wire SNGL;
//wire EOI;
//D[3:4]=2'b00;// in ocw mode 
//D[0:2] //Level to be acted upon#
R_WCtrllgc();
if(icwoneflag) begin
IC4=D[0];
ICW1[0]=IC4;//If ICW4 is needed or not
SNGL=D[1];
ICW1[1]=SNGL;//Single or cascade mode 
ICW1[2:3]=D[2:3];//Level trigerred and call adress modes 

end
if(icwtwoflag)begin
T[3:7]=D[3:7];//
end

ICW3[3:7]=5'b00000;
if(IC4) begin
  ICW4[5:7]=0;
end
OCW1[0:7]=M[0:7];

reg intacounter[0:1];
if(irrs)
  int=1;
if(~inta) begin 
 isrs=1;
 irrs=0;
 dbb=1;
end
 always @(negedge wrn) begin
 if(D[4]&~A0)
 //edge sense circuit is reset 
 IR[0:7]=0;
 zero=0;
 imr=zero;
 irpriority[0:2]<=3'b110;
 D[7:5]=
 end
always @(negedge inta)begin
    intacounter=intacounter+1;

end
endmodule
