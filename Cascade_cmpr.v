module CscdeCmprtr(CAS[0:2],SPENn,M,CLsig,Y[0:2])
inout  CAS[0:2];
inout Y[0:2];
if(M)begin
    case(Y[0:2])
    3'b111:/* contains the */ CAS[0:2]=3'b111;
    3'b110:;
    5:;
    4:;
    3:;
    2:;
    1:;
    default CAS=3'b000;
    endcase
end
if(~M)begin
    if(CAS[0:2]==Y[0:2])begin
        CLsig=1;
    end
end


reg count[];
/*
1. 8259A outputs are master while the inputs are
slaves 
2.8259A (Master) sends the ID on CAS
3. Slave sends its routine 
*/
endmodule
