`timescale 1ns/1ns
`include "st_ramp.v"
module st_ramp_tb;
reg clk;
wire [7:0]ramp;
st_ramp rmp(clk, ramp);
initial begin
    $dumpfile("st_ramp.vcd");
    $dumpvars(0, st_ramp_tb);
    clk = 1'b1;
end
always@(clk) begin
    #5; clk <= ~clk;
end
initial begin
    #1000; $stop;
end
endmodule