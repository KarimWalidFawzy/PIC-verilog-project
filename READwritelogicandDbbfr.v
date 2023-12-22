module buffer(D[0:7],inta,PCadr[0:7],counter[0:1]);
inout D[0:7];/*
D may contain: 
-Control info to/from the Control logic
-Status (read or write)
-Interrupt vector bus info
*/
reg bfr[0:7];//
reg Mode;
input inta;
inout PCadr[0:7];
always @(negedge inta)
/*if  MCS */
//for first pulse
if(counter=2b'10)
bfr[0:7]=D[0:7];
PCadr[0:7]=bfr[0:7];
if(Mode)begin
    isr<=isr&~Mode;
end
//for second and 3rd pulse
//PCadr=Subroutine
endmodule
module R_WCtrllgc(rdn,wrn,A0,CSn,initflg,icwoneflg,rdflag);
input rdn;//The status is the read or write status
inout A0;
input wrn;
input CSn;
output initflg;
output rdflag;
if(~(wrn|CSn))begin /** This detects pulses to see how to interact with CPU*/
 //Starting address of service routines
//after first pulse
/*IC4=D[0];
ICW1[0]=IC4;//If ICW4 is needed or not
SNGL=D[1];
ICW1[1]=SNGL;//Single or cascade mode 
ICW1[2:3]=D[2:3];//Level trigerred and call adress modes 
T[3:7]=D[3:7];//
ICW3[3:7]=5'b00000;
ICW4[5:7]=0;
OCW1[0:7]=M[0:7];*/
initflg=1;
icwoneflg=(~A0)&D[4];
end
//write is when I configure the controller 
if(~(rdn|CSn))begin
  //release status onto D
  rdflag=1;
end
//read is when i want to see the status
endmodule