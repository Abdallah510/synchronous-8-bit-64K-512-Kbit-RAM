module my_mem (my_mem_if.DUT mem_port);

    logic [8:0] mem_array [int];
 
    always @(posedge mem_port.clk) begin
        if (mem_port.write)
            mem_array[mem_port.address] = {^mem_port.data_in, mem_port.data_in};
        else if (mem_port.read)
            mem_port.data_out = mem_array[mem_port.address];
    end
 
endmodule

