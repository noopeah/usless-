{-#LANGUAGE TypeSynonymInstances#-}
{-#LANGUAGE FlexibleInstances#-}
module USLS.Usless where
import Data.Int (Int8, Int32)
import Data.Maybe
import Data.List

data Signal = Positive | Zero | Negative 
    deriving(Show, Eq, Read)
data CallPack = CallPack 
    { address      :: Int
    , dataPinInput :: Signal}
data MultiplexerInput = MultiplexerInput
    { negativeInput  :: Signal
    , zeroInput      :: Signal
    , positiveInput  :: Signal}
    deriving(Show, Eq)
data Multiplexer = Multiplexer
    { selector :: Signal
    , input    :: MultiplexerInput} 
    deriving(Show, Eq)
type MRAM = [MultiplexerInput]
class Accessible t where
    evaluate :: t -> CallPack -> Signal 
instance Ord Signal where 
    compare Positive _ = GT
    compare Zero Negative = GT
    compare Zero Positive = LT
    compare Negative _ = LT
instance Accessible Multiplexer where 
    evaluate (Multiplexer s i) _ --FIXME: add the trustworthy callblocks check
        | s == Positive = positiveInput i
        | s == Zero     = zeroInput i
        | s == Negative = negativeInput i
        | otherwise     = error $ "unaccessible element passed"
instance Accessible MRAM where 
    evaluate chip cp =
        evaluate (Multiplexer sel inp) ecp where
            sel = dataPinInput cp
            inp = chip !! (address cp)
            ecp = CallPack 0xeffe Zero -- an empty message analog. always refers to 0x0

nullMultiplexer = Multiplexer Zero (MultiplexerInput Zero Zero Zero)