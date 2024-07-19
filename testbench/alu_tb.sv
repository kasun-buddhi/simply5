////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Author       : kasun buddhi
// email        : kasun@kasunbuddhi.com
// date         : 2024.07.18
// file         : alu_tb.sv
// Description  : this is the testbench of the arithmetic and logic unit 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module alu_tb();

    logic [31:0]    data1;
    logic [31:0]    data2;
    logic [6:0]     opcode;
    logic [2:0]     func3;
    logic [6:0]     func7;
    logic [31:0]    result;

    alu alu_inst(
        .data1      (data1  ),
        .data2      (data2  ),
        .opcode     (opcode ),
        .func3      (func3  ),
        .func7      (func7  ),
        .result     (result )
    );

    initial begin
        data1   = 32'd5;
        data2   = 32'd6;
        opcode  = 7'd0;
        func3   = 3'd0;
        func7   = 3'd0;
        #(1);
        $display("data1 : %p, data2: %p, opcode: %p, result: %p",data1, data2, opcode, result);
        opcode  = 7'b0110011;
        #(1);
        $display("data1 : %p, data2: %p, opcode: %p, result: %p",data1, data2, opcode, result);
    end
endmodule: alu_tb
