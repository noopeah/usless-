module USLS.MOperators where
import USLS.Usless
leftMultAsNeg :: Multiplexer -> Multiplexer -> Multiplexer
leftMultAsNeg leftm (Multiplexer sel input) = 
    Multiplexer sel input{negativeInput=leftmEvaluated} where
        leftmEvaluated = evaluate leftm ecp
        ecp            = CallPack 0xeffe Zero
leftSigAsNeg :: Signal -> Multiplexer -> Multiplexer
leftSigAsNeg sig (Multiplexer sel (MultiplexerInput n o p)) = 
    Multiplexer sel (MultiplexerInput sig o p)
leftMultAsZero :: Multiplexer -> Multiplexer -> Multiplexer
leftMultAsZero leftm (Multiplexer sel input) = 
    Multiplexer sel input{zeroInput = elm} where
        elm = evaluate leftm ecp  --evaluated left multiplexer
        ecp = CallPack 0xeffe Zero
leftSigAsZero :: Signal -> Multiplexer -> Multiplexer
leftSigAsZero sig (Multiplexer sel (MultiplexerInput n o p)) = 
    Multiplexer sel (MultiplexerInput n sig p)
leftMultAsPos :: Multiplexer -> Multiplexer -> Multiplexer
leftMultAsPos leftm (Multiplexer sel input) = 
    Multiplexer sel input{positiveInput = elm} where
        elm = evaluate leftm ecp  --evaluated left multiplexer
        ecp = CallPack 0xeffe Zero
leftSigAsPos :: Signal -> Multiplexer -> Multiplexer
leftSigAsPos sig (Multiplexer sel (MultiplexerInput n o p)) = 
    Multiplexer sel (MultiplexerInput n o sig)
allMultAsAll :: (Multiplexer, Multiplexer, Multiplexer) -> Multiplexer -> Multiplexer
allMultAsAll (mn, mo, mp) (Multiplexer sel _) = 
    Multiplexer sel (MultiplexerInput emn emo emp) where
        emn = evaluate mn ecp
        emo = evaluate mo ecp
        emp = evaluate mp ecp
        ecp = CallPack 0xeffe Zero
allSigAsAll :: (Signal, Signal, Signal) -> Multiplexer -> Multiplexer
allSigAsAll (n,o,p) (Multiplexer sel _) = 
    Multiplexer sel (MultiplexerInput n o p)
leftMultAsSel :: Signal -> Multiplexer -> Multiplexer
leftMultAsSel sel (Multiplexer _ input) = 
    Multiplexer sel input     
leftSigAsSel :: Signal -> Multiplexer -> Multiplexer
leftSigAsSel sig (Multiplexer _ inp) = 
    Multiplexer sig inp   
