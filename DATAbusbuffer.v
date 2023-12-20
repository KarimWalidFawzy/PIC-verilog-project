module buffer(D[0:7],inta,PCadr[0:7]);
inout D[0:7];
input inta;
inout PCadr[0:7];
  if(inta)
    PCadr=D[0:7];
  else
   D[0:7]=8'bZZZZZZZZ;
endmodule
