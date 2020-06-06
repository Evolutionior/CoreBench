`ifndef I2C_VIRTUAL_SEQUENCER__SV
`define I2C_VIRTUAL_SEQUENCER__SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class i2c_virtual_sequencer extends uvm_sequencer;

    `uvm_component_utils(i2c_virtual_sequencer)
    uvm_sequencer_base	    i2c_sqr_0;

    function new (string name = "i2c_virtual_sequencer",uvm_component parent);
	super.new(name,parent);
    endfunction	

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass

`endif
