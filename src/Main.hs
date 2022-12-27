module Main where
 import Helpers
 import HashHelpers
 import System.IO               (hFlush, stdout)
 import qualified Data.ByteString.Lazy as LazyByteString
 
 main :: IO()
 main = do
  putStrLn("")
  putStrLn("---- HashHelper program ----")
  putStrLn("A simple utility tool for calculating hashes of strings or files, creating Merkle trees from various values and comparing files based on hash")
  putStrLn("Available command switches: ")
  putStrLn("   1: calculate a simple SHA 256 hash of a string in input")
  putStrLn("   2: calculate the SHA 256 hash of an existing file")
  putStrLn("   3: compare two files passed as input")
  putStrLn("   4: create a Merkle tree from a list of strings separated by a single space")
  putStrLn("   0: quit" )
  putStrLn("Enter your choice: ")
  line <- getLine 
  case line of
        "1" -> do putStrLn("Enter the string for which to calculate the hash: ")
                  str <- getLine
                  putStrLn ("Resulting hash is:") 
                  print $ computeStringHash $ str
                  main
        "2" -> do putStrLn("Enter an existing file path: ")
                  filePath <- getLine
                  fileContent <- LazyByteString.readFile filePath
                  putStrLn ("Resulting file hash is:") 
                  print $ computeLazyByteStringHash $ fileContent
                  main
        "0" -> do putStrLn("exited") 
  

  