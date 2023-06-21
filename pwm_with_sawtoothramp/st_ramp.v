module st_ramp (input clk, output reg [7:0]ramp = 8'h00);
integer count = 0;
always@(posedge clk) begin
    if (count == 8) begin
        count = 0;
    end
    ramp <= 8'h02*(count) + 8'h01;
    count <= count+1;
end
    
endmodule