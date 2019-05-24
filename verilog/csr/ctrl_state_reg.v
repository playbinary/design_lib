
module ctrl_state_reg(
/*
***************************************************
** Clock and Reset
***************************************************
*/
  input wire pclk,
  input wire preset_n,
/*
**************************************************
** AMBA APB3
**************************************************
*/
  input  wire            psel,
  input  wire            penable,
  input  wire [ 31 : 0 ] paddr,
  input  wire            pwrite,
//  input  wire                     pstrb,//APB4
//  input  wire [ 2 : 0 ]           pprot,//APB4
  input  wire [ 31 : 0 ] pwdata,
  output reg  [ 31 : 0 ] prdata,
  output reg             pready,//APB3
  output reg             pslverr,//APB3
/*
**************************************************  
** Control and state port
**************************************************
*/
  input  wire [ 15 : 0 ] empty_state ,
  output reg  [ 15 : 0 ] cfg_threshold

  );


localparam APB_WRITE = psel & pwrite ;
localparam APB_READ  = psel & ( ~ pwrite ) ;
localparam APB_OK    = 1'b0 ;
localparam APB_ERROR = 1'b1 ;
/*
**************************************************
** Wire definination
**************************************************
*/

wire empty_state_sel ;
wire cfg_threshold_sel ;

/*
**************************************************
** Reg Defination
**************************************************
*/
reg [ 31 : 0 ] prdata_i; 
reg [ 31 : 0 ] cfg_threshold_reg ;
/*
**************************************************
** Registers Address
** The number of registers is $VAR
**************************************************
*/
assign EMPTY_STATE_ADDR = { 30'h0 , 2'b0 };
assign CFG_THRESHOLD_ADDR = { 30'h1 , 2'b0 };

/*
**************************************************
** Register enable
**************************************************
*/

assign EMPTY_STATE_SEL = APB_WRITE & ( paddr ==EMPTY_STATE_ADDR ) ;
assign cfg_threshold_sel = APB_WRITE & ( paddr == CFG_THRESHOLD_ADDR ) ;





always @( * ) begin
  pready  <= 1'b1;
  pslverr <= APB_OK;
end

always @( posedge pclk or negedge preset_n )
  if( ~ preset_n ) begin
     cfg_threshold_reg <= 32'h0 ;
  end
  else begin
         cfg_threshold_reg <= cfg_threshold_sel ? { 16'h0 , pwdata[15:0] } : cfg_threshold_reg ;
end

always @( * )
  case( paddr )
    EMPTY_STATE_ADDR : prdata_i <= empty_state_reg ;
    CFG_THRESHOLD_ADDR : prdata_i <=  cfg_threshold_reg ;
    default : prdata_i <= 32'h0 ;
  endcase

always @( posedge pclk or negedge preset_n )
  if( ~ preset_n )
    prdata <= 32'h0 ;
  else if( APB_READ )
         prdata <= prdata_i ;



endmodule