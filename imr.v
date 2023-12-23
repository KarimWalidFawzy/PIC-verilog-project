module IMR(
    input reg [8:0] ocw1,  // OCW1 signal (9 bits)
    output reg [7:0] imr    // Interrupt Mask Register (8 bits)
);

   always @ begin
        imr <= ocw1[7:0];
    end

endmodule
