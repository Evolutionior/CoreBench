module pad(input pad_i, input pad_o, input oen, inout out);
    
    assign out    = oen? 1'bz : pad_o;  
    assign pad_i  = out;  

endmodule
