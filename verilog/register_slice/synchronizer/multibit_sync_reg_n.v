/*
* Multi-bit synchronizer
* Default delay is 2 cycles
* Default bitwidth is 32
* Reset value is low
* Usage restriction: there are no relationship with bits
*/

module multibit_sync_reg_n #(
    parameter DW = 32
)(
    input  wire  clki,
    input  wire  rstn,
    input  wire [ DW - 1 : 0 ] async_data_i,
    output wire [ DW - 1 : 0 ] sync_data_o 
);

genvar i;
generate
  for( i = 0 ; i < DW ; i = i + 1 ) begin:BIT
    sync_reg_n sync_reg_n_inst(
        .clki(clki),
        .rstn(rstn),
        .async_data_i(async_data_i[i]),
        .sync_data_o(sync_data_o)
    );
  end
endgenerate

endmodule