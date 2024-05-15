module counter(
    input wire clk, 
    input wire resn,
    input wire enable, 
    output reg [7:0] value
);

    always @(posedge clk) begin
        if (!resn) begin
            value <= 'h0;
        end
        else begin
            if (enable)
                value <= value +1;
        end
    end


endmodule