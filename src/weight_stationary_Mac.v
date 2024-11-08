module weight_stationary_Mac (
    input wire clk,
    input wire reset_n,
    input wire [6:0] x_data,
    input wire [6:0] in_weight,
    input wire [6:0] accumulate,
    output reg [6:0] out_data
);
    wire [14:0] mac_result;
    reg [6:0] weight_Reg;
    reg [14:0] mac_Reg;

    always @(posedge clk) begin 
        if(reset_n) begin
            mac_Reg <= 15'b0;
        end else begin 
            mac_Reg <= mac_result;
    end
    end

    always @(posedge clk) begin 
        if (reset_n) begin
            weight_Reg <= 7'b0;
        end else begin 
            weight_Reg <= in_weight;
        end 
    end
    
    // Multiply-accumulate (MAC) operation
    assign mac_result = (x_data * in_weight) + accumulate;

    // Store MAC result as 8-bit value (truncate or round based on application)
    always @(posedge clk) begin
        if (!reset_n)
            out_data <= 7'b0;
        else
            out_data <= mac_result[14:8];  // Adjust to match desired width
    end
endmodule