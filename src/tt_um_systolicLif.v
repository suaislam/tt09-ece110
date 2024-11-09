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
  assign uio_out [7:0] = 0;
  assign uio_oe  = 8'b10000000;
  assign uo_out [3:0] = 0;


  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};
  //reg [6:0] mac_block_One_State;
  reg [0:0] bypass_Mac;
  wire [6:0] mac_Out_one, mac_Out_two, mac_Out_three, mac_Out_four;
  wire [6:0] lif_byp_One, lif_byp_Two, lif_byp_Three, lif_byp_Four;
  reg [0:0] lif_IN, Lif_IN_Two, Lif_IN_Three, Lif_IN_Four;
  reg [7:0]   state;
  reg [7:0] threshold;
  wire [7:0]  next_state;
  wire [0:0] spike;


  weight_stationary_Mac first(
        .clk(clk),
        .reset_n(rst_n),
        .x_data(ui_in[6:0]),
        .in_weight(7'd16),
        .accumulate(0),
        .out_data(mac_Out_one),
        .selct_IN(lif_IN)
    );
    weight_stationary_Mac second(
        .clk(clk),
        .reset_n(rst_n),
        .x_data(ui_in[6:0]),
        .in_weight(7'd16),
        .accumulate(mac_Out_one),
        .out_data(mac_Out_two),
        .selct_IN(Lif_IN_Two)
    );
    weight_stationary_Mac third(
        .clk(clk),
        .reset_n(rst_n),
        .x_data(ui_in[6:0]),
        .in_weight(7'd16),
        .accumulate(mac_Out_two),
        .out_data(mac_Out_three),
        .selct_IN(Lif_IN_Three)
    );
    weight_stationary_Mac fourth(
        .clk(clk),
        .reset_n(rst_n),
        .x_data(ui_in[6:0]),
        .in_weight(7'd16),
        .accumulate(mac_Out_three),
        .out_data(mac_Out_four),
        .selct_IN(Lif_IN_Four)
    );

    assign lif_byp_One = lif_IN ? mac_Out_one : 7'b0;
    assign lif_byp_Two  = Lif_IN_Two ? mac_Out_two : 7'b0;
    assign lif_byp_Three = Lif_IN_Three ? mac_Out_three : 7'b0;
    assign lif_byp_Four  = Lif_IN_Four ? mac_Out_four : 7'b0;

     lif one(.current({lif_byp_One,1'b0}),
        .clk(clk),
        .reset_n(rst_n),
        .state(),
        .spike(uo_out[7])
   
    );

  lif two(.current({lif_byp_Two,1'b0}),
        .clk(clk),
        .reset_n(rst_n),
        .state(),
        .spike(uo_out[6])
   
    );
     lif three(.current({lif_byp_Three,1'b0}),
        .clk(clk),
        .reset_n(rst_n),
        .state(),
        .spike(uo_out[5])
   
    );
     lif four(.current({lif_byp_Four,1'b0}),
        .clk(clk),
        .reset_n(rst_n),
        .state(),
        .spike(uo_out[4])
   
    );

// genvar i;
// generate 
// for(i = 1; i < 6'd7; i = i + 1) begin 
//     weight_stationary_Mac generated(
//         .clk(clk),
//         .reset_n(rst_n),
//         .x_data(ui_in[6:0]),
//         .in_weight(uio_in[6:0]),
//         .accumulate(accumalate_Array[i]),
//         .out_data(accumalate_Array[i+1]),
//         .selct_IN(bypass_Mac)
//     );
//     always @(*) begin
//         lif_IN[i] = bypass_Mac ? accumalate_Array[i] : 7'b0;
//     end
  
//     lif one(.current({lif_IN[i],1'b0}),
//         .clk(clk),
//         .reset_n(rst_n),
//         .state(uo_out),
//         .spike(uio_out[7])
   
//     );
    
  
// end

// endgenerate 

// genvar j;
// generate
// for (j = 0; j < 7; j = j + 1) begin
    
// end
// endgenerate

  

//   assign next_state = lif_IN[i] + (spike ? 0 :(state >> 1));
//     assign spike = (state >= threshold);
//     always @(posedge clk) begin 
//         if (!rst_n) begin 
//             state <= 0;
//             threshold <= 200;
//         end else begin 
//             state <= next_state;
//         end 
//     end 



endmodule
