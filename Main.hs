module Main where
import USLS.Usless
import qualified USLS.ASMCalc as AC
main :: IO()
main = 
    print $ AC.memoryadd [(MultiplexerInput Positive Negative Zero)]