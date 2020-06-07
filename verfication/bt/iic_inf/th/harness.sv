`ifndef HARNESS__SV
`define HARNESS__SV

`include "tc_iic_sanity.sv"
`include "stb_clk_gen.sv"
`timescale 1ns/1ps

module harness;

    import uvm_pkg::*;
    
    logic clk_chn_iic_inf;
    include ../th/signal_connect.sv;
    `stb_clk_gen(clk,20.83,0.5,0,2)
    `stb_clk_gen(clk_chn_iic_inf,5000,0.5,0,2)
    `stb_rst_gen(rst_n,1000,5000)
    ad_chn_iic_interface ad_chn_iic_inf(clk_chn_iic_inf,rst_n);

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
        $fsdbDumpfile("./work/CoreBench.fsdb");
        $fsdbDumpvars(0,harness);
    end
    initial begin
	uvm_config_db#(virtual ad_chn_iic_interface)::set(null, "uvm_test_top.env.ad_chn_iic_agt.drv", "vif", ad_chn_iic_inf);
	uvm_config_db#(virtual ad_chn_iic_interface)::set(null, "uvm_test_top.env.ad_chn_iic_agt.mon", "vif", ad_chn_iic_inf);
    end

endmodule
`endif
