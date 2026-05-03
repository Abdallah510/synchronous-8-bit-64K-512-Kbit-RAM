module top();
  logic clk = 1'b0;
  always  #50 clk = ~clk;    
 
  my_mem_if dut_if (.clk(clk));
  my_mem dut (.mem_port (dut_if.DUT));
  test tb (.tb_port (dut_if.DUT_tb));
  
  initial begin
  $fsdbDumpfile("waves.fsdb");
  $fsdbDumpvars;  
  end
  
endmodule
