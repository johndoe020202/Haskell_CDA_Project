module FileChecker where
 import HashHelpers
 import qualified Data.ByteString.Lazy.Internal as LazyByteString

 compareFiles ::  LazyByteString.ByteString ->  LazyByteString.ByteString -> Bool
 compareFiles a b = computeLazyByteStringHash a == computeLazyByteStringHash b