////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Author       : kasun buddhi
// email        : kasun@kasunbuddhi.com
// date         : 2024.07.15
// file         : alu.sv
// Description  : this is the arithmetic and logic unit of the  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module alu(
    input   logic   [31:0]      data1,
    input   logic   [31:0]      data2,

    input   logic   [6:0]       opcode,
    input   logic   [2:0]       func3, 
    input   logic   [6:0]       func7, 

    output  logic   [31:0]      result
);

    always_comb begin
        case(opcode)
            7'b0110011 : result = data1 + data2;
            default : begin 
                $display("not adding");
            end
        endcase
    end
endmodule: alu