module USLS.ASMCalc where
import USLS.Usless

memoryadd :: (Accessible m) => m -> Signal
memoryadd memory = 
    {-
        so, the thing we are implementing here is the simple 
        multiplexer add function of 2 arguments. we are going 
        to take values straight out of the passsed MRAM chip 
        passed into the function.
        the rmemrory, made out of 2 ternary multiplexers can 
        actually contain 6 values. so we need only one :-)
    -}
    evaluate (Multiplexer argB (MultiplexerInput (evaluate m0 ecp) argA (evaluate m1 ecp))) ecp where 
    -- ------^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ <- the last multiplexer
        ecp  = CallPack    0xeffe  Zero 
        argA = evaluate    memory  (CallPack         0x0      Negative) 
        argB = evaluate    memory  (CallPack         0x0      Zero)
        m0   = Multiplexer argA    (MultiplexerInput Positive Negative Zero)
        m1   = Multiplexer argA    (MultiplexerInput Zero     Positive Negative) 
 