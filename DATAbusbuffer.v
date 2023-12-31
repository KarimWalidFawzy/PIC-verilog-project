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
reg [0:7] bfr;
always@(en)begin 
  if(ino)begin
    bfr=PCadr;
  end
  else begin 
    bfr=D;
  end
end
assign D=(~en)?8'bZZZZZZZZ:bfr;
assign PCadr=(~en)?8'bZZZZZZZZ:bfr;
endmodule