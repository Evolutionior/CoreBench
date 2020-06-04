`ifndef AD_CHN_IIC_TRANSACTION__SV
`define AD_CHN_IIC_TRANSACTION__SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class ad_chn_iic_transaction extends uvm_sequence_item;

    rand bit  [6:0] i2c_addr_7bits;
    rand bit        i2c_rw_bit;
    rand byte	    i2c_data_8bit[];

    //constraint send_bit_constraint{
    //        i2c_addr_7bits = 7'h01;
    //    }

    function void post_randomize();
    endfunction
    
    `uvm_object_param_utils_begin(ad_chn_iic_transaction)
       `uvm_field_int(i2c_addr_7bits, UVM_ALL_ON)
       `uvm_field_int(i2c_rw_bit, UVM_ALL_ON)
       `uvm_field_array_int(i2c_data_8bit, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name = "ad_chn_iic_transaction");
        super.new(name);
    endfunction
endclass

`endif
 
