`ifndef TC_IIC_SANITY__SV
`define TC_IIC_SANITY__SV

`include "tc_base.sv"
`define tc_name tc_iic_sanity

class `tc_name extends tc_base;

    `uvm_component_utils(`tc_name)

    function new(string name = "`tc_name",uvm_component parent = null);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	`uvm_info(get_type_name(),"build_phase runing !!!",UVM_HIGH);
	//uvm_config_db#(uvm_object_wrapper)::set(this, 
        //                                   "env.ad_chn_iic_agt.sqr.main_phase", 
        //                                   "default_sequence", 
        //                                   i2c_default_sequence::type_id::get());

    endfunction

    task main_phase (uvm_phase phase);
        i2c_default_sequence seq;
	seq.set_sequencer(this.env.ad_chn_iic_agt.sqr);
	phase.raise_objection(this);
	seq = i2c_default_sequence::type_id::create("seq");
	seq.start(this.env.ad_chn_iic_agt.sqr);
        `uvm_info(get_type_name(),"test case is runing !!!",UVM_HIGH);

	if(harness.U_DUT.scl_pad_i == 0)
	    `uvm_info(get_type_name(),"harness.U_DUT.scl_pad_i == 0",UVM_HIGH)
	else
	    `uvm_info(get_type_name(),"harness.U_DUT.scl_pad_i == 1",UVM_HIGH)

	#1ms; 
	phase.drop_objection(this);
    endtask

endclass: `tc_name 
`undef tc_name
`endif
