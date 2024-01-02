module PIC(
    inout [7:0] D,
    input NRD,
    input NWR,
    input NCS,
    inout [2:0] CAS,
    input A0,
    input NINTA,
    input [7:0] IR,
    output INT,
    input NSP_EN);
wire [7:0] PCadr;
wire en;
wire ino;
DATAbusbuffer dtbfr(D[7:0],PCadr,en,ino);
wire wrflg;
wire buff;
wire rdflg;
wire [7:0] R;
wire [7:0] cadr;
wire b0;
wire [2:0] Y;
READwritelogicandDbbfr rwlogic(NRD,NWR,A0,NCS,wrflg,rdflg,cadr[0:2],R[0:7],b0);
wire S;
wire CLsig;
wire [7:0] Mask;
wire [7:0] irr;
wire [7:0] isr;
wire isprior;
wire LTIM;
wire reset;
wire [7:0] imr;
wire ar;
wire eoi;
Cascade_cmpr cc(CAS[0:2],NSP_EN,CLsig,Y[0:2],buff,S);
ISR instisr(irr[0:7],isr[0:7],isprior);
CtrlLgc instcl(INT,NINTA,PCadr,ino,en,A0,wrflg,rdflg,R[0:7],cadr[0:2],Y[0:2],S,buff,CLsig,Mask,isr,irr,LTIM,isprior,eoi,ar,reset);
IRR instirr(reset,LTIM,IR[0],IR[1],IR[2],IR[3],IR[4],IR[5],IR[6],IR[7],irr[0:7]);
IMR instimr(Mask[0:7],imr[0:7]);
Prrty_res pr(~ar,ar,eoi,irr[0:7],imr[0:7],isr[0:7],isprior,NINTA);
endmodule