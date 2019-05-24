`include "sp_fixed_arbiter_defs.vh"
module sp_fixed_arbiter
#(
    parameter REQ_NUMB      = 4;
    parameter ID_BITWIDTH   = 2;
    parameter DATA_BITWIDTH = 10;
    parameter REQ_MODE      = `RS_REGD;
)
(
    input                           sys_clk,
    input                           rst_n,
    input  [REQ_NUMB - 1 : 0]       RxVld,
    input  [DATA_BITWIDTH - 1 : 0]  RxData[REQ_NUMB - 1 : 0],
    output [REQ_NUMB - 1 : 0]       RxRdy,

    output                          TxVld,
    output [DATA_BITWIDTH - 1 : 0]  TxData,
    output [ID_BITWIDTH - 1 : 0]    TxPortId,
    input                           TxRdy
);



endmodule