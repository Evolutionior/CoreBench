`ifndef AD_CHN_IIC_SEQUENCER__SV
`define AD_CHN_IIC_SEQUENCER__SV
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "i2c_default_sequence.sv"

class ad_chn_iic_sequencer extends uvm_sequencer #(ad_chn_iic_transaction);

    `uvm_component_param_utils(ad_chn_iic_sequencer);
    
    function new(string name = "ad_chn_iic_sequencer", uvm_component parent);
      super.new(name, parent);
    endfunction
//   task main_phase (uvm_phase phase);
//        i2c_default_sequence seq;
//	phase.raise_objection(this);
//	seq = i2c_default_sequence::type_id::create("seq");
//	seq.start(this);
//	phase.drop_objection(this);
//    endtask
endclass

`endif
 
