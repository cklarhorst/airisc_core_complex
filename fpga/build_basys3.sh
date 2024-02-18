# Delete old project
rm -rf AIRI5C_BASIC_FPGA_Basys3

# Generate new project
vivado -mode batch -source AIRI5C_BASIC_FPGA_Basys3.tcl
