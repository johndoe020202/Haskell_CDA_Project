module Helpers where
 
 splitStringIntoList :: (Foldable f, Eq a) => a -> f a -> [[a]]
 splitStringIntoList l sep = foldr op [[]] sep
   where op x 
            | x == l = []:y:ys
            | otherwise      = (x:y):ys


 