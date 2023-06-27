`timescale 1ns/1ps
`include "registerFile.v"
module registerArray_tb;
reg clk, read, write, reset, enable;
reg [3:0]address;
// reg [7:0]mem[15:0];
wire write_status;
reg [7:0]data_in;
wire [7:0]data;
assign data = (!read && write)?data_in:8'bz;
registerArray regarr(address, clk, read, write, reset, enable, write_status, data);
initial begin
    enable <= 1'b0;
    clk <= 1'b1;
    #0.3;
    write <= 1'b0;
    read <= 1'b0;
    reset <= 1'b0;
end
initial fork
    #0.6 enable = 1'b1;
    #0.7 reset = 1'b1;
    #1 reset = 1'b0;
    #2 write = 1'b1;
    #11 read = 1'b1;
    #12 write = 1'b0;
    #20 read = 1'b0;
    #21 reset = 1'b1;
    #23 read = 1'b1;
    #15 enable = 1'b0;
    #16 enable = 1'b1;
join
initial begin
    #1;
    address <= 4'b0;
    for (integer i = 0; i<16; i=i+1) begin
        #0.5 address = address + 4'b1;
        if (i == 15) i = 0;
    end
end
always begin
    #0.7;
    if (write&&!read) begin
        data_in = 8'h11;
        #3;
        for (integer i = 0; i<20; i=i+1) begin
            #1 data_in = data_in + 8'h03;
        end
    end
end
always #0.2 clk = !clk;
initial begin
    $dumpfile("regfile.vcd");
    $dumpvars(0, registerArray_tb);
    #50 $finish;
end
endmodule