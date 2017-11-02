--module TLDL.Interpreter ( readCommandPromt 
--                        , printToCommandPromt ) where
module TLDL.Interpreter where
import USLS.Usless
import USLS.MOperators 
import Data.List.Split (splitOn)
import System.IO

-- fist thing to implement is the `random access memory` functional
-- these are: peek(addr)
--            poke(addr, addressingSignal, signalToSet)
-- another thing is the `hard disk` interaction:
--            saveCurrentState() 
--            loadState(contentsOfDumpFile)            

poke :: MRAM -> Int -> Signal -> Signal -> MRAM
poke chip addr pos sig -- like in the BASIC on Commodore PET 2001)
    | pos == Positive = replaceNth addr (chip !! addr){positiveInput = sig} chip 
    | pos == Zero     = replaceNth addr (chip !! addr){zeroInput     = sig} chip 
    | pos == Negative = replaceNth addr (chip !! addr){negativeInput = sig} chip 

peek :: MRAM -> Int -> MultiplexerInput
peek chip addr = chip !! addr

saveCurrentState :: MRAM -> [IO()]
saveCurrentState chip = 
    map (\(MultiplexerInput n o p) -> writeFile "dump.!" $ concat [show n,".",show o,".",show p]) chip  
    

loadState :: String -> MRAM
loadState dump = 
    let mis     = map (\x -> splitOn "." x) (splitOn "\n" dump)
        signals = map (\x -> map (\y -> read y :: Signal) x) mis in --FIXME: looks really bad
        map (\(n:o:p:_)->MultiplexerInput n o p) signals

replaceNth :: Int -> a -> [a] -> [a]
replaceNth n newVal (x:xs)
    | n == 0 = newVal:xs
    | otherwise = x:replaceNth (n-1) newVal xs

