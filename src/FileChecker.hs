module FileChecker where
 import Data.ByteString (ByteString)
 import qualified Data.ByteString as B

 fact :: Int -> Int
 fact x
  | (x == 0) = 1
  | (x > 0)  = x * fact(x-1) 