module HashHelpers where
 import Crypto.Hash             (hash, hashlazy, digestFromByteString, SHA256 (..), Digest)
 import Data.ByteString         (ByteString, unpack)
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
 digestToString a = Just $ show a
 
 safeJoinDigests :: Digest SHA256 -> Digest SHA256 -> Maybe [Char]
 safeJoinDigests a b = case digestToString a of
                   Nothing -> Nothing
                   Just c -> case digestToString b of
                             Nothing -> Nothing
                             Just d -> Just $ c ++ d 
 
 concatenateStringDigests :: Digest SHA256 -> Digest SHA256 -> [Char]
 concatenateStringDigests a b = show a ++ show b
 
 joinDigests :: Digest SHA256 -> Digest SHA256 -> Digest SHA256
 joinDigests a b = computeStringHash $ concatenateStringDigests a b
 
 joinDigestPairs :: [Digest SHA256] -> [Digest SHA256]
 joinDigestPairs [] = []
 joinDigestPairs [x] = [x]
 -- joinDigestPairs (x:y:[]) = [joinDigests x y]
 joinDigestPairs (x:y:ys) = (joinDigests x y) : joinDigestPairs ys

 merkleRoot :: [Digest SHA256] -> [Digest SHA256]
 merkleRoot [] = []
 merkleRoot [x] = [x]
 merkleRoot xs = merkleRoot $ concat (fmap joinDigestPairs (concatenateTwoByTwo xs))
 
 -- Unused
 joinStringDigests :: [Char] -> [Char] -> Maybe (Digest SHA256)
 joinStringDigests a b = case readDigestFromString a of
                         Nothing -> Nothing
                         Just dig1 -> case readDigestFromString b of
                                      Nothing -> Nothing
                                      Just dig2 -> Just $ joinDigests dig1 dig2