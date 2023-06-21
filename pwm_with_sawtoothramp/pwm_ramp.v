`include "st_ramp.v"
module pwm_ramp(input samp_clk, clk, input [7:0]ref, output reg pwm, output [7:0] ramp);
st_ramp rmp(clk, ramp);
always@(samp_clk) begin
    if (ramp >= ref)
        pwm <= 1'b1;
    else pwm <= 1'b0;
end
endmodule