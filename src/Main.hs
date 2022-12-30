module Main where
 import Helpers
 import HashHelpers
 import System.IO               (hFlush, stdout)
 import Data.Maybe
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
        "3" -> do putStrLn("Enter the first existing file path: ")
                  filePath1 <- getLine
                  putStrLn("Enter the second existing file path: ")
                  filePath2 <- getLine
                  fileContent1 <- LazyByteString.readFile filePath1
                  fileContent2 <- LazyByteString.readFile filePath2
                  putStrLn ("Comparison result:")
                  print $ compareFiles fileContent1 fileContent2
                  main
        "4" -> do putStrLn("Enter a separator character: ")
                  sep <- getLine
                  putStrLn("Enter a list of strings separated by the character you just provided:")
                  strLn <- getLine
                  putStrLn("Result:")
                  let ch = safeHead sep
                  print $ fromJust ch
                  case ch of
                    Nothing -> putStrLn ("not good, no separator char")
                    _ -> do 
                         let chVal = fromJust ch
                         let f = (\c -> c == chVal)
                         let wordsList = wordsWhen f strLn
                         print $ createHashList wordsList                
                  main   
        "0" -> do putStrLn("exited") 
  

  