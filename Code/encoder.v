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