
/*
* Single bit synchronizer
* Reset value is high
*/
module synchonizer_n(
    input  wire  clki,
    input  wire  rstn,
    input  wire  data_i,
    output wire  data_o
);

`ifdef __FOR_SIM__

reg  data_reg;

assign data_o = data_reg;

always @( posedge clki or posedge rstn )
  if( ~ rstn )
    data_reg <= 1'b1;
  else
    data_reg <= data_i;

`else

`ifdef  __FOR_ASIC__
/*
* Use std-cell to substitue
*/
`endif

`endif


endmodule