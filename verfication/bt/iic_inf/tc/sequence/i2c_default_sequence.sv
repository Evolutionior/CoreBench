`ifndef I2C_DEFAULT_SEQUENCE__SV
`define I2C_DEFAULT_SEQUENCE__SV

import ad_chn_iic_agent_package::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

class i2c_default_sequence extends uvm_sequence #(ad_chn_iic_transaction);
    
    ad_chn_iic_transaction tr;
    `uvm_object_utils(i2c_default_sequence)

    function new(string name = "i2c_default_sequence");
        super.new(name);
    endfunction

    virtual task body();
	if(starting_phase != null) 
	    starting_phase.raise_objection(this);
	#1ms;
	`uvm_info("i2c_default_sequence","i2c_default_sequence runing !!!",UVM_HIGH);
        repeat(10) begin
            `uvm_do_with(tr,{tr.i2c_addr_7bits == 7'h3c;})
            #($urandom_range(1000,10000));
	    #100us;
        end
	if(starting_phase != null) 
	    starting_phase.drop_objection(this);
    endtask
endclass 
`endif
