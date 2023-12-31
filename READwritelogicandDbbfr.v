module buffer(
inout [0:7] D,
inout [0:7] PCadr,
input en,
input ino);
/*
D may contain: 
-Control info to/from the Control logic
-Status (read or write)
-Interrupt vector bus info
*/
//Comes from ctrl logic and tells the 
//buffer wether it wants to output data or obtain data
reg bfr[0:7];
if(en)begin 
  if(ino)begin
    bfr=PCadr;
    assign D[0:7]=bfr[0:7];
  end
  else begin 
    buff=D;
    assign PCadr=buff;
  end
end
else begin
buff=8'bZZZZZZZZ;
assign D=8'bZZZZZZZZ;
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
  input [0:2] cadr,
  inout [0:7] WR,
  output b0);
//The status is the read or write status
reg [0:7] ICW1;
reg [0:7] ICW2;
reg [0:7] ICW3;
reg [0:7] ICW4;
reg [0:7] OCW1;
reg [0:7] OCW2;
reg [0:7] OCW3;
reg [0:7] ireg;
assign wrflg=~(wrn);
assign rdflg=~(rdn);
reg IC4;
always@(~wrn) begin
if(~(wrn|CSn))begin /** This detects pulses to see how to interact with CPU*/
 //Starting address of service routines
//after first pulse

case(cadr)//cadress determines what the ICW will be 
3'b001:begin if(~A0&WR[4])begin 
  ICW1<=WR;
  IC4<=ICW1[0];
end 
end
3'b010:begin ICW2<=WR;
end 
3'b011:begin if(~ICW1[1]) ICW3<=WR; 
end
3'b100:begin if(ICW1[0]) ICW4<=WR;
else ICW4<=8'b00000000;
end 

3'b101:begin 
  OCW1=WR;
  OCW1[3:4]=2'b00;// in ocw mode 
end  
3'b110: begin  OCW2=WR;
end
3'b111: begin OCW3=WR;
end 
endcase
end
//write is when I configure the controller 
end

  assign WR=(~rdn)?ireg:WR;
always@(~rdn)begin 
if(~(rdn|CSn))begin
  //release status onto WR
  case(cadr)
  3'b111:begin 
  ireg=OCW3;
end
  endcase
end
end
assign b0=A0;
//read is when i want to see the status
endmodule