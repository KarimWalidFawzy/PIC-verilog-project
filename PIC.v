module Intel8257A(
    inout [0:7] D,
    input NRD,
    input NWR,
    input NCS,
    inout [0:2] CAS,
    input A0,
    input NINTA,
    input [0:7] IR,
    output INT,
    input NSP_EN);
wire [0:7] PCadr;
wire en;
wire ino;
buffer(D,PCadr,en,ino);
wire wrflg;
wire buff;
wire rdflg;
wire [0:7] R;
wire [0:2] cadr;
wire b0;
wire [0:2] Y;
R_WCtrllgc(NRD,NWR,A0,NCS,wrflg,rdflg,cadr[0:2],R[0:7],b0);
wire S;
wire CLsig;
reg [0:7] Mask;
reg [0:7] irr;
reg [0:7] isr;
wire isprior;
wire LTIM;
wire reset;
reg [0:7] imr;
wire ar;
wire eoi;
CscdeCmprtr(CAS[0:2],NSP_EN,CLsig,Y[0:2],buff,S);
ISR(irr,isr,isprior);
ctrllgc(INT,NINTA,PCadr,ino,en,A0,wrflg,rdflg,R[0:7],cadr[0:2],Y[0:2],S,buff,CLsig,Mask,isr,irr,LTIM,isprior,eoi,ar,reset);
IRR(reset,LTIM,IR[0],IR[1],IR[2],IR[3],IR[4],IR[5],IR[6],IR[7],irr[0:7]);
IMR(Mask[0:7],imr[0:7]);
Priority_resolver(~ar,ar,eoi,irr[0:7],imr[0:7],isr[0:7],isprior,NINTA);
endmodule
