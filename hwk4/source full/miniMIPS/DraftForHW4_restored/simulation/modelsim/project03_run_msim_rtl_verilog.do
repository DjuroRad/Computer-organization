transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/MiniMIPS.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/mips_registers.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/_xor.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/adder_32bit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/alu_1bit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/alu_32bit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/alu_control_unit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/full_adder.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/half_adder.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/immediate_extender.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/instruction_splitter.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/main_control_unit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/mux_32bit.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/mux2x1.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/mux5x1.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/mux8x1.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/data_memory.v}
vlog -vlog01compat -work work +incdir+C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored {C:/altera/13.1/workspace/miniMIPS/DraftForHW4_restored/program_counter_unit.v}

