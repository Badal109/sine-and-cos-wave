
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
//Date        : Sun Jul 13 23:48:33 2025
//Host        : Badal running 64-bit major release  (build 9200)
//Command     : generate_target design_2_wrapper.bd
//Design      : design_2_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_2_wrapper
   (L_0,
    OUT1_0,
    OUT2_0,
    clk_0,
    reset_0);
  output [7:1]L_0;
  output OUT1_0;
  output OUT2_0;
  input clk_0;
  input reset_0;

  wire [7:1]L_0;
  wire OUT1_0;
  wire OUT2_0;
  wire clk_0;
  wire reset_0;

  design_2 design_2_i
       (.L_0(L_0),
        .OUT1_0(OUT1_0),
        .OUT2_0(OUT2_0),
        .clk_0(clk_0),
        .reset_0(reset_0));
endmodule
