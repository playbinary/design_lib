/*
* isolate timing path from master to slave
* the latency is one cycle
*/
module forward_register_slice #(parameter BITWIDTH = 8)
(
input  wire                         clki,
input  wire                         rst_n,

input  wire                         RxVld,
input  wire  [ BITWIDTH - 1 : 0 ]   RxData,
output wire                         RxRdy,

output reg                          TxVld,
output reg   [ BITWIDTH - 1 : 0 ]   TxData,
input  wire                         TxRdy

);

wire TxData_en ;

assign TxData_en = RxVld & RxRdy ;
assign RxRdy = ( ~ TxVld | TxRdy ); //default value is high

always @( posedge clki or negedge rst_n )
  if( ! rst_n )
    TxVld <= #0.001 ( 1'b0 ) ;
  else  TxVld <= #0.001 ( ( RxVld | ~ TxRdy & TxVld ) ) ;//default value is low

always @( posedge clki )
  if( TxData_en )
    TxData <= #0.001 ( RxData ) ;
  
endmodule