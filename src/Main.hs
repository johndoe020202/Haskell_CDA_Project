module Main where
 import Helpers
 import System.IO               (hFlush, stdout)

 promptLine :: String -> IO String
 promptLine prompt = do
    putStr prompt
    getLine
 
 main :: IO()
 main = do
  putStrLn("")
  putStrLn("---- HashHelper program ----")
  putStrLn("A simple utility tool for calculating hashes of strings or files, creating Merkle trees from various values and comparing files based on hash")
  putStrLn("Available command switches: ")
  putStrLn("   -h: calculate a simple SHA 256 hash of a string in input")
  putStrLn("   -hf: calculate the SHA 256 hash of an existing file")
  putStrLn("   -cf: compare two files passed as input")
  putStrLn("   -m: create a Merkle tree from a list of strings separated by a single space")
  putStrLn("   -q: quit" )
  line <- promptLine("Enter your choice: ") 
    let v = isValid $ checkSwitch(line) in do
    if(v == False) 
      then putStrLn("Invalid choice") main
      else 

  