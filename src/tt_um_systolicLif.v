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
  reg [6:0] mac_block_One_State;
  reg [0:0] bypass_Mac;
  wire [6:0] accumalate_Array [6:0];
  reg [6:0] lif_IN [6:0];

genvar i;
generate 
for(i = 1; i < 6'd7; i = i + 1) begin 
    weight_stationary_Mac generated(
        .clk(clk),
        .reset_n(rst_n),
        .x_data(ui_in[6:0]),
        .in_weight(uio_in[6:0]),
        .accumulate(accumalate_Array[i]),
        .out_data(accumalate_Array[i+1]),
        .selct_IN(bypass_Mac)
    );
    always @(*) begin
        lif_IN[i] = bypass_Mac ? accumalate_Array[i] : 7'b0;
    end
    lif one(.current({lif_IN[i],1'b0}),
        .clk(clk),
        .reset_n(rst_n),
        .state(uo_out),
        .spike(uio_out[7])
   
    );
end

endgenerate 

// genvar j;
// generate
// for (j = 0; j < 7; j = j + 1) begin
    
// end
// endgenerate







endmodule
