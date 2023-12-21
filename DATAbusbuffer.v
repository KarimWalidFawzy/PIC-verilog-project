module buffer(D[0:7],inta,PCadr[0:7],counter[0:1]);
inout D[0:7];
input inta;
parameter CALLCODEMCS=8'b11001101;
inout PCadr[0:7];
always @(negedge inta)




endmodule
