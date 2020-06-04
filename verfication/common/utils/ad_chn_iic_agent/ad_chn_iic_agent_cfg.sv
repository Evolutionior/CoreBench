`ifndef AD_CHN_IIC_AGENT_CFG__SV
`define AD_CHN_IIC_AGENT_CFG__SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class ad_chn_iic_agent_cfg extends uvm_object;
    
    //switch
    rand bit mon_sw;
    rand bit drv_sw;
    
    `uvm_object_param_utils_begin(ad_chn_iic_agent_cfg)
	`uvm_field_int(mon_sw,UVM_ALL_ON)
	`uvm_field_int(drv_sw,UVM_ALL_ON)
    `uvm_object_utils_end
    //constraint 
    constraint load_sw{
	mon_sw dist { stb_dec::ON:= 1,stb_dec::OFF:= 0};	
	drv_sw dist { stb_dec::ON:= 1,stb_dec::OFF:= 0};	
    } 

    function void post_randomize();
    endfunction	

    function new (string name = "ad_chn_iic_agent_cfg");
	super.new(name);
    endfunction	
endclass

`endif

 
