`timescale 1ns/1ns
`include "pwm_ramp.v"
module pwm_ramp_tb;
reg clk, samp_clk;
reg [7:0]ref;
wire pwm;
wire [7:0] ramp;
integer count = 0;
pwm_ramp rmp1(samp_clk, clk, ref, pwm, ramp);
initial begin
    $dumpfile("pwm_ramp.vcd");
    $dumpvars(0, pwm_ramp_tb);
    samp_clk <= 1'b1;
    clk <= 1'b1;
    ref <= 8'h0F;
end
always@(samp_clk)begin
    #5; samp_clk <= !samp_clk;
    if (count == 1) begin
        clk <= !clk;
        count <= 0;
    end
    else begin 
        clk <= clk;
        count <= count+1;
    end
end
initial begin
    #5000; $finish;
end
endmodule