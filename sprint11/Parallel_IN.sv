
module Parallel_IN (
    input  logic [31:0] Address_in,    
    input  logic [31:0] MemData,    
    input  logic [7:0]  DataIn,     
    output logic [31:0] RegData_out     
);
    logic isaddress;
    
    assign isaddress = (Address_in == 8'hFC);
    assign RegData_out = isaddress ? { 24'b0, DataIn } : MemData;

endmodule