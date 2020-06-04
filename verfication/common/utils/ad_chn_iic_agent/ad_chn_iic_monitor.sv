`ifndef AD_CHN_IIC_MONITOR__SV
`define AD_CHN_IIC_MONITOR__SV
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "ad_chn_iic_transaction.sv"

class ad_chn_iic_monitor extends uvm_monitor;

    virtual ad_chn_iic_interface vif;
    `uvm_component_param_utils(ad_chn_iic_monitor);
    
    uvm_analysis_port #(ad_chn_iic_transaction)  ap;
    function new(string name = "ad_chn_iic_monitor", uvm_component parent);
      super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual ad_chn_iic_interface)::get(this, "", "vif", vif))
         `uvm_fatal("my_monitor", "virtual interface must be set for vif!!!")
      ap = new("ap", this);
   endfunction

   extern task main_phase(uvm_phase phase);

endclass

task ad_chn_iic_monitor::main_phase(uvm_phase phase);
    ad_chn_iic_transaction tr;
    tr = new("tr");
    tr.i2c_rw_bit = 1;
    ap.write(tr);
endtask

`endif
 
