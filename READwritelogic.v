module R_WCtrllgc(rdn,wrn,A0,CSn);
input rdn;
inout A0;
input wrn;
if(~(wrn|CSn))begin
    /** This detects pulses to see how to interact with 
CPU*/
end
//write is when I configure the controller 
if(~(rdn|CSn))begin
  
end
//read is when i want to see the status

endmodule
