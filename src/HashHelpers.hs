module HashHelpers where
 import Crypto.Hash             (hash, hashlazy, SHA256 (..), Digest)
 import Data.ByteString         (ByteString)
 import qualified Data.ByteString.Char8 as Char8BS
 import qualified Data.ByteString.Lazy.Internal as LazyByteString
 

 computeStringHash :: String -> Digest SHA256
 computeStringHash a = computeByteStringHash $ Char8BS.pack a 

 computeByteStringHash :: ByteString  -> Digest SHA256
 computeByteStringHash  a = hash a

 computeLazyByteStringHash :: LazyByteString.ByteString  -> Digest SHA256
 computeLazyByteStringHash  l = hashlazy l