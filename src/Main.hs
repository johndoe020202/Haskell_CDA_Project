module Main where
 import FileChecker
 import System.IO               (hFlush, stdout)

 main :: IO()
 main = do
   putStrLn("---- HashHelper program ----")
   putStrLn("A simple utility tool for calculating hashes of strings or files, creating Merkle trees from various values and comparing files based on hash")
   putStrLn("Available command switches: ")
   putStrLn("   -h: calculate a simple SHA 256 hash of a string in input")
   putStrLn("   -hf: calculate the SHA 256 hash of an existing file")
   putStrLn("   -cf: compare two files passed as input")
   putStrLn("   -m: create a Merkle tree from a list of strings separated by a single space")
   line <- getLine
   print ("The user input is:")
   print (line)
