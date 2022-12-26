module FileChecker where
 --import Crypto.Hash             (hash, SHA256 (..), Digest)
 import Data.ByteString         (ByteString)
 import Data.Text.Encoding      (encodeUtf8)
 import qualified Data.Text.IO            as TIO

 fact :: Int -> Int
 fact x
  | (x == 0) = 1
  | (x > 0)  = x * fact(x-1) 