module ISR(
    input [0:7] irr,
    output [0:7] isr,
    input isprior);
    assign isr=(isprior)?irr:isr;
endmodule