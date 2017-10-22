module TLDL.ExampleOfTLDLSession where
import TLDL.Interpreter
import USLS.Usless
import System.IO(readFile)

session :: IO MRAM
session = do
    let smem = [(MultiplexerInput Zero Zero Zero),(MultiplexerInput Positive Zero Negative),(MultiplexerInput Zero Zero Zero),(MultiplexerInput Zero Zero Positive)]
    let mem  = poke smem 0x2 Zero Positive
    print $ peek smem 0x2
    print $ mem
    sequence_ (saveCurrentState mem)
    fmap loadState $ readFile "dump.!" 
