module Main where
 import FileChecker
 import Crypto.Hash             (hash, SHA256 (..), Digest)
 import Data.ByteString         (ByteString)
 import Data.Text.Encoding      (encodeUtf8)
 import qualified Data.Text.IO            as TIO
 import System.IO               (hFlush, stdout)

 main :: IO()
 main = do
   print("Please enter the input value/string here")
-- initializing variable with output from getLine function
   line <- getLine
   print ("The user input is:")
   print (line)