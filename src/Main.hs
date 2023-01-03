module Main where
 import Helpers
 import HashHelpers
 import qualified Data.ByteString.Lazy as LazyByteString
 import System.IO               (hFlush, stdout)
 import System.Directory
 import Data.Maybe
 
 
 main :: IO()
 main = do
  putStrLn ""
  putStrLn "---- HashHelper program ----"
  putStrLn "A simple utility tool for calculating hashes of strings or files, creating Merkle trees from various values and comparing files based on hash"
  putStrLn "Available command switches: "
  putStrLn "   1: Calculate the SHA 256 hash of a string"
  putStrLn "   2: Calculate the SHA 256 hash of an existing file"
  putStrLn "   3: Compare two files"
  putStrLn "   4: Compute the Merkle root of a list of strings separated by a character"
  putStrLn "   5: Check hash of string present in file"
  putStrLn "   0: Quit" 
  putStrLn "Enter your choice: "
  line <- getLine 
  case line of
        "1" -> do putStrLn "Enter the string for which to calculate the hash: "
                  str <- getLine
                  putStrLn "Resulting hash is:" 
                  print $ computeStringHash str
                  main
        "2" -> do putStrLn "Enter an existing file path: "
                  filePath <- getLine
                  fileExists <- doesFileExist filePath
                  case fileExists of
                    False -> do 
                      putStrLn "ERROR: File does not exist"
                      main
                    _ -> do
                      fileContent <- LazyByteString.readFile filePath
                      putStrLn "Resulting file hash is:" 
                      print $ computeLazyByteStringHash fileContent
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
                          putStrLn "The files have the same hash"
                          main
                      else 
                        do 
                          putStrLn "The files are not the same"
                          main
                    else
                      do 
                        putStrLn $ "ERROR: File " ++ filePath2 ++ " does not exist"
                        main
                  else
                    do
                      putStrLn $ "ERROR: File " ++ filePath1 ++ " does not exist"
                      main
        "4" -> do putStrLn "Enter a separator character: "
                  sep <- getLine
                  putStrLn "Enter a list of strings separated by the character you just provided:"
                  strLn <- getLine
                  let ch = safeHead sep
                  case ch of
                    Nothing -> putStrLn "ERROR: Not good, invalid separator char"
                    _ -> do 
                         let chVal = fromJust ch
                         let f = (\c -> c == chVal)
                         let wordsList = wordsWhen f strLn
                         let hashedList = createHashList wordsList
                         putStrLn "The hashed list is:"
                         print hashedList
                         putStrLn "concatenatetwobytwo"
                         let x = concatenateTwoByTwo hashedList
                         print x
                         let mapps = fmap joinDigestPairs x
                         putStrLn $ "fmap joinDigestPairs x"
                         print mapps
                         let conc = concat mapps
                         print conc
                         putStrLn "The Merkle root is:" 
                         print $ merkleRoot hashedList          
                  main
        "5" -> do putStrLn $ "Enter a SHA 256 hash: "
                  hashInInput <- getLine
                  let digest = readDigestFromString hashInInput
                  case digest of
                    Nothing -> putStrLn "ERROR: Invalid digest in input"
                    _ -> do
                         putStrLn "Enter a separator character: "
                         sep <- getLine
                         let ch = safeHead sep
                         case ch of
                          Nothing -> putStrLn "ERROR: Not good, invalid separator char"
                          _ -> do 
                               putStrLn "Enter an existing file path: "
                               filePath <- getLine
                               fileExists <- doesFileExist filePath
                               case fileExists of
                                False -> do 
                                         putStrLn "ERROR: File does not exist"
                                _ -> do
                                     let chVal = fromJust ch
                                     let f = (\c -> c == chVal)
                                     contents <- readFile filePath
                                     let wordsList = wordsWhen f contents
                                     let wordsAndDigests = pairWordsAndDigests wordsList
                                     let properDigest = fromJust digest
                                     let filteredList = retrieveDigestIfPresent properDigest wordsAndDigests
                                     let foundValue = firstOfTupleList filteredList
                                     case foundValue of
                                      Nothing -> putStrLn "None of the values in the provided file corresponds to the provided hash"
                                      _ -> putStrLn $ "The hash provided input is present in the file and corresponds to the value: " ++ fromJust foundValue
                  main   
        "0" -> do putStrLn $ "Exited"
        _   -> do putStrLn $ "ERROR: Invalid choice"
                  main 