
/*
* Single bit synchronizer
* Default delay is 2 cycles
* Reset value of synchronizer is low
*/
module sync_reg_n #(
  parameter STAGE = 2
)
(
  input   wire  clki,
  input   wire  rstn,
  input   wire  async_data_i,
  output  wire  sync_data_o
);

reg  [ STAGE - 1 : 0 ]  data_d;
wire [ STAGE - 1 : 0 ]  indata;

assign indata = { data_d[ STAGE - 2 : 0 ] , async_data_i } ;
assign sync_data_o =   data_d[ STAGE - 1 ]                ; 

genvar i;
generate
  for( i = 0 ; i < STAGE ; i = i + 1 ) begin:stage
    synchronizer_n sync_d1_n_inst(
      .clki(clki),
      .rstn(rstn),
      .data_i(indata[i]),
      .data_o(data_d[i])
    );
  end
endgenerate

endmodule
