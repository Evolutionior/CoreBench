`ifndef HARNESS__SV
`define HARNESS__SV

`include "tc_iic_sanity.sv"
`include "stb_clk_gen.sv"
`timescale 1ns/1ps

module harness;

    import uvm_pkg::*;
    
    logic rst_n;

    include ../th/signal_connect.sv;
    `stb_clk_gen(clk,100,0.5,0,3)
    `stb_rst_gen(rst_n,10,1000)
    ad_chn_iic_interface ad_chn_iic_inf(clk,rst_n);

    assign rst = !rst_n;
    
    assign scl = ad_chn_iic_inf.iic_scl;
    assign sda = ad_chn_iic_inf.iic_sda;

    i2cSlaveTop U_DUT(.*);

    initial 
    begin
        run_test();
    end

    initial 
    begin
        $fsdbDumpfile("test.fsdb");
        $fsdbDumpvars(0,harness);
    end
    initial begin
	uvm_config_db#(virtual ad_chn_iic_interface)::set(null, "uvm_test_top.env.ad_chn_iic_agt.drv", "vif", ad_chn_iic_inf);
	uvm_config_db#(virtual ad_chn_iic_interface)::set(null, "uvm_test_top.env.ad_chn_iic_agt.mon", "vif", ad_chn_iic_inf);
    end

endmodule
`endif
