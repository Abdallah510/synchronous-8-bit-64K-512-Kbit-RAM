package transaction_pkg;

class Transaction;
  rand logic [7:0] data_in;
  rand logic [15:0] address;
  logic [8:0] data_out;
  logic [8:0] expected_data;
  static int error_count;
  function new();
    if(!this.randomize())
      $fatal("Transaction Randomization Failed");
  endfunction
  
  function void print_data_out();
    $display("[%0t ns] data_out = %b",$time, data_out);
  endfunction
  
  static function void print_error_count();
    $display("[%0t ns] Total Errors: %0d", $time, error_count);
  endfunction
  
  function void check();
    if(expected_data != data_out) begin
      $display("[%0t ns] MISMATCH  addr=0x%0h  expected=%h  got=%h",$time, address, expected_data, data_out);
      error_count++;
    end 
  endfunction
  
  function Transaction copy();
    copy = new();
    copy.address = this.address;
    copy.data_in = this.data_in;
    copy.data_out = this.data_out;
    copy.expected_data = this.expected_data;   
  endfunction 
endclass 
endpackage
