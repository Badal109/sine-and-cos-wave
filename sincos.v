module top (
    input wire clk,          // 125 MHz clock from PYNQ-Z2
    input wire reset,        // Reset signal
    output wire [15:0] gpio_sin, // GPIO output for sine wave
    output wire [15:0] gpio_cos ,
        output wire [15:0] sin, // GPIO output for sine wave
    output wire [15:0] cos // GPIO output for cosine wave
);
    reg [15:0] phase = 0;
    reg phase_tvalid = 0;
    wire [15:0] sin, cos;
    wire sincos_tvalid;

    // Instantiate the sincos module
    sincos sincos_inst (
        .clk(clk),
        .phase(phase),
        .phase_tvalid(phase_tvalid),
        .cos(cos),
        .sin(sin),
        .sincos_tvalid(sincos_tvalid),
        .gpio_sin(gpio_sin),
        .gpio_cos(gpio_cos)
    );

    // Phase increment logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            phase <= 0;
            phase_tvalid <= 0;
        end else begin
            phase_tvalid <= 1;
            phase <= phase + 256; // Increment phase
        end
    end
endmodule
module sincos (
    input clk,
    input [15:0] phase,
    input phase_tvalid,
    
    output [15:0] cos,
    output [15:0] sin,
    output sincos_tvalid,

    // GPIO outputs for DSO
    output reg [15:0] gpio_sin,  // GPIO output for sine wave
    output reg [15:0] gpio_cos   // GPIO output for cosine wave
);

cordic_0 cordic_0_inst (
    .aclk       (clk),
    .s_axis_phase_tvalid(phase_tvalid),
    .s_axis_phase_tdata (phase),
    .m_axis_dout_tvalid (sincos_tvalid),
    .m_axis_dout_tdata  ({sin, cos})
);

// Map sine and cosine outputs to GPIO
always @(posedge clk) begin
    if (sincos_tvalid) begin
        gpio_sin <= sin;
        gpio_cos <= cos;
    end
end

endmodule
