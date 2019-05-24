/*
* isolate timing path from slave to master
* the latency is one cycle
*/
module backward_register_slice #(parameter BITWIDTH = 8)
(
input  wire                         clki,
input  wire                         rst_n,

input  wire                         RxVld,
input  wire  [ BITWIDTH - 1 : 0 ]   RxData,
output wire                         RxRdy,

output wire                         TxVld,
output wire  [ BITWIDTH - 1 : 0 ]   TxData,
input  wire                         TxRdy
);

reg [ BITWIDTH - 1 : 0 ] RxData_r  ;
wire                     RxData_en ;
reg                      Full      ;

assign TxVld = ( Full | RxVld & RxRdy ) ;//default value is low
assign RxRdy = ~ Full ;//default value is high

always @( posedge clki or negedge rst_n )
  if( ! rst_n )
    Full <= #0.001 (1'b0) ;
  else Full <= #0.001 ( TxVld & ~ TxRdy );

/*
* always @( posedge clki or negedge rst_n )
*  if( ! rst_n )
*    RxRdy <= #0.01 ( 1'b1 ) ;
*  else RxRdy <= ! TxVld | TxRdy ;
*/
assign TxData = Full ? RxData_r : RxData ;
assign RxData_en = RxVld & RxRdy ;
always @( posedge clki )
  if( RxData_en )
    RxData_r <= #0.01 ( RxData ) ;

endmodule