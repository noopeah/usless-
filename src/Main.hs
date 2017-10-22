module Main where
import USLS.Usless
import USLS.MOperators
import TLDL.Interpreter
import TLDL.ExampleOfTLDLSession
main :: IO (IO ())
main = fmap print $ session
