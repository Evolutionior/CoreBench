`ifndef AD_CHN_IIC_DRIVER__SV
`define AD_CHN_IIC_DRIVER__SV
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "ad_chn_iic_transaction.sv"

class ad_chn_iic_driver extends uvm_driver #(ad_chn_iic_transaction);

    virtual ad_chn_iic_interface vif;
    `uvm_component_param_utils(ad_chn_iic_driver);

    function new(string name = "ad_chn_iic_driver",uvm_component parent);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      if(!uvm_config_db#(virtual ad_chn_iic_interface)::get(this, "", "vif", vif))
         `uvm_fatal("ad_chn_iic_driver", "virtual interface must be set for vif!!!")
    endfunction

    extern task main_phase(uvm_phase phase);
    extern task reset_phase(uvm_phase phase);
    extern task drive_one_pkt(ad_chn_iic_transaction tr);

endclass

task ad_chn_iic_driver::reset_phase(uvm_phase phase);

    vif.iic_scl <= 1'b1;
    vif.iic_sda <= 1'b1;
 
endtask

task ad_chn_iic_driver::main_phase(uvm_phase phase);

    while(1) begin
      seq_item_port.get_next_item(req);
      drive_one_pkt(req);
      seq_item_port.item_done();
    end
endtask

task ad_chn_iic_driver::drive_one_pkt(ad_chn_iic_transaction tr);

    bit  data_q[];
    int  data_size;
 
    `uvm_info(get_type_name(),"start drive_one_pkt to the interface,the tr is",UVM_HIGH)
    tr.print();
    //send start bit
    @(posedge vif.clk);
    vif.iic_scl <= 1'b1;
    vif.iic_sda <= 1'b0;
    @(negedge vif.clk);
    vif.iic_scl <= 1'b0;
    vif.iic_sda <= 1'b0;
    //send packet bits
    data_size = tr.pack(data_q); 
    `uvm_info(get_type_name(),$sformatf("data_size = %d",data_size),UVM_HIGH)
    for(int i = 0 ;i < data_size ;i++) begin
        @(posedge vif.clk);
        vif.iic_scl <= 1'b1;
        vif.iic_sda <= data_q[i];
        @(negedge vif.clk);
        vif.iic_scl <= 1'b0;
        if(i%8 == 7) begin
            @(posedge vif.clk);
            vif.iic_scl <= 1'b1;
            vif.iic_sda <= 1'bz;
            @(negedge vif.clk);
            vif.iic_scl <= 1'b0;
            if(vif.iic_sda != 0) begin
	            `uvm_warning(get_type_name(),$sformatf("when i = %d, vif.iic_sda != 0",i));
                break;
            end
        end
    end
    //send end bit
    @(posedge vif.clk);
    vif.iic_scl <= 1'b1;
    vif.iic_sda <= 1'b0;
    @(negedge vif.clk);
    vif.iic_scl <= 1'b1;
    vif.iic_sda <= 1'b1;
	`uvm_info(get_type_name(),"finish drive_one_pkt to the interface",UVM_HIGH)
        
endtask
`endif
 
