module USLS.MultiplexerOperators where
import USLS.Usless 
(>->) :: Multiplexer -> Multiplexer -> Multiplexer
(>->) leftm (Multiplexer sel input) = 
    Multiplexer sel input{negativeInput=leftmEvaluated} where
        leftmEvaluated = evaluate leftm ecp
        ecp            = CallPack 0xeffe Zero
(>#>) :: Multiplexer -> Multiplexer -> Multiplexer
(>#>) leftm (Multiplexer sel input) = 
    Multiplexer sel input{zeroInput = elm} where
        elm = evaluate leftm ecp  --evaluated left multiplexer
        ecp = CallPack 0xeffe Zero
(>+>) :: Multiplexer -> Multiplexer -> Multiplexer
(>+>) leftm (Multiplexer sel input) = 
    Multiplexer sel input{positiveInput = elm} where
        elm = evaluate leftm ecp  --evaluated left multiplexer
        ecp = CallPack 0xeffe Zero
(>@>) :: (Multiplexer, Multiplexer, Multiplexer) -> Multiplexer -> Multiplexer
(>@>) (mn, mo, mp) (Multiplexer sel _) = 
    Multiplexer sel (MultiplexerInput emn emo emp) where
        emn = evaluate mn ecp
        emo = evaluate mo ecp
        emp = evaluate mp ecp
        ecp = CallPack 0xeffe Zero
(>^>) :: Signal -> Multiplexer -> Multiplexer
(>^>) sel (Multiplexer _ input) = 
    Multiplexer sel input        
(<^<) :: Multiplexer -> Signal -> Multiplexer
(<^<) mult sel = sel >^> mult