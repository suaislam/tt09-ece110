module weight_stationary_Mac (
    input wire clk,
    input wire reset_n,
    input wire [6:0] x_data,
    input wire [6:0] in_weight,
    input wire [6:0] accumulate,
    output reg [6:0] out_data,
    output wire [0:0] selct_IN
);
    wire [8:0] mac_result;
    reg [6:0] weight_Reg;
    reg [8:0] mac_Reg;
    reg [0:0] enable_Reg;

    // always @(posedge clk) begin 
    //     if(reset_n) begin
    //         mac_Reg <= 15'b0;
    //     end else begin 
    //         mac_Reg <= mac_result;
    // end
    // end
    assign selct_IN = mac_result > 9'd200;


    
    // Multiply-accumulate (MAC) operation
    assign mac_result = (x_data * in_weight) + {2'b0,accumulate};

    // Store MAC result as 8-bit value (truncate or round based on application)
    always @(posedge clk) begin
        if (!reset_n | enable_Reg)
            out_data <= 7'b0;
        else
            out_data <= mac_result[7:1];  // Adjust to match desired width
    end
     always @(posedge clk) begin
        if (!reset_n)
            enable_Reg <= 1'b0;
        else
            enable_Reg <= selct_IN; 
    end
endmodule