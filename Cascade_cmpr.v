module CscdeCmprtr(
    inout CAS[0:2],
    input SPENn,
    output CLsig,
    input Y[0:2],
    input buff,
    output S)
/*Adddress of the slave that was interrupted*/
reg M;
reg X[0:2];
if(~buff)begin
if(SPENn)
M=1;
else
M=0;
end
if(M/*M is equal to D[2] when we extract this info from Ctrllgc*/)begin
    X[0:2]=Y[0:2];
    assign CAS[0:2]=X[0:2];
end
else begin
    if(CAS[0:2]==Y[0:2])begin//During pulse 2 of inta
        CLsig=1;//This signal informs the ctrl lgc to release the ISR address
    end
    else
    CLsig=0;
end
assign S=~M;
/*
1. 8259A outputs are master while the inputs are
slaves 
2.8259A (Master) sends the ID on CAS
3. Slave sends its routine 
*/
endmodule