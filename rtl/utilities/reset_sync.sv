module reset_sync #(parameter RESET_DELAY = 3 ) (
    input  wire clk,
    input  wire resn_in,
    output wire resn_out
);


    reg [RESET_DELAY-1:0] resn_main_reg;
    assign resn_out = resn_main_reg[RESET_DELAY-1];
    always@(posedge clk or negedge resn_in) begin 
        if (!resn_in)
        begin 
            resn_main_reg <= 'b0;
        end
        else begin 
            if (resn_out == 0)
                resn_main_reg <= {resn_main_reg[RESET_DELAY-2:0],1'b1};
        end
    end


endmodule