module spiking_neuron (
    input clk,
    input rst_n,
    input [7:0] neuron_input,
    output reg spike
);

parameter THRESHOLD = 8'd255;
reg [7:0] accumulator = 8'b0;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) accumulator <= 8'b0;
    else accumulator <= accumulator + neuron_input;
end

always @(posedge clk) begin
    if (accumulator >= THRESHOLD) begin
        accumulator <= 8'b0;
        spike <= 1;
    end else begin
        spike <= 0;
    end
end

endmodule
