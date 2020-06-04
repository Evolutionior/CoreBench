`ifndef HARNESS__SV
`define HARNESS__SV

`include "tc_iic_sanity.sv"
`include "stb_clk_gen.sv"
`timescale 1ns/1ps

module harness;

    import uvm_pkg::*;
    
    logic clk;
    logic rst_n;

    include ../th/signal_connect.sv;
    `stb_clk_gen(clk,100,0.5,0,3)
    `stb_rst_gen(rst_n,10,1000)
    ad_chn_iic_interface ad_chn_iic_inf(clk,rst_n);
    //ad_wishbone_interface ad_wishbone_inf(clk,rst_n);
    //
    //assign wb_clk_i = ad_wishbone_inf.wb_clk_i;
    //assign wb_rst_i = ad_wishbone_inf.wb_rst_i;
    //assign arst_i = ad_wishbone_inf.arst_i;
    //assign wb_adr_i = ad_wishbone_inf.wb_adr_i;
    //assign wb_dat_i = ad_wishbone_inf.wb_dat_i;
    //assign wb_we_i = ad_wishbone_inf.wb_we_i;
    //assign wb_stb_i = ad_wishbone_inf.wb_stb_i;
    //assign wb_cyc_i = ad_wishbone_inf.wb_cyc_i;
    //
    //assign ad_wishbone_inf.wb_dat_o = wb_dat_o;
    //assign ad_wishbone_inf.wb_ack_o = wb_ack_o;
    //assign ad_wishbone_inf.wb_inta_o = wb_inta_o;

    assign iic_scl = ad_chn_iic_inf.iic_scl;
    assign iic_sda = ad_chn_iic_inf.iic_sda;

    i2c_master_top U_DUT(.*);

    pad scl_pad(.pad_i(scl_pad_i),.pad_o(scl_pad_o),.oen(scl_padoen_o),.out(iic_scl));
    pad sda_pad(.pad_i(sda_pad_i),.pad_o(sda_pad_o),.oen(sda_padoen_o),.out(iic_sda));

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
