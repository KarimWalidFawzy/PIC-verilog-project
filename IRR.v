module IRR(IR[0:7],irrs);
if(IRR[0:7]!=0)
irrs=1;
always @(negedge irrs) begin
    IRR[0:7]=8'b00000000;

end
endmodule