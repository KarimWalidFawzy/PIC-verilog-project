module ctrllgc(int,inta,irrs,isrs,dbb)
reg counter[0:1];
if(irrs)
  int=1;
if(~inta) begin 
 isrs=1;
 irrs=0;
 dbb=1;
end
always @(negedge inta)begin
    counter<=counter+1;
end
endmodule
