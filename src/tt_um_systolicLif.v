/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_systolicLif (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out [6:0] = 0;
  assign uio_oe  = 8'b10000000;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};
  reg [7:0] mac_block_One_State;
  

  weight_stationary_Mac mac_block_One(
    .clk(clk),
    .reset_n(rst_n),
    .x_data(ui_in[6:0]),
    .in_weight(uio_in[6:0]),
    .accumulate(0),
    .out_data(uo_out[6:0])
);

lif one(.current({uo_out[6:0],1'b0}),
        .clk(clk),
        .reset_n(rst_n),
        .state(mac_block_One_State),
        .spike(uio_out[7])
    );


endmodule
