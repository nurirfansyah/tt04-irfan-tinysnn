`timescale 1ns / 1ps

`default_nettype none

module tt_um_irfan_tinysnn (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    spiking_neuron neuron0(
        .clk(clk),        // Clock
        .rst_n(rst_n),      // Active low reset
        .inn(ui_in[7:0]), // 8-bit input (analogous to input current for a real neuron)
        .spike(uo_out[0])      // Output spike signal
    );
        
    wire reset = ! rst_n;
    wire [6:0] led_out;
    
    //reg neuron_out;
    
    assign uo_out[6:0] = led_out;
    assign uo_out[7] = 1'b0;
    //assign uo_out[0] = neuron_out;

    // use bidirectionals as outputs
    assign uio_oe = 8'b11111111;

/*    always @(posedge clk) begin
        // if reset, set counter to 0
        if (reset) begin
            neuron_out <= 0;
        end else begin
            neuron_out <= 1;
        end
    end
*/
    
endmodule
