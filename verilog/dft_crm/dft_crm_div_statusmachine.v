
module dft_crm_div_statusmachine (
    input  test_mode,
    input  test_as_reset_n,
    input  test_se,
    input  test_hs_mode,
    input  rst_n,
    input  clk,
    output clko
);

parameter  DIV_PARAM = 3;
parameter  DUTY_CYCLE = 2;

wire   test_sel;
`ifdef FPGA_EN
    assign  clko = clk;
`else
wire  rst_n_mux;
wire  clko_tmp;
reg  [DIV_PARAM - 1 : 0]  current;
reg  [DIV_PARAM - 1 : 0]  next;
assign  rst_n_mux = dft_test_mode? test_as_reset_n : rst_n;

assign  test_sel = test_mode && test_se && ~test_hs_mode ;
assign  clko     = test_sel ? clk : clko_tmp;
endmodule