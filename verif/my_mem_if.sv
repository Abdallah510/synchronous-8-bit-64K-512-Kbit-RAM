interface my_mem_if(input bit clk);
  logic write;
  logic read;
  logic [7:0] data_in;
  logic [8:0] data_out;
  logic [15:0] address;
  
  always @(posedge clk)
    if (read && write)
       $error("[%0t ns] CHECKER VIOLATION: read=1 and write=1 simultaneously! (addr=0x%0h)",$time, address);
  
  clocking cb @(posedge clk);
    output write, read, data_in, address; 
    input  data_out;                        
  endclocking
  
  modport DUT (
    input clk,
    input write,
    input read,
    input data_in,
    input address,
    output data_out
    );
  
  modport DUT_tb (clocking cb);
  
endinterface
