module Main where
 import FileChecker
 import System.IO               (hFlush, stdout)

 main :: IO()
 main = do
   print("Please enter the input value/string here")
   line <- getLine
   print ("The user input is:")
   print (line)
