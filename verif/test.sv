program automatic test (my_mem_if.DUT_tb tb_port);
  import transaction_pkg::*;
  Transaction gen[$];
  Transaction drive[$];
  Transaction mon[$];
  parameter int n = 10;
  
  //Generator
  task generator();
    Transaction tr;
    repeat(n) begin 
      tr = new();
      gen.push_back(tr);
    end
  endtask
  
  //Driver
  task driver();
    Transaction tr;
    while(gen.size() > 0) begin
      tr = gen.pop_front();
      @(tb_port.cb);
      tb_port.cb.write <=1'b1;
      tb_port.cb.read <= 1'b0;
      tb_port.cb.address <= tr.address;
      tb_port.cb.data_in <= tr.data_in;
      tr.expected_data = {^tr.data_in, tr.data_in};
      @(tb_port.cb);
      drive.push_back(tr.copy());
    end
  endtask
  
  //Monitor
  task monitor();
    Transaction tr;
    for (int i = 0; i < n; i++) begin
      wait(drive.size() > 0);
      tr = drive.pop_front();  
      tb_port.cb.read <= 1'b1;
      tb_port.cb.write <= 1'b0;
      tb_port.cb.address <= tr.address;
      repeat(2) @(tb_port.cb);
      tr.data_out = tb_port.cb.data_out;
      $display("[%0t ns] [MON] addr=0x%0h  data_out=%b_%h expected=%b_%h",$time,tr.address,tr.data_out[8],tr.data_out[7:0], tr.expected_data[8],tr.expected_data[7:0]);
      mon.push_back(tr);
    end
  endtask
  
  //Checker
  task check ();
    Transaction tr;
    for(int i = 0; i < n; i++) begin
      wait(mon.size() > 0);
      tr = mon.pop_front();
      tr.check();     
    end
    
    if(tr.error_count == 0 )
      $display("All Test have Passed");
    else
      $display("Test Failed with Error Count = %0d",tr.error_count);    
  endtask
  
  initial begin
    tb_port.cb.write   <= 1'b0;
    tb_port.cb.read    <= 1'b0;
    tb_port.cb.address <= '0;
    tb_port.cb.data_in <= '0;
    generator();
    fork
      driver();
      monitor();
      check(); 
    join
  end
endprogram
