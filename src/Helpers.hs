module Helpers where
 
 splitStringIntoList :: (Foldable f, Eq a) => a -> f a -> [[a]]
 splitStringIntoList separator str = foldr op [[]] str
   where op x ~(y:ys)
            | x == separator = []:y:ys
            | otherwise      = (x:y):ys