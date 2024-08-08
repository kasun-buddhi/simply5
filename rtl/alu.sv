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
                else if(func3_i == 3'b001) begin// SLL
                    operation = SLL;
                    error = 1'b0; 
                end
                else if(func3_i == 3'b010) begin// SLT
                    operation = SLT;
                    error = 1'b0;
                end
                else if(func3_i == 3'b011) begin// SLTU
                    operation = SLTU;
                    error = 1'b0;
                end
                else if(func3_i == 3'b100) begin // XOR
                    operation = XOR;
                    error = 1'b0;
                end
                else if(func3_i == 3'b101) begin // SRL & SRA
                    error = 1'b0;
                    if(func7_i == 7'b0100000) 
                        operation = SRL;
                    else
                        operation = SRA;
                end
                else if(func3_i == 3'b110) begin // OR
                    operation = OR;
                    error = 1'b0;
                end
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
            XOR :   result_o = data1_i ^ data2_i;
            OR  :   result_o = data1_i | data2_i;
            AND :   result_o = data1_i & data2_i;
            SLL :   begin
                case(data2_i)
                    32'd0  : result_o = data1_i;
                    32'd1  : result_o = {data1_i[REGISTER_SIZE-2:0] ,1'b0};
                    32'd2  : result_o = {data1_i[REGISTER_SIZE-3:0] ,{2{1'b0}}};
                    32'd3  : result_o = {data1_i[REGISTER_SIZE-4:0] ,{3{1'b0}}};
                    32'd4  : result_o = {data1_i[REGISTER_SIZE-5:0] ,{4{1'b0}}};
                    32'd5  : result_o = {data1_i[REGISTER_SIZE-6:0] ,{5{1'b0}}};
                    32'd6  : result_o = {data1_i[REGISTER_SIZE-7:0] ,{6{1'b0}}};
                    32'd7  : result_o = {data1_i[REGISTER_SIZE-8:0] ,{7{1'b0}}};
                    32'd8  : result_o = {data1_i[REGISTER_SIZE-9:0] ,{8{1'b0}}};
                    32'd9  : result_o = {data1_i[REGISTER_SIZE-10:0],{9{1'b0}}};
                    32'd10 : result_o = {data1_i[REGISTER_SIZE-11:0],{10{1'b0}}};
                    32'd11 : result_o = {data1_i[REGISTER_SIZE-12:0],{11{1'b0}}};
                    32'd12 : result_o = {data1_i[REGISTER_SIZE-13:0],{12{1'b0}}};
                    32'd13 : result_o = {data1_i[REGISTER_SIZE-14:0],{13{1'b0}}};
                    32'd14 : result_o = {data1_i[REGISTER_SIZE-15:0],{14{1'b0}}};
                    32'd15 : result_o = {data1_i[REGISTER_SIZE-16:0],{15{1'b0}}};
                    32'd16 : result_o = {data1_i[REGISTER_SIZE-17:0],{16{1'b0}}};
                    32'd17 : result_o = {data1_i[REGISTER_SIZE-18:0],{17{1'b0}}};
                    32'd18 : result_o = {data1_i[REGISTER_SIZE-19:0],{18{1'b0}}};
                    32'd19 : result_o = {data1_i[REGISTER_SIZE-20:0],{19{1'b0}}};
                    32'd20 : result_o = {data1_i[REGISTER_SIZE-21:0],{20{1'b0}}};
                    32'd21 : result_o = {data1_i[REGISTER_SIZE-22:0],{21{1'b0}}};
                    32'd22 : result_o = {data1_i[REGISTER_SIZE-23:0],{22{1'b0}}};
                    32'd23 : result_o = {data1_i[REGISTER_SIZE-24:0],{23{1'b0}}};
                    32'd24 : result_o = {data1_i[REGISTER_SIZE-25:0],{24{1'b0}}};
                    32'd25 : result_o = {data1_i[REGISTER_SIZE-26:0],{25{1'b0}}};
                    32'd26 : result_o = {data1_i[REGISTER_SIZE-27:0],{26{1'b0}}};
                    32'd27 : result_o = {data1_i[REGISTER_SIZE-28:0],{27{1'b0}}};
                    32'd28 : result_o = {data1_i[REGISTER_SIZE-29:0],{28{1'b0}}};
                    32'd29 : result_o = {data1_i[REGISTER_SIZE-30:0],{29{1'b0}}};
                    32'd30 : result_o = {data1_i[REGISTER_SIZE-31:0],{30{1'b0}}};
                    default : begin
                        result_o = 32'h0;
                    end
                endcase
            end
            SRL : begin
                case(data2_i)
                    32'd0   : result_o = data1_i;
                    32'd1   : result_o = {1'b0,       data1_i[REGISTER_SIZE-1:1]};
                    32'd2   : result_o = {{2{1'b0}},  data1_i[REGISTER_SIZE-1:2]};
                    32'd3   : result_o = {{3{1'b0}},  data1_i[REGISTER_SIZE-1:3]};
                    32'd4   : result_o = {{4{1'b0}},  data1_i[REGISTER_SIZE-1:4]};
                    32'd5   : result_o = {{5{1'b0}},  data1_i[REGISTER_SIZE-1:5]};
                    32'd6   : result_o = {{6{1'b0}},  data1_i[REGISTER_SIZE-1:6]};
                    32'd7   : result_o = {{7{1'b0}},  data1_i[REGISTER_SIZE-1:7]};
                    32'd8   : result_o = {{8{1'b0}},  data1_i[REGISTER_SIZE-1:8]};
                    32'd9   : result_o = {{9{1'b0}},  data1_i[REGISTER_SIZE-1:9]};
                    32'd10  : result_o = {{10{1'b0}}, data1_i[REGISTER_SIZE-1:10]};
                    32'd11  : result_o = {{11{1'b0}}, data1_i[REGISTER_SIZE-1:11]};
                    32'd12  : result_o = {{12{1'b0}}, data1_i[REGISTER_SIZE-1:12]};
                    32'd13  : result_o = {{13{1'b0}}, data1_i[REGISTER_SIZE-1:13]};
                    32'd14  : result_o = {{14{1'b0}}, data1_i[REGISTER_SIZE-1:14]};
                    32'd15  : result_o = {{15{1'b0}}, data1_i[REGISTER_SIZE-1:15]};
                    32'd16  : result_o = {{16{1'b0}}, data1_i[REGISTER_SIZE-1:16]};
                    32'd17  : result_o = {{17{1'b0}}, data1_i[REGISTER_SIZE-1:17]};
                    32'd18  : result_o = {{18{1'b0}}, data1_i[REGISTER_SIZE-1:18]};
                    32'd19  : result_o = {{19{1'b0}}, data1_i[REGISTER_SIZE-1:19]};
                    32'd20  : result_o = {{20{1'b0}}, data1_i[REGISTER_SIZE-1:20]};
                    32'd21  : result_o = {{21{1'b0}}, data1_i[REGISTER_SIZE-1:21]};
                    32'd22  : result_o = {{22{1'b0}}, data1_i[REGISTER_SIZE-1:22]};
                    32'd23  : result_o = {{23{1'b0}}, data1_i[REGISTER_SIZE-1:23]};
                    32'd24  : result_o = {{24{1'b0}}, data1_i[REGISTER_SIZE-1:24]};
                    32'd25  : result_o = {{25{1'b0}}, data1_i[REGISTER_SIZE-1:25]};
                    32'd26  : result_o = {{26{1'b0}}, data1_i[REGISTER_SIZE-1:26]};
                    32'd27  : result_o = {{27{1'b0}}, data1_i[REGISTER_SIZE-1:27]};
                    32'd28  : result_o = {{28{1'b0}}, data1_i[REGISTER_SIZE-1:28]};
                    32'd29  : result_o = {{29{1'b0}}, data1_i[REGISTER_SIZE-1:29]};
                    32'd30  : result_o = {{30{1'b0}}, data1_i[REGISTER_SIZE-1:30]};
                    default : begin
                        result_o = 32'h0;
                    end
                endcase
            end
            default : begin 
                $display("Not in implemented arithmatics");
            end
        endcase
    end
endmodule: alu