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

    output  logic   [REGISTER_SIZE-1:0]     result_o,
    output  logic                           error_o
);
    //Some of Different instructions have same opcodes. 
    //There should be another enumation for all arithmetics 
    typedef enum logic [5:0] {
        ADD,
        SUB,
        SLL,
        SLT,
        SLTU,
        XOR,
        SRL,
        SRA,
        OR,
        AND
    } inst_type;

    //internal signals
    logic [REGISTER_SIZE-1:0]               data1_twos_complement;
    logic [REGISTER_SIZE-1:0]               data2_twos_complement;
    inst_type                               operation;
    logic                                   error;

    // Operation mode selecting block
    always_comb begin
        case(opcode_i)
            7'b0110011 : begin  // Arithmetics 
                if(func3_i == 3'b000) begin // ADD & SUB
                    error = 1'b0;
                    if(func7_i == 7'b0100000) 
                        operation = ADD;
                    else
                        operation = SUB;
                end
                else if(func3_i == 3'b001) // SLL
                    operation = SLL;
                    error = 1'b0;
                else if(func3_i == 3'b010) // SLT
                    operation = SLT;
                    error = 1'b0;
                else if(func3_i == 3'b011) // SLTU
                    operation = SLTU;
                    error = 1'b0;
                else if(func3_i == 3'b100) // XOR
                    operation = XOR;
                    error = 1'b0;
                else if(func3_i == 3'b101) begin // SRL & SRA
                    error = 1'b0;
                    if(func7_i == 7'b0100000) 
                        operation = SRL;
                    else
                        operation = SRA;
                end
                else if(func3_i == 3'b110) // OR
                    operation = OR;
                    error = 1'b0;
                else if(func3_i == 3'b111) begin // AND
                    operation = AND;
                    error = 1'b0;
                end
                else 
                    error = 1'b1;
            end
            default: 
                error = 1'b1;
        endcase
    end

    //calculate two's complements
    assign data1_twos_complement = ~(data1_i) + 32'b1;
    assign data2_twos_complement = ~(data2_i) + 32'b1;

    //Check is there available instruction not not 
    assign error_o               = (error) ? 1'b1 : 1'b0;

    // Basic Arithmetics 
    always_comb begin
        case(operation)
            // ADD 
            ADD :   result_o = data1_i + data2_i;
            SUB :   result_o = data1_i + data2_twos_complement;
            XOR :   result_o = data1_i * data2_i;
            OR  :   result_o = data1_i | data2_i;
            AND :   result_o = data1_i & data2_i;
            default : begin 
                $display("Not in implemented arithmatics");
            end
        endcase
    end
endmodule: alu