MODE  ?= -c 

compile: 
	vlog -incr -sv testbench/text_colors.sv rtl/alu.sv testbench/alu_tb.sv 

elaborate:
	vopt +acc -o alu_opt alu_tb -work work

simulate: 
	vsim $(MODE) alu_opt \
	-do run.do 

clean:
	rm -rf work
	rm transcript

run:compile elaborate simulate
