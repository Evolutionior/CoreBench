set UVM_DPI_HOME    E:/questasim_10.6c/uvm-1.2/win32
set UVM_SRC	    E:/questasim_10.6c/verilog_src/uvm-1.2/src
set UVM_HOME	    E:/questasim_10.6c/verilog_src/uvm-1.2
set TC_CASE [lindex [split [lindex $argv 4] =] 1]

# Create the library.
if [file exists work] {
    vdel -all
}
vlib work
vmap work work
vdir -lib work

setenv LD_LIBRARY_PATH E:/Novas/Debussy/share/PLI/modelsim_pli54/WINNT

vlog -work work -f ../cfg/tb.f 
vsim  -L work work.harness -sv_lib $UVM_DPI_HOME/uvm_dpi -pli novas.dll -novopt +UVM_VERBOSITY=UVM_HIGH +UVM_TESTNAME=$TC_CASE -L mtiUvm 
run -all

quit -f
