module USLS.MultiplexerOperators where
import USLS.Usless
(>->) :: Multiplexer -> Multiplexer -> Multiplexer
(>->) leftm (Multiplexer sel input) = 
    Multiplexer sel input{negativeInput=leftmEvaluated} where
        leftmEvaluated = evaluate leftm ecp
        ecp            = CallPack 0xeffe Zero
(>%->) :: Signal -> Multiplexer -> Multiplexer
(>%->) sig (Multiplexer sel (MultiplexerInput n o p)) = 
    Multiplexer sel (MultiplexerInput sig o p)
(>#>) :: Multiplexer -> Multiplexer -> Multiplexer
(>#>) leftm (Multiplexer sel input) = 
    Multiplexer sel input{zeroInput = elm} where
        elm = evaluate leftm ecp  --evaluated left multiplexer
        ecp = CallPack 0xeffe Zero
(>%#>) :: Signal -> Multiplexer -> Multiplexer
(>%#>) sig (Multiplexer sel (MultiplexerInput n o p)) = 
    Multiplexer sel (MultiplexerInput n sig p)
(>+>) :: Multiplexer -> Multiplexer -> Multiplexer
(>+>) leftm (Multiplexer sel input) = 
    Multiplexer sel input{positiveInput = elm} where
        elm = evaluate leftm ecp  --evaluated left multiplexer
        ecp = CallPack 0xeffe Zero
(>%+>) :: Signal -> Multiplexer -> Multiplexer
(>%+>) sig (Multiplexer sel (MultiplexerInput n o p)) = 
    Multiplexer sel (MultiplexerInput n o sig)
(>@>) :: (Multiplexer, Multiplexer, Multiplexer) -> Multiplexer -> Multiplexer
(>@>) (mn, mo, mp) (Multiplexer sel _) = 
    Multiplexer sel (MultiplexerInput emn emo emp) where
        emn = evaluate mn ecp
        emo = evaluate mo ecp
        emp = evaluate mp ecp
        ecp = CallPack 0xeffe Zero
(>%@>) :: (Signal, Signal, Signal) -> Multiplexer -> Multiplexer
(>%@>) (n,o,p) (Multiplexer sel _) = 
    Multiplexer sel (MultiplexerInput n o p)
(>^>) :: Signal -> Multiplexer -> Multiplexer
(>^>) sel (Multiplexer _ input) = 
    Multiplexer sel input     
(>%^>) :: Signal -> Multiplexer -> Multiplexer
(>%^>) sig (Multiplexer _ inp) = 
    Multiplexer sig inp   
(<^<) :: Multiplexer -> Signal -> Multiplexer
(<^<) mult sel = sel >^> mult
(<%^<) :: Multiplexer -> Signal -> Multiplexer
(<%^<) mul sig = sig >%^> mul
