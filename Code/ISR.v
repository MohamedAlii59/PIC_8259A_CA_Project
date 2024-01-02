module ISR(
    input [7:0] irr,
    output [7:0] isr,
    input isprior);
    assign isr=(isprior)?irr:isr;
endmodule