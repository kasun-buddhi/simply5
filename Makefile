MODE  ?= -c 

compile: 
	vlog -incr -sv rlt/alu.sv testbench/alu_tb.sv

elaborate:
	vopt +acc -o alu_opt alu_tb -work work

simulate: 
	vsim $(MODE) alu_opt

run: compile elaborate simulate