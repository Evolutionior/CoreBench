`ifndef AD_CHN_IIC_AGENT__SV
`define AD_CHN_IIC_AGENT__SV

package ad_chn_iic_agent_package;

    import uvm_pkg::*;
    `include "uvm_macros.svh"

    `include "ad_chn_iic_agent_cfg.sv";
    `include "ad_chn_iic_agent.sv";
    `include "ad_chn_iic_transaction.sv";
    `include "ad_chn_iic_driver.sv";
    //`include "ad_chn_iic_interface.sv";
    `include "ad_chn_iic_monitor.sv";
    //`include "ad_chn_iic_sequencer.sv";

endpackage

    import ad_chn_iic_agent_package::*;

`endif

 
