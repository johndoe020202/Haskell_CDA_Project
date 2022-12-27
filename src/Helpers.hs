module Helpers where
 
 data SwitchType = StringHash | FileHash | CompareFiles | MerkleTree | Quit | Invalid deriving (Show, Eq)
 data Choice = Choice { 
   switch :: SwitchType, 
   isValid:: Bool
  } deriving Show

 checkSwitch :: String -> Choice 
 checkSwitch value 
  | value == "-h"  = Choice StringHash True
  | value == "-hf" = Choice FileHash True
  | value == "-cf" = Choice CompareFiles True
  | value == "-m"  = Choice MerkleTree True
  | value == "-q"  = Choice Quit True
  | otherwise      = Choice Invalid False
