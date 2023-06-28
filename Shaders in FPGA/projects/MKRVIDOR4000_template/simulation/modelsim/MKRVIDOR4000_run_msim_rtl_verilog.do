transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/simon/OneDrive/Namizje/New\ folder\ (3)/shaders_in_FPGA/Shaders\ in\ FPGA/ip/SYSTEM_PLL {C:/Users/simon/OneDrive/Namizje/New folder (3)/shaders_in_FPGA/Shaders in FPGA/ip/SYSTEM_PLL/SYSTEM_PLL.v}
vlog -sv -work work +incdir+C:/Users/simon/OneDrive/Namizje/New\ folder\ (3)/shaders_in_FPGA/Shaders\ in\ FPGA/projects/MKRVIDOR4000_template {C:/Users/simon/OneDrive/Namizje/New folder (3)/shaders_in_FPGA/Shaders in FPGA/projects/MKRVIDOR4000_template/MKRVIDOR4000_top.v}
vlog -sv -work work +incdir+C:/Users/simon/OneDrive/Namizje/New\ folder\ (3)/shaders_in_FPGA/Shaders\ in\ FPGA/projects/MKRVIDOR4000_template {C:/Users/simon/OneDrive/Namizje/New folder (3)/shaders_in_FPGA/Shaders in FPGA/projects/MKRVIDOR4000_template/VGA_SHADERS.v}
vlog -sv -work work +incdir+C:/Users/simon/OneDrive/Namizje/New\ folder\ (3)/shaders_in_FPGA/Shaders\ in\ FPGA/projects/MKRVIDOR4000_template/db {C:/Users/simon/OneDrive/Namizje/New folder (3)/shaders_in_FPGA/Shaders in FPGA/projects/MKRVIDOR4000_template/db/system_pll_altpll.v}

