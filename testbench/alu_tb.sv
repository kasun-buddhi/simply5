////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Author       : kasun buddhi
// email        : kasun@kasunbuddhi.com
// date         : 2024.07.18
// file         : alu_tb.sv
// Description  : this is the testbench of the arithmetic and logic unit 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
import text_colors::*;

module alu_tb();
    localparam      delta_time_delay = 1;

    logic [31:0]    data1;
    logic [31:0]    data2;
    logic [6:0]     opcode;
    logic [2:0]     func3;
    logic [6:0]     func7;
    logic [31:0]    result;
    logic           error;

    alu alu_inst(
        .data1_i      (data1  ),
        .data2_i      (data2  ),
        .opcode_i     (opcode ),
        .func3_i      (func3  ),
        .func7_i      (func7  ),
        .result_o     (result ),
        .error_o      (error )
    );

    initial begin
        //ADD
        $display("%s ###### checking ADD operation ######## %s",PURPLE,WHITE);
        opcode    = 7'b0110011;
        func3     = 3'b000;
        func7     = 7'b0100000;
        #(delta_time_delay);
        repeat(10) begin
            data1 = $urandom_range(0, 32'hffffffff);
            data2 = $urandom_range(0, 32'hffffffff);
            #(delta_time_delay);
            adder_checker(data1, data2, result);
        end
        $display("%s ###### ADD operation is PASSED ######## %s",GREEN, WHITE);

        //SUB
        $display("%s ###### checking SUB operation ######## %s",PURPLE,WHITE);
        opcode    = 7'b0110011;
        func3     = 3'b000;
        func7     = 7'b0000000;
        #(delta_time_delay);
        repeat(10) begin
            data1 = $urandom_range(0, 32'hffffffff);
            data2 = $urandom_range(0, 32'hffffffff);
            #(delta_time_delay);
            sub_checker(data1, data2, result);
        end
        $display("%s ###### SUB operation is PASSED ######## %s",GREEN, WHITE);

        //xor
        $display("%s ###### checking XOR operation ######## %s",PURPLE,WHITE);
        opcode    = 7'b0110011;
        func3     = 3'b100;
        func7     = 7'b0000000;
        #(delta_time_delay);
        repeat(10) begin
            data1 = $urandom_range(0, 32'hffffffff);
            data2 = $urandom_range(0, 32'hffffffff);
            #(delta_time_delay);
            xor_checker(data1, data2, result);
        end
        $display("%s ###### XOR operation is PASSED ######## %s",GREEN, WHITE);

        //or
        $display("%s ###### checking OR operation ######## %s",PURPLE,WHITE);
        opcode    = 7'b0110011;
        func3     = 3'b110;
        func7     = 7'b0000000;
        #(delta_time_delay);
        repeat(10) begin
            data1 = $urandom_range(0, 32'hffffffff);
            data2 = $urandom_range(0, 32'hffffffff);
            #(delta_time_delay);
            or_checker(data1, data2, result);
        end
        $display("%s ###### OR operation is PASSED ######## %s",GREEN, WHITE);

        // and
        $display("%s ###### checking AND operation ######## %s",PURPLE,WHITE);
        opcode    = 7'b0110011;
        func3     = 3'b111;
        func7     = 7'b0000000;
        #(delta_time_delay);
        repeat(10) begin
            data1 = $urandom_range(0, 32'hffffffff);
            data2 = $urandom_range(0, 32'hffffffff);
            #(delta_time_delay);
            and_checker(data1, data2, result);
        end
        $display("%s ###### AND operation is PASSED ######## %s",GREEN, WHITE);
        
        //left shift
        $display("%s ###### checking SLL operation ######## %s",PURPLE,WHITE);
        opcode    = 7'b0110011;
        func3     = 3'b001;
        func7     = 7'b0000000;
        #(delta_time_delay);
        repeat(10) begin
            data1 = $urandom_range(0, 32'hffffffff);
            data2 = $urandom_range(0, 32'hf);
            #(delta_time_delay);
            lshift_checker(data1, data2, result);
        end
        $display("%s ###### SLL operation is PASSED ######## %s",GREEN, WHITE);

    end
endmodule: alu_tb


function void adder_checker(
    logic   [31:0]   number1,
    logic   [31:0]   number2,
    logic   [31:0]   sum                     
);
    if(number1 + number2 == sum) 
        $display("ADD %b + %b = %b : PASSED", number1, number2, sum );
    else begin
        $display("%s FAILED %s",RED, WHITE);
        $finish();
    end
endfunction: adder_checker 

function void sub_checker(
    logic   [31:0]   number1,
    logic   [31:0]   number2,
    logic   [31:0]   sum                     
);
    if(number1 - number2 == sum) 
        $display("ADD %b - %b = %b : PASSED", number1, number2, sum );
    else begin
        $display("%s FAILED %s",RED, WHITE);
        $finish();
    end
endfunction: sub_checker 

function void xor_checker(
    logic   [31:0]   number1,
    logic   [31:0]   number2,
    logic   [31:0]   sum                     
);
    if(number1 ^ number2 == sum) 
        $display("ADD %b ^ %b = %b : PASSED", number1, number2, sum );
    else begin
        $display("%s FAILED %s",RED, WHITE);
        $finish();
    end
endfunction: xor_checker 

function void or_checker(
    logic   [31:0]   number1,
    logic   [31:0]   number2,
    logic   [31:0]   sum                     
);
    if(number1 | number2 == sum) 
        $display("ADD %b | %b = %b : PASSED", number1, number2, sum );
    else begin
        $display("%s FAILED %s",RED, WHITE);
        $finish();
    end
endfunction: or_checker 

function void and_checker(
    logic   [31:0]   number1,
    logic   [31:0]   number2,
    logic   [31:0]   sum                     
);
    if((number1 & number2) == sum) 
        $display("ADD %b & %b = %b : PASSED", number1, number2, sum );
    else begin
        $display("%s ADD %b & %b != %b [[FAILED]] %s",RED, number1, number2, sum, WHITE);
        $finish();
    end
endfunction: and_checker 

function void lshift_checker(
    logic   [31:0]   number1,
    logic   [31:0]   number2,
    logic   [31:0]   sum                     
);
    if(number1 << number2 == sum) 
        $display("ADD %b << %b = %b : PASSED", number1, number2, sum );
    else begin
        $display("%s FAILED %s",RED, WHITE);
        $finish();
    end
endfunction: lshift_checker 