`timescale 1ns/1ps
module registerArray(input [3:0]address,
                     input clk, read, write, reset, enable,
                     output reg write_status,
                     inout [7:0]data
                      );
    reg [7:0]memory[15:0];
    // assign mem = memory;
    reg [7:0] data_read;
    assign data = (read && !write)?data_read:8'bz;
    always@(posedge clk) begin
        if (enable) begin
            if (!reset) begin
                if (read ^ write) begin
                    if (read) data_read <= memory[address];
                    if (write) begin
                        memory[address] <= data;
                        write_status <= 1'b1;
                    end
                end
                else write_status <= 1'b0; //if read&write = 0, then from line 8 data is already z.
            end
            else begin
                for (integer i = 0; i<16; i = i+1)
                    memory[i] <= 8'b0;
                write_status <= 1'b0; // write failed because of reset.
                data_read <= 8'b0; // but read the reset data.
            end           
        end
        else begin
            for (integer i = 0; i<16; i = i+1)
                    memory[i] <= 8'bx;  // since it is a volatile memory.
            write_status <= 1'b0;
            data_read <= 8'bz;
        end
    end
endmodule