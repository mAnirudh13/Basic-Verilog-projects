`timescale 1ns/1ps
`include "random_3b_gen.v"
module rand_3b_tb;
reg clk, reset, sel;
reg [2:0]start;
wire [2:0]random;
rand_3b r(clk, reset, sel, start, random);
initial begin
    $dumpfile("rand_3b.vcd");
    $dumpvars(0, rand_3b_tb);
    reset <= 1'b0;
    start <= 3'b1;
    clk <= 1'b1;
    sel <= 1'b0;
end
initial fork
    #0.3 reset = 1'b1;
    #2.5 reset = 1'b0;
    #3.5 sel = !sel;
    #20 $finish;
join
always #1 clk = !clk;
endmodule