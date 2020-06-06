`ifndef AD_CHN_IIC_AGENT__SV
`define AD_CHN_IIC_AGENT__SV

import uvm_pkg::*;
`include "uvm_macros.svh"
`include "ad_chn_iic_transaction.sv";
`include "ad_chn_iic_driver.sv"
`include "ad_chn_iic_monitor.sv"
`include "ad_chn_iic_agent_cfg.sv"
`include "ad_chn_iic_sequencer.sv";
class ad_chn_iic_agent extends uvm_agent;

    ad_chn_iic_sequencer sqr;
    ad_chn_iic_driver drv;
    ad_chn_iic_monitor mon;
    ad_chn_iic_agent_cfg cfg;

    function new(string name,uvm_component parent);
        super.new(name,parent);
    endfunction

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);

    `uvm_component_utils(ad_chn_iic_agent);

endclass

function void ad_chn_iic_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    cfg = new("cfg"); 
    if(!cfg.randomize())
	`uvm_error("ERROR","cfg.randomize() failed")
    cfg.print();
    if(this.cfg.mon_sw == stb_dec::ON) begin
        this.mon =  ad_chn_iic_monitor::type_id::create("mon",this);
    end
    if(this.cfg.drv_sw == stb_dec::ON) begin
        this.drv =  ad_chn_iic_driver::type_id::create("drv",this);
        this.sqr =  ad_chn_iic_sequencer::type_id::create("sqr",this);
    end

endfunction
function void ad_chn_iic_agent::connect_phase(uvm_phase phase);

    `uvm_info(get_type_name(),"connect_phase is runing",UVM_HIGH)
    if (this.cfg.drv_sw == stb_dec::ON) begin
	`uvm_info(get_type_name(),"this.drv.seq_item_port.connect(sqr.seq_item_export)",UVM_HIGH)
        this.drv.seq_item_port.connect(this.sqr.seq_item_export);
    end

    super.connect_phase(phase);

endfunction
`endif

 
