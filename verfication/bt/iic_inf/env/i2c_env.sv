`ifndef I2C_ENV__SV
`define I2C_ENV__SV

import uvm_pkg::*;
import ad_chn_iic_agent_package::*;
`include "uvm_macros.svh"
`include "ad_chn_iic_agent.sv"
`include "i2c_env_cfg.sv"
`include "i2c_virtual_sequencer.sv"

class i2c_env extends uvm_env;

    i2c_env_cfg cfg;
    i2c_virtual_sequencer vsqr;

    `uvm_component_utils(i2c_env)
    
    ad_chn_iic_agent ad_chn_iic_agt; 
    //ad_wishbone_agent ad_wishbone_agt; 

    function new(string name = "env",uvm_component parent);
        super.new(name,parent);
    endfunction: new

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

endclass: i2c_env 

function void i2c_env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg = new("cfg"); 
    
    this.vsqr = i2c_virtual_sequencer::type_id::create("vsqr",this);

    if(!cfg.randomize())
	`uvm_error("ERROR","cfg.randomize() failed")
    cfg.print(); 

    if(this.cfg.ad_chn_iic_agent_sw == stb_dec::ON) begin
	`uvm_info(get_type_name(),"ad_chn_iic_agt is building",UVM_HIGH)
        ad_chn_iic_agt = ad_chn_iic_agent::type_id::create("ad_chn_iic_agt",this); 
    end

endfunction
function void i2c_env::connect_phase(uvm_phase phase);
    
    if(this.cfg.ad_chn_iic_agent_sw == stb_dec::ON) begin
	`uvm_info(get_type_name(),"connect_phase is runing",UVM_HIGH)
	this.vsqr.i2c_sqr_0 = this.ad_chn_iic_agt.sqr;
    end

    super.connect_phase(phase);

endfunction
`endif
