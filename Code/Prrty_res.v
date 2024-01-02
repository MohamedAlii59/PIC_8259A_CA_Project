module Prrty_res(
  input fn,     //fully nested mode
  input ar,      //autmatic_rotation
  input eoi,    //end of interrupt
  inout reg[7:0] irr,  //interrupt request register
  input reg[7:0] imr, // interrupt mask register
  inout reg[7:0] isr, // in service register
  output isprior,
  input inta);
  reg [7:0] irr_masked;
  reg [7:0] irrreg;
  reg [7:0] isrreg;
  wire [7:0] encoderinputs,decoderoutputs;
  wire [2:0] encoderoutputs,decoderinputs;
  reg [7:0] placeholder;
  reg [2:0] highestprty;
  reg [7:0] decoded;
  reg ispriorreg;
  reg [2:0] priorityisr;
  always @(*)begin 
  irr_masked = irr & (~imr);
  highestprty=encoderoutputs;
  end
  assign decoderinputs=highestprty;
  assign encoderinputs=irr_masked;
  decode d0(decoderoutputs,decoderinputs,ar); 
encoder epr(encoderinputs,encoderoutputs);
        always @(eoi) begin
        if(ar) begin 
          decoded=decoderoutputs;
          ispriorreg=(decoded== irr_masked)?0:1;
          irr_masked=(decoded==irr_masked)?irr_masked:(~decoded)&(irr_masked);
          end 
  end

  always @(irr) begin
    if(highestprty<priorityisr)begin 
    priorityisr=highestprty;
    ispriorreg=1;
    end
    else 
    ispriorreg=0;
   end
   assign isprior=ispriorreg;
    always @(negedge inta)begin
      placeholder=irr&0;
      irrreg=placeholder;
      placeholder=isr|3'd128;
      isrreg=placeholder;
    end
    assign irr=irrreg;
    assign isr=isrreg;

endmodule