localparam  BIN_0   =  4'h0;
localparam  BIN_1   =  4'h1;
localparam  BIN_2   =  4'h2;
localparam  BIN_3   =  4'h3;
localparam  BIN_4   =  4'h4;
localparam  BIN_5   =  4'h5;
localparam  BIN_6   =  4'h6;
localparam  BIN_7   =  4'h7;
localparam  BIN_8   =  4'h8;
localparam  BIN_9   =  4'h9;
localparam  BIN_10   =  4'ha;
localparam  BIN_11   =  4'hb;
localparam  GREY_0   =  4'h0;
localparam  GREY_1   =  4'h1;
localparam  GREY_2   =  4'h3;
localparam  GREY_3   =  4'h2;
localparam  GREY_4   =  4'h6;
localparam  GREY_5   =  4'h4;
localparam  GREY_6   =  4'h5;
localparam  GREY_7   =  4'h7;
localparam  GREY_8   =  4'hf;
localparam  GREY_9   =  4'he;
localparam  GREY_10   =  4'hc;
localparam  GREY_11   =  4'h8;

function bin_to_grey;
  input wire [ 3: 0 ] inbin;
  case( inbin )
    BIN_0  :  bin_to_grey = GREY_0 ;
    BIN_1  :  bin_to_grey = GREY_1 ;
    BIN_2  :  bin_to_grey = GREY_2 ;
    BIN_3  :  bin_to_grey = GREY_3 ;
    BIN_4  :  bin_to_grey = GREY_4 ;
    BIN_5  :  bin_to_grey = GREY_5 ;
    default : bin_to_grey = GREY_0 ;
  endcase
endfunction

function grey_to_bin;
    input wire [ 3 : 0 ] ingrey;
    case( ingrey )
      GREY_0  :  grey_to_bin = BIN_0 ; 
      GREY_1  :  grey_to_bin = BIN_1 ; 
      GREY_2  :  grey_to_bin = BIN_2 ; 
      GREY_3  :  grey_to_bin = BIN_3 ; 
      GREY_4  :  grey_to_bin = BIN_4 ; 
      GREY_5  :  grey_to_bin = BIN_5 ; 
      default :  grey_to_bin = BIN_0 ;
    endcase
endfunction