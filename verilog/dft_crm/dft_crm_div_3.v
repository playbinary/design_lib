module crm_div_hs (
    input    clk_i,
    output   clk_o,
    input    rst_n,
    input    test_mode, 
    input    test_as_reset_b,
    input    test_hs_mode,
    input    test_se
);

parameter  DIV_PARAM  = 3;
parameter  DUTY_CYCLE = 1;

wire                 clk_o_net;
reg  [DIV_PARAM-1:0] shifter;
wire                 shift_net;
wire                 rst_n_mux;

assign  rst_n_mux = test_mode ? test_as_reset_b : rst_n;

always @(posedge clk_i or negedge rst_n_mux) begin
    if(~rst_n_mux)
      shifter <= {{(DIV_PARAM - 1){1'b0}} , 1'b1 };
    else
      shifter <= {shifter[DIV_PARAM-2:0],shifter[DIV_PARAM-1]};
end

assign shift_net = |shifter[DUTY_CYCLE:1];
assign clk_o_net = shifter_net;

always @(posedge clk_i or negedge rst_n_mux) begin
    if(~rst_n_mux)
      clk_o <= 1'b0;
    else
      clk_o <= clk_o_net;
end

endmodule
