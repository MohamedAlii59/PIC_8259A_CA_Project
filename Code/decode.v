
module decode( 
input [2:0] in,
output [7:0] out, 
input en);
  reg [7:0] outreg;
  always@(*) begin 
      if (en) 
        begin
          case (in)
              3'b000: outreg = 8'b00000001;
              3'b001: outreg = 8'b00000010;
              3'b010: outreg = 8'b00000100;
              3'b011: outreg = 8'b00001000;
              3'b100: outreg = 8'b00010000;
              3'b101: outreg = 8'b00100000;
              3'b110: outreg = 8'b01000000;
              3'b111: outreg = 8'b10000000;
              default: outreg = 8'b00000000;
          endcase
      end 
      else 
      outreg=8'b00000000;
    end
assign out=outreg;
endmodule