module IRR(
    input reset,
    input ir0,
    input ir1,
    input ir2,
    input ir3,
    input ir4,
    input ir5,
    input ir6,
    input ir7,
    output reg[7:0] irr
);
    reg [7:0] cur_irr;
    cur_irr={ir0,ir1,ir2,ir3,ir4,ir5,ir6,ir7};
always @ begin
    if(reset)
    irr<=8'b00000000
    end
    else irr<=cur_irr;
    end
end
    always @(posedge ir0, posedge ir1, posedge ir2, posedge ir3, posedge ir4, posedge ir5, posedge ir6, posedge ir7)begin
         cur_irr<={ir0,ir1,ir2,ir3,ir4,ir5,ir6,ir7};
end
endmodule
