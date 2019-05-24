module dft_crm_div (
    input  test_mode,
    input  test_as_reset_n,
    input  test_se,
    input  test_hs_mode,
    input  clk,
    input  rst_n,
    output clko
);

parameter  DIV_PARAM  = 3;
parameter  DUTY_CYCLE = 2;

`ifdef    FPGA_EN
    assign  clko = clk;
`else
wire                       rst_n_mux;
reg   [DIV_PARAM - 1 : 0]  shifter;
reg                        clko_reg;
wire  [DIV_PARAM - 1 : 0]  shifter_next;
wire                       clko_net;

assign  rst_n_mux = test_mode ? test_as_reset_n : rst_n ; 
assign  shifter_next = {shifter[DIV_PARAM - 2 : 0], shifter[DIV_PARAM - 1]} ;
assign  clko = clk_reg;

always @(posedge clk or negedge rst_n_mux)
    if(~rst_n_mux)
        shifter <= { { (DIV_PARAM-1){1'b0} } , 1'b1 } ;
    else
        shifter <= shifter_next;

assign  clko_net = |shifter_next[DUTY_CYCLE:1];

always @(posedge clk or negedge rst_n_mux)
    if(~rst_n_mux)
        clko_reg <= 1'b0;
    else
        clko_reg <= clko_net;
`endif

endmodule

