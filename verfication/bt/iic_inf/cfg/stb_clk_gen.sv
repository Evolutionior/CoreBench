`ifndef STB_CLK_GEN__SV
`define STB_CLK_GEN__SV
    
    `define stb_clk_gen(clk,period,duty,init,jitter) \
	    initial\
	    begin\
	    clk = init;\
	    forever\
	    begin\
	    #(period*duty     + $urandom_range(0,jitter)) clk = ~clk;\
	    #(period*(1-duty) + $urandom_range(0,jitter)) clk = ~clk;\
	    end\
	    end

    `define stb_rst_gen(rst_n,init_time,rst_time) \
	    initial\
	    begin\
	    rst_n = 1;\
	    #init_time rst_n = 0;\
	    #rst_time rst_n = 1;\
	    end
`endif
