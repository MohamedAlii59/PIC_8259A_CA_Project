module DATAbusbuffer(
inout [7:0] D,
inout [7:0] PCadr,
input en,
input ino);
/*
D may contain: 
-Control info to/from the Control logic
-Status (read or write)
-Interrupt vector bus info
*/
//Comes from ctrl logic and tells the 
//buffer wether it wants to output data or obtain data
reg [7:0] bfr;
always@(en)begin 
  if(ino)begin
    bfr=PCadr;
  end
  else begin 
    bfr=D;
  end
end
assign D=(~en)?8'bZZZZZZZZ:bfr;
assign PCadr=(~en)?8'bZZZZZZZZ:bfr;
endmodule