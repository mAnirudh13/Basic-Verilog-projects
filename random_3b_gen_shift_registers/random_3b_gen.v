// generates random numbers form 1 to 7 for every 7 positive edges of clk.
// once if random = 000, it remains at same state forever.
// this is the reason why the reset value is a non zero value.
module rand_3b(input clk, reset, sel, input [2:0]start, output reg [2:0]random);
wire in1;
assign in1 = random[1]^random[2];
always@(posedge clk) begin
    if (reset) random = 3'b111;
    else begin
        if (sel) begin
            random[0] <= in1;
            random[1] <= random[0];
            random[2] <= random[1];
        end
        else random = start;
    end
end

endmodule