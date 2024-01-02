module encoder(
    input [7:0] i,
    output [2:0] y);
    reg [2:0] out;
    always@(*)begin 
    if(i[7]==1) out=3'b111;
        else if(i[6]==1) out=3'b110;
        else if(i[5]==1) out=3'b101;
        else if(i[4]==1) out=3'b100;
        else if(i[3]==1) out=3'b011;
        else if(i[2]==1) out=3'b010;
        else if(i[1]==1) out=3'b001;
        else
        out=3'b000;
    end
assign y=out;
endmodule

module CtrlLgc (
  output reg int,
  input inta,
  inout [7:0] D,
  output reg ino,
  output reg en,
  input a0,
  input wrflg,
  input rdflag,
  inout [7:0] R,
  output [2:0] rwadr,
  output [2:0] Y,
  input S,
  output buff,
  input CLsig,
  output reg [7:0] Mask,
  input [7:0] isr,
  input [7:0] irr,
  output LTIM,
  input isprior,
  output reg eoi,
  output ar,
  output reg reset
);
  reg internal_S; // Internal signal to hold the value of S
  reg [1:0] intacntr;
  reg [14:0] A;
  reg LTI, uPM, AEOI;
  wire icwflg, rdflg;
  reg bm, IC4, SNGL;
  reg [2:0] wrncntr;
  reg s, Rot, Spec;
  reg [2:0] L,Readint, MID, EOI;
  reg [4:0] T;
  reg [7:0] Msk, ICW_OCW, Sl, ID, rdsts;
  reg [2:0] id;
  reg [7:0] internal_D;
  wire [7:0] encoder1_inputs,encoder2_inputs;
  wire [2:0] encoder1_out,encode2out;
  // Assign internal_S with value of inout port S
  always @(negedge inta) begin
    internal_S <= S;
    reset<=1;
  end

  always @(posedge wrflg) begin
    en=1;
    ino=1;
    ICW_OCW = D;
    case(wrncntr)
      3'b000: begin
        IC4 = D[0];
        SNGL = D[1];
        LTI = D[3];
        A[6:4] = D[7:5];
      end
      3'b001: begin
        if (uPM)
          T = D[7:3];
        else
          A[14:7] = D;
        ICW_OCW = D;
      end
      3'b010: begin
        if (internal_S)
          ID = D[2:0];
        else
          Sl = D;
        ICW_OCW = D;
      end
      3'b011: begin
        uPM = D[0];
        AEOI = D[1];
        bm = D[3];
        if (bm) begin
          s = ~D[2];
          internal_S = s;
        end
        ICW_OCW = D;
      end
      // Add cases for 3'b100, 3'b101, 3'b110, 3'b111 if needed
    endcase
    wrncntr = wrncntr + 1;
  end
  assign rwadr = wrncntr+1;
  always @(wrflg) begin
    en=1;
    ino=1;
    if (wrncntr == 3'b100) begin 
       ICW_OCW<= D;
      Msk <= D;
    end
  if(wrncntr==101)begin
    L[2:0]=D[2:0];
    EOI=D[5];
    Rot=D[7];
    Spec=D[6];
    ICW_OCW=D;
   end
  if(wrncntr==110)begin 
    ICW_OCW=D;
  end
    // Add other conditions for wrncntr == 3'b101, 3'b110, 3'b111 if needed
  end
assign D=internal_D;
  // Add logic for always@(rdflag) block
  always@(rdflag) begin 
    ino<=0;
    en<=1;
    if(~a0)begin 
    wrncntr<=3'b110;
    Readint<=R[1:0];
    if(R[1])begin 
      if(R[0])begin  
      rdsts[7:0]<=irr[7:0];
      internal_D[7:0]<=rdsts[7:0];
      end
      else begin 
      MID[2:0]<=encoder1_out;
      rdsts<=isr[7:0];
      internal_D[7:0]<=rdsts[7:0];
      end
    end
  end
  else begin 
    internal_D<=Msk[7:0];
  end
  end
  encoder encoder2(encoder2_inputs[7:0],encode2out);
  always @(*) begin
    if(Sl&isr)
    Mask=Msk;
    id=encode2out;
    Sl=encoder2_inputs;
  end
  assign encoder1_inputs=isr[7:0];


  // Add logic for assign R = ICW_OCW
  assign R=ICW_OCW;
  assign Y=S?(id):(Sl&isr)?id:Y;
  // Add logic for assign Y
  // Add logic for assign buff
  // Add logic for assign Mask
  // Add logic for assign LTIM
  assign buff=bm;
  assign LTIM=LTI;
  // Add logic for always @(~inta & ~SNGL & S) block

  encoder encoder1(encoder1_inputs[7:0],encoder1_out[2:0]);
  always @(~inta & ~SNGL & S)begin
  /*Insert condition for second pulse here */
  if(CLsig)begin 
    en<=1;
    
    internal_D[7:3]<=T[4:0];
    internal_D[2:0]<=MID[2:0];
  end
end


  // Add logic for always @(posedge inta) block
always @(posedge inta) begin
  if(intacntr[1])begin
    reset<=1'b1;
    en <=1'b1;
    ino<=1'b0;
    if(AEOI)begin
      eoi<=1'b1;
    end
    else begin
      if(internal_D[7])
      eoi<=1'b1;
    end
    end
    intacntr<=intacntr+1; 
end
  // Add remaining assignments and logic based on your design requirements
always@(isprior) begin
int<=isprior;
end
assign ar=Rot;

endmodule