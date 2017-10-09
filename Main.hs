module Main where
import USLS.Usless
 
ii :: (Accessible t) => t -> Signal
ii mem = 
    evaluate mem (CallPack 0x0 Negative)         
    

main :: IO()
main = 
    print $ ii [(MultiplexerInput Zero Positive Zero)]