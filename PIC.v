module Intel8257A(
    inout D[0:7],
    input NRD,
    input NWR,
    input NCS,
    inout CAS[0:2],
    input A0,
    input NINTA,
    input IR[0:7],
    output INT,
    input NSP_EN);
reg PCadr[0:7];
wire en;
wire ino;
buffer(D,PCadr,en,ino);
wire wrflg;
wire buff;
wire rdflg;
wire R[0:7];
wire cadr[0:2];
wire b0;
wire Y[0:2];
R_WCtrllgc(NRD,NWR,A0,NCS,wrflg,rdflg,cadr[0:2],R[0:7],b0);
wire S;
wire CLsig;
wire Mask[0:7];
reg irr[0:7];
reg isr[0:7];
wire isprior;
wire LTIM;
wire reset;
reg imr[0:7];
wire ar;
wire eoi;
CscdeCmprtr(CAS[0:2],NSP_EN,CLsig,Y[0:2],buff,S);
ISR(irr,isr,isprior);
ctrllgc(INT,NINTA,PCadr,ino,en,A0,wrflg,rdflg,R[0:7],cadr[0:2],Y[0:2],S,buff,CLsig,Mask,isr,irr,LTIM,isprior,eoi,ar,reset);
IRR(reset,LTIM,IR[0],IR[1],IR[2],IR[3],IR[4],IR[5],IR[6],IR[7],irr[0:7]);
IMR(Mask[0:7],imr[0:7]);
reg fn=~ar;
Priority_resolver(fn,ar,eoi,irr[0:7],imr[0:7],isr[0:7],isprior,NINTA);
endmodule
