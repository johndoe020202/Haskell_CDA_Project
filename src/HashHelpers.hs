module HashHelpers where
 import Crypto.Hash             (hash, SHA256 (..), Digest)
 import Data.ByteString         (ByteString)
 import qualified Data.ByteString.Char8 as Char8BS

 
 computeStringHash :: String -> Digest SHA256
 computeStringHash a = computeByteStringHash $ Char8BS.pack a 

 computeByteStringHash :: ByteString  -> Digest SHA256
 computeByteStringHash  a = hash a