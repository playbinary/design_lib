module async_fifo #(
    parameter  DW = 32 //Data bitwidth
)(
/*
* Clock and Resetn
*/     
    input  wire  rx_clk,
    input  wire  rx_rst_n,
    input  wire  tx_clk,
    input  wire  tx_rst_n,
/*
* source ports
*/
    input  wire  rx_vld,
    input  wire  [ DW - 1 : 0 ]  rx_data,
    output reg   rx_rdy, 
/*
* destination ports
*/
    output wire  tx_vld,
    output wire  [ DW -1 : 0 ]  tx_data,
    input  wire  tx_rdy

);

async_fifo_wr_side #(
    .DW = DW
)(
    .wr_clk(rx_clk),
    .wr_rst_n(rx_rst_n),
    .wr_data(rx_data),
    .wr_en(),
    .wr_ptr_grey_async(),
    .rd_ptr_grey_async(),
    .rd_data()
);

async_fifo_rd_slide #(
    .DW = DW
)(
    .rd_clk(),
    .rd_rst_n(),
    .rd_ptr_grey_async(),
    .wr_ptr_grey_async(),
    .in_data()
);



endmodule