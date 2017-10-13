module Main where
import USLS.Usless
import USLS.MultiplexerOperators

{-
    now lets implement the simple add function of 2 arguments.
    of course by multiplexers. so, we are taking 2 signals from 
    the only multiplexer in the MRAM chip: Negative and Zero ones.
    since the multiolexer is defined as a NOP
    the truth table looks like this for this functions: 
        ________________
        |_ADD_|____B___|
        |(a+b)|-1  0  1|
        +-----+--------|
        | |-1 | 1 -1  0|
        |A| 0 |-1  0  1|
        | | 1 | 0  1 -1|
        +--------------+
-}

additor :: MRAM -> Int -> Signal 
additor chip addr = 
    evaluate (higher >-> (lower >+> (argA >%#> nullMultiplexer <%^< argB))) (CallPack 0xffff Zero) where
        argA = evaluate chip (CallPack addr Negative)
        argB = evaluate chip (CallPack addr Zero)
        higher = Multiplexer argA (MultiplexerInput Positive Negative Zero) 
        lower  = Multiplexer argA (MultiplexerInput Zero Positive Negative)

main :: IO ()
main = 
    print $ additor chp 0x1 where 
        chp = [(MultiplexerInput Negative Negative Positive), (MultiplexerInput Positive Positive Positive)]
