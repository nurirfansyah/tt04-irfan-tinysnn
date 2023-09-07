module spiking_neuron (
    input clk,        // Clock
    input rst_n,      // Active low reset
    input [7:0] inn, // 8-bit input (analogous to input current for a real neuron)
    output spike      // Output spike signal
);

// Parameters
parameter THRESHOLD = 8'd255; // The firing threshold for our neuron

// Internal variables
reg [7:0] accumulator = 8'b0;  // To accumulate the inputs

// Spike logic
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        accumulator <= 8'b0;
    end else begin
        accumulator <= accumulator + inn;  // Accumulate the input
    end
end

// Check for spike condition
assign spike = (accumulator >= THRESHOLD) ? 1 : 0;

// Reset accumulator after spike
always @(posedge clk) begin
    if (spike) begin
        accumulator <= 8'b0;  // Reset accumulator when a spike occurs
    end
end

endmodule
