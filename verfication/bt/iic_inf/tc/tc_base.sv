`ifndef TC_BASE__SV
`define TC_BASE__SV

`include "../env/i2c_env.sv"
`include "i2c_default_sequence.sv"
`define tc_name tc_base

class `tc_name extends uvm_test;

    `uvm_component_utils(`tc_name)

    i2c_env env;

    function new(string name = "`tc_name",uvm_component parent);
        super.new(name,parent);
    endfunction

    function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	env = i2c_env::type_id::create("env",this);   
    endfunction

    function void report_phase(uvm_phase phase);
       uvm_report_server server;
       int err_num;
       super.report_phase(phase);
    
       server = get_report_server();
       err_num = server.get_severity_count(UVM_ERROR);
    
       if (err_num != 0) begin
            `uvm_info(get_type_name(),"TEST CASE FAILED !!!",UVM_HIGH);
       end
       else begin
    	`uvm_info(get_type_name(),"TEST CASE PASSED !!!",UVM_HIGH);
       end
    endfunction

endclass: `tc_name 
`undef tc_name
`endif
