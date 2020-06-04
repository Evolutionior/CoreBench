`ifndef I2C_ENV_CFG__SV
`define I2C_ENV_ENV__SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class i2c_env_cfg extends uvm_env;

    //switch
    rand bit ad_chn_iic_agent_sw;
    rand bit ad_wishbone_agent_sw;
    
    `uvm_object_utils_begin(i2c_env_cfg)
	`uvm_field_int(ad_chn_iic_agent_sw,UVM_ALL_ON)
	`uvm_field_int(ad_wishbone_agent_sw,UVM_ALL_ON)
    `uvm_object_utils_end

    //constraint 
    constraint load_sw{
	ad_chn_iic_agent_sw dist { stb_dec::ON:= 1,stb_dec::OFF:= 0};	
	ad_wishbone_agent_sw dist { stb_dec::ON:= 1,stb_dec::OFF:= 0};	
    } 

    function void post_randomize();
    endfunction	

    function new (string name = "i2c_env_cfg");
	super.new(name);
    endfunction	
endclass

`endif
