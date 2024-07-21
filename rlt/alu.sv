////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Author       : kasun buddhi
// email        : kasun@kasunbuddhi.com
// date         : 2024.07.15
// file         : alu.sv
// Description  : this is the arithmetic and logic unit of the  
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
module alu #(
    parameter                               REGISTER_SIZE = 32
)(
    input   logic   [REGISTER_SIZE-1:0]     data1_i,
    input   logic   [REGISTER_SIZE-1:0]     data2_i,

    input   logic   [6:0]                   opcode_i,
    input   logic   [2:0]                   func3_i, 
    input   logic   [6:0]                   func7_i, 

    output  logic   [REGISTER_SIZE-1:0]     result_o
);
    //internal signals
    logic [REGISTER_SIZE-1:0]       data1_twos_complement;
    logic [REGISTER_SIZE-1:0]       data2_twos_complement;

    //Declares some names for instructions
    typedef enum logic [5:0] {
        ADD     = 7'b0110011,
        ADDI    = 7'b0010011
    } int_t;

    //calculate two's complements
    assign data1_twos_complement = ~(data1_i) + 32'b1;
    assign data2_twos_complement = ~(data2_i) + 32'b1;

    //Basic Arithmetics 
    always_comb begin
        case(opcode_i)
            // ADD 
            ADDI, ADD : begin
                if(func7_i == 7'b0000000) // ADD
                    result_o = data1_i + data2_i;
                else if (func7_i == 7'b0100000 ) // SUB
                    result_o = data1_i + data2_twos_complement;
                else 
                    result_o = 32'b0;
            end
            default : begin 
                $display("not adding");
            end
        endcase
        $display("data1: %b data1_twos : %b", data1_i,data1_twos_complement );
    end
endmodule: alu