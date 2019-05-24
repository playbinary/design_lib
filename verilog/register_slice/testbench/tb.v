module dut();

reg  clk;
reg  clk_div2;
reg  rstn;

initial begin
  clk = 1'b0 ;
  forever #10 clk = ~ clk ;
end

initial begin
  clk_div2 = 1'b0 ;
  forever #20 clk_div2 = ~clk_div2 ;
end

initial begin
  rstn = 1'b0;
  #105;
  rstn = 1'b1;
end

reg txvld;
reg txrdy;
reg rxvld;
reg rxrdy;
reg [7:0] txdata;
reg [7:0] rxdata;

always @(posedge clk or negedge rstn)
  if(~rstn) begin
    txvld <= 1'b0;
    txdata <= 8'b0;
  end
  else if(txrdy) begin
         txdata <= txdata + 1'b0 ;
         txvld <= clk_div2;
       end
        
    

forward_register_slice fwd_reg_inst0(
    .clki(clk),
    .rst_n(rstn),
    .RxVld(txvld),
    .RxData(txdata),
    .RxRdy(),
    .TxVld(),
    .TxRdy(txvld),
    .TxData()
);



backward_register_slice bwd_reg_inst0(
    .clki(clk),
    .rst_n(rstn),
    .RxVld(clk),
    .RxData(8'hf),
    .RxRdy(),
    .TxVld(),
    .TxRdy(clk_div2),
    .TxData()
);


endmodule