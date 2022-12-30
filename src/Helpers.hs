module Helpers where
 
 evaluateList :: (Eq a, Show a) => [a] -> Maybe [a]
 evaluateList [a]
  | null $ [a]  = Nothing
  | otherwise   = Just [a]


 wordsWhen :: (Char -> Bool) -> [Char] -> [[Char]]
 wordsWhen p s =  case dropWhile p s of
                      "" -> []
                      s' -> w : wordsWhen p s''
                            where (w, s'') = break p s'

 safeHead :: [Char] -> Maybe Char
 safeHead []     = Nothing
 safeHead (x:xs) = Just x  

 concatenateTwoByTwo :: [a] -> [[a]]
 concatenateTwoByTwo [] = [[]]
 concatenateTwoByTwo [a] = [[a]]
 concatenateTwoByTwo (x:y:ys) = [a | a <- x : y : []] : concatenateTwoByTwo ys
 
 concatenatePair :: [[String]] -> [String]
 concatenatePair a = map concat $ a 


  --print $ fromJust ch