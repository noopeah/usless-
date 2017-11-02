module Lib where
import USLS.Usless
import USLS.MOperators
import TLDL.Interpreter
import TLDL.ExampleOfTLDLSession
conv :: IO (IO ())
conv = fmap print $ session
