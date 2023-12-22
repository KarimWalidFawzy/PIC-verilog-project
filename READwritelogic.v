module R_WCtrllgc(rdn,wrn,A0,CSn,D[4]);
input rdn;//The status is the read or write status
inout A0;
input wrn;
reg ICW1[0:7];

reg A[5:15]; //Starting address of service routines
wire IC4;
wire SNGL;
//after first pulse
IC4=D[0];
ICW1[0]=IC4;
SNGL=D[1];
ICW1[1]=SNGL;
ICW1[2:3]=D[2:3];
A[5:7]=D[5:7];
ICW1[5:7]=A[5:7];
reg ICW2[0:7];
reg ICW3[0:7];
ICW3[3:7]=5'b00000;
reg ICW4[0:7];
ICW4[5:7]=0;
reg OCW1[0:7];
reg OCW2[0:7];
reg zero; 
reg irpriority[0:2];
if(~(wrn|CSn))begin
    /** This detects pulses to see how to interact with 
CPU*/
 always @(negedge wrn)
 if(D[4]&~A0)
 //edge sense circuit is reset 
 IR[0:7]=0;
 zero=0;
 imr=zero;
 irpriority[0:2]<=3'b110;
 D[7:5]=


end
//write is when I configure the controller 
if(~(rdn|CSn))begin
  
end
//read is when i want to see the status

endmodule
