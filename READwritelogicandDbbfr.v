module buffer(D[0:7],PCadr[0:7],en,ino);
inout D[0:7];/*
D may contain: 
-Control info to/from the Control logic
-Status (read or write)
-Interrupt vector bus info
*/
input ino;//Comes from ctrl logic and tells the 
//buffer wether it wants to output data or obtain data
reg bfr[0:7];
input en;
inout PCadr[0:7];
if(en)begin 
  if(ino)begin
    bfr[0:7]=PCadr[0:7];
    assign D[0:7]=bfr[0:7];
  end
  else begin 
    buff[0:7]=D[0:7];
    assign PCadr=buff;
  end
end
else begin
buff[0:7]=8'bZZZZZZZZ;
assign D[0:7]=8'bZZZZZZZZ;
assign PCadr=8'bZZZZZZZZ;
end
endmodule
module R_WCtrllgc(
  input rdn,
  input wrn,
  input A0,
  input CSn,
  output wrflg,
  output rdflag,
  input cadr[0:2],
  inout WR[0:7],
  output b0);
//The status is the read or write status
reg ICW1[0:7];
reg ICW2[0:7];
reg ICW3[0:7];
reg ICW4[0:7];
reg OCW1[0:7];
reg OCW2[0:7];
reg OCW3[0:7];
if(~(wrn|CSn))begin /** This detects pulses to see how to interact with CPU*/
 //Starting address of service routines
//after first pulse
wrflg=~wrn;
case(cadr[0:2])//cadress determines what the ICW will be 
3'b001:begin if(~A0&WR[4])begin 
  ICW1[0:7]=WR[0:7];
  IC4=ICW1[0];
end 
end
3'b010:ICW2[0:7]=WR[0:7];
3'b011:begin if(~ICW1[1]) ICW3[0:7]=WR[0:7]; 
end
3'b100:begin if(ICW1[0]) ICW4[0:7]=WR[0:7];
else ICW4=8{0};
end 

3'b101:begin 
  OCW1[0:7]=WR[0:7];
  OCW1[3:4]=2'b00;// in ocw mode 
end  
3'b110:  OCW2[0:7]=WR[0:7];
3'b111:  OCW3=WR;
endcase
end
//write is when I configure the controller 
if(~(rdn|CSn))begin
  //release status onto WR
  rdflag=1;
  case(cadr)
  3'b111: assign WR[0:7]=OCW3[0:7];
  endcase
end
assign b0=A0;
//read is when i want to see the status
endmodule
