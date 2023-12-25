module ISR(
    input reg irr[0:7],
    output reg isr[0:7],
    input isprior);
    if(isprior)
    isr=irr;
    else
    isr=isr;
endmodule