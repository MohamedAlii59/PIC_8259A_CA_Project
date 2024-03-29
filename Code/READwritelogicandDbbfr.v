
module READwritelogicandDbbfr(
  input rdn,
  input wrn,
  input A0,
  input CSn,
  output wrflg,
  output rdflag,
  input [2:0] cadr,
  inout [7:0] WR,
  output b0);
//The status is the read or write status
reg [7:0] ICW1;
reg [7:0] ICW2;
reg [7:0] ICW3;
reg [7:0] ICW4;
reg [7:0] OCW1;
reg [7:0] OCW2;
reg [7:0] OCW3;
reg [7:0] ireg;
assign wrflg=~(wrn);
assign rdflg=~(rdn);
reg IC4;
always@(~wrn) begin
if(~(wrn|CSn))begin /** This detects pulses to see how to interact with CPU*/
 //Starting address of service routines
//after first pulse

case(cadr)//cadress determines what the ICW will be 
3'b001:begin if(~A0&WR[4])begin 
  ICW1<=WR;
  IC4<=ICW1[0];
end 
end
3'b010:begin ICW2<=WR;
end 
3'b011:begin if(~ICW1[1]) ICW3<=WR; 
end
3'b100:begin if(ICW1[0]) ICW4<=WR;
else ICW4<=8'b00000000;
end 

3'b101:begin 
  OCW1=WR;
  OCW1[3:4]=2'b00;// in ocw mode 
end  
3'b110: begin  OCW2=WR;
end
3'b111: begin OCW3=WR;
end 
endcase
end
//write is when I configure the controller 
end

  assign WR=(~rdn)?ireg:WR;
always@(~rdn)begin 
if(~(rdn|CSn))begin
  //release status onto WR
  case(cadr)
  3'b111:begin 
  ireg=OCW3;
end
  endcase
end
end
assign b0=A0;
//read is when i want to see the status
endmodule