module buffer(D[0:7],inta,PCadr[0:7],counter[0:1]);
inout D[0:7];/*
D may contain: 
-Control info to/from the Control logic
-Status (read or write)
-Interrupt vector bus info
*/
reg bfr[0:7];
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