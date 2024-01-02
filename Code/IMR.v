module IMR(
    input reg [0:7] Mask,  // OCW1 signal (9 bits)
    output reg [0:7] imr    // Interrupt Mask Register (8 bits)
);

   always @(*) begin
        imr <= Mask[0:7];
    end

endmodule