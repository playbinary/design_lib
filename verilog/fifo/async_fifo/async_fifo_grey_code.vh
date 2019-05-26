/*
* Aby number of positive integers can be transformed into grey code
* In this instance, the number is 6
*/

/*
* Binary Code
*/
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
localparam  BIN_X   =  4'hx;

/*
* Grey Code
*/
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
localparam  GREY_x   =  4'hx;

localparam  FULL   =  1'b1;
localparam  EMPTY   =  1'b1;

/*
* Transform binary code into grey code
*/
function bin_to_grey;
  input [ 3: 0 ] inbin;
  case( inbin )
    BIN_0  :  bin_to_grey = GREY_0 ;
    BIN_1  :  bin_to_grey = GREY_1 ;
    BIN_2  :  bin_to_grey = GREY_2 ;
    BIN_3  :  bin_to_grey = GREY_3 ;
    BIN_4  :  bin_to_grey = GREY_4 ;
    BIN_5  :  bin_to_grey = GREY_5 ;
    BIN_6  :  bin_to_grey = GREY_6 ;
    BIN_7  :  bin_to_grey = GREY_7 ;
    BIN_8  :  bin_to_grey = GREY_8 ;
    BIN_9  :  bin_to_grey = GREY_9 ;
    BIN_10  :  bin_to_grey = GREY_10 ;
    BIN_11  :  bin_to_grey = GREY_11 ;
    default : bin_to_grey = GREY_0 ;
//    default : bin_to_grey = GREY_X ;
  endcase
endfunction

/*
* Transform grey code to binary code
*/
function grey_to_bin;
    input [ 3 : 0 ] ingrey;
    case( ingrey )
      GREY_0  :  grey_to_bin = BIN_0 ; 
      GREY_1  :  grey_to_bin = BIN_1 ; 
      GREY_2  :  grey_to_bin = BIN_2 ; 
      GREY_3  :  grey_to_bin = BIN_3 ; 
      GREY_4  :  grey_to_bin = BIN_4 ; 
      GREY_5  :  grey_to_bin = BIN_5 ; 
      GREY_6  :  grey_to_bin = BIN_6 ; 
      GREY_7  :  grey_to_bin = BIN_7 ; 
      GREY_8  :  grey_to_bin = BIN_8 ; 
      GREY_9  :  grey_to_bin = BIN_9 ; 
      GREY_10  :  grey_to_bin = BIN_10 ; 
      GREY_11  :  grey_to_bin = BIN_11 ; 
      default :  grey_to_bin = BIN_0 ;
//      default :  grey_to_bin = BIN_X ;
    endcase
endfunction

/*
* Check whether the state of FIFO is full or not
* The write pointer may be 6 more than read pointer
*/
function fifo_full;
  input [ 3 : 0 ] wr_ptr_grey;
  input [ 3 : 0 ] rd_ptr_grey;
  case( { wr_ptr_grey , rd_ptr_grey } )
    { GREY_0 , GREY_6 } :
    { GREY_6 , GREY_0 } :
    { GREY_1 , GREY_7 } :
    { GREY_7 , GREY_1 } :
    { GREY_2 , GREY_8 } :
    { GREY_8 , GREY_2 } :
    { GREY_3 , GREY_9 } :
    { GREY_9 , GREY_3 } :
    { GREY_4 , GREY_10 } :
    { GREY_10 , GREY_4 } :
    { GREY_5 , GREY_11 } :
    { GREY_11 , GREY_5 } : fifo_full = FULL ;
    default : fifo_full = ~ FULL ;
  endcase
endfunction

/*
* Check whether the state of FIFO is empty or not
*/
function fifo_empty;
  input [ 3 : 0 ] wr_ptr_grey;
  input [ 3 : 0 ] rd_ptr_grey;
  case( { wr_ptr_grey , rd_ptr_grey } )
    { GREY_0  , GREY_0 } : 
    { GREY_1  , GREY_1 } : 
    { GREY_2  , GREY_2 } : 
    { GREY_3  , GREY_3 } : 
    { GREY_4  , GREY_4 } : 
    { GREY_5  , GREY_5 } : 
    { GREY_6  , GREY_6 } : 
    { GREY_7  , GREY_7 } : 
    { GREY_8  , GREY_8 } : 
    { GREY_9  , GREY_9 } : 
    { GREY_10 , GREY_10} : 
    { GREY_11 , GREY_11} : fifo_empty = EMPTY ;
    default : fifo_empty = ~ EMPTY ;
  endcase
endfunction

function next_bin;
  input  [ 3 : 0 ]  inbin;
  case( inbin )
    BIN_0 : next_bin = BIN_1;
    BIN_1 : next_bin = BIN_2;
    BIN_2 : next_bin = BIN_3;
    BIN_3 : next_bin = BIN_4;
    BIN_4 : next_bin = BIN_5;
    BIN_5 : next_bin = BIN_6;
    BIN_6 : next_bin = BIN_7;
    BIN_7 : next_bin = BIN_8;
    BIN_8 : next_bin = BIN_9;
    BIN_9 : next_bin = BIN_10;
    BIN_10 : next_bin = BIN_11;
    BIN_11 : next_bin = BIN_0;
    default : next_bin = BIN_0;
//    default : next_bin = BIN_X;
  endcase
endfunction


function next_grey;
  input [ 3 : 0 ] ingrey;
  case( ingrey )
    GREY_0 : next_grey = GREY_1;
    GREY_1 : next_grey = GREY_2;
    GREY_2 : next_grey = GREY_3;
    GREY_3 : next_grey = GREY_4;
    GREY_4 : next_grey = GREY_5;
    GREY_5 : next_grey = GREY_6;
    GREY_6 : next_grey = GREY_7;
    GREY_7 : next_grey = GREY_8;
    GREY_8 : next_grey = GREY_9;
    GREY_9 : next_grey = GREY_10;
    GREY_10 : next_grey = GREY_11;
    GREY_11 : next_grey = GREY_0;
    default : next_grey = GREY_0;
  endcase
endfunction