module HashHelpers where
 import Crypto.Hash             (hash, hashlazy, digestFromByteString, SHA256 (..), Digest)
 import Data.ByteString         (ByteString, unpack)
 import Data.ByteArray
 import Helpers
 import Text.Read
 import Data.Maybe
 import qualified Data.ByteString.Char8 as Char8BS
 import qualified Data.ByteString.Lazy.Internal as LazyByteString

 computeStringHash :: [Char] -> Digest SHA256
 computeStringHash a = hash $ Char8BS.pack a 
 
 safeComputeStringHash :: Maybe [Char] -> Maybe (Digest SHA256)
 safeComputeStringHash a 
  | a == Nothing = Nothing 
  | otherwise = Just $ hash $ Char8BS.pack $ fromJust a 

 computeLazyByteStringHash :: LazyByteString.ByteString  -> Digest SHA256
 computeLazyByteStringHash  l = hashlazy l

 compareFiles ::  LazyByteString.ByteString -> LazyByteString.ByteString -> Bool
 compareFiles a b = computeLazyByteStringHash a == computeLazyByteStringHash b

 createHashList :: [[Char]] -> [Digest SHA256]
 createHashList a = fmap computeStringHash a 

 safeCreateHashList :: [[Char]] -> Maybe [Digest SHA256]
 safeCreateHashList a  
  | a == []   = Nothing
  | otherwise = Just $ createHashList a 
 
 pairWordsAndDigests :: [[Char]] -> [([Char], Digest SHA256)]
 pairWordsAndDigests xs = [(x, computeStringHash x)| x <- xs] 

 returnValueIfHashFound :: [([Char], Digest SHA256)] -> Maybe [Char]
 returnValueIfHashFound l = firstOfTupleList l 
 
 retrieveDigestIfPresent :: Digest SHA256 -> [([Char], Digest SHA256)] -> [([Char], Digest SHA256)]
 retrieveDigestIfPresent a xs = filter (\(x,y) -> a == y) xs 
  
 readDigestFromString :: [Char] -> Maybe (Digest SHA256)
 readDigestFromString a = readMaybe a

 digestToString :: Digest SHA256 -> Maybe [Char] 
 digestToString a = case convert a of
                    Nothing -> Nothing
                    Just c -> Just $ Char8BS.unpack $ fromJust c 
 
 joinDigests :: Digest SHA256 -> Digest SHA256 -> Maybe [Char]
 joinDigests a b = case digestToString a of
                   Nothing -> Nothing
                   Just c -> case digestToString b of
                             Nothing -> Nothing
                             Just d -> Just $ c ++ d 
                             
 -- TODO 
 --merkleTree :: Maybe [Digest SHA256] -> Maybe [Digest SHA256]
 --merkleTree []  = []
 --merkleTree [x] = [a | a <- Just x] 
 --merkleTree (x:y:ys) = [b | b <- safeComputeStringHash $ joinDigests x y] : merkleTree ys