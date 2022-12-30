module Main where
 import Helpers
 import HashHelpers
 import qualified Data.ByteString.Lazy as LazyByteString
 import System.IO               (hFlush, stdout)
 import System.Directory
 import Data.Maybe
 
 
 main :: IO()
 main = do
  putStrLn $ ""
  putStrLn $ "---- HashHelper program ----"
  putStrLn $ "A simple utility tool for calculating hashes of strings or files, creating Merkle trees from various values and comparing files based on hash"
  putStrLn $ "Available command switches: "
  putStrLn $ "   1: calculate a simple SHA 256 hash of a string in input"
  putStrLn $ "   2: calculate the SHA 256 hash of an existing file"
  putStrLn $ "   3: compare two files passed as input"
  putStrLn $ "   4: create a Merkle tree from a list of strings separated by a single space"
  putStrLn $ "   0: quit" 
  putStrLn $ "Enter your choice: "
  line <- getLine 
  case line of
        "1" -> do putStrLn $ "Enter the string for which to calculate the hash: "
                  str <- getLine
                  putStrLn $ "Resulting hash is:" 
                  print $ computeStringHash $ str
                  main
        "2" -> do putStrLn $ "Enter an existing file path: "
                  filePath <- getLine
                  fileExists <- doesFileExist filePath
                  case fileExists of
                    False -> do 
                      putStrLn $ "File does not exist"
                      main
                    _ -> do
                      fileContent <- LazyByteString.readFile filePath
                      putStrLn  $ "Resulting file hash is:" 
                      print $ computeLazyByteStringHash $ fileContent
                      main
        "3" -> do putStrLn $ "Enter the first existing file path: "
                  filePath1 <- getLine
                  putStrLn  $ "Enter the second existing file path: "
                  filePath2 <- getLine
                  file1Exists <- doesFileExist filePath1
                  file2Exists <- doesFileExist filePath2
                  if file1Exists then
                    if file2Exists then
                      do
                      fileContent1 <- LazyByteString.readFile filePath1
                      fileContent2 <- LazyByteString.readFile filePath2
                      let comparison = compareFiles fileContent1 fileContent2
                      if comparison then
                        do
                          putStrLn $ "The files have the same hash"
                          main
                      else 
                        do 
                          putStrLn $ "The files are not the same"
                          main
                    else
                      do 
                        putStrLn $ "File 2 does not exist"
                        main
                  else
                    do
                      putStrLn $ "File 1 does not exist"
                      main
        "4" -> do putStrLn $ "Enter a separator character: "
                  sep <- getLine
                  putStrLn $ "Enter a list of strings separated by the character you just provided:"
                  strLn <- getLine
                  putStrLn $ "Result:"
                  let ch = safeHead sep
                  case ch of
                    Nothing -> putStrLn $ "not good, no separator char"
                    _ -> do 
                         let chVal = fromJust ch
                         let f = (\c -> c == chVal)
                         let wordsList = wordsWhen f strLn
                         print $ safeCreateHashList wordsList                
                  main   
        "0" -> do putStrLn $ "exited"
        _   -> do putStrLn $ "invalid choice"
                  main 
  

  