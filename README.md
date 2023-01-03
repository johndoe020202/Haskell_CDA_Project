# Haskell sample project - CDA

## This is a project meant for the Cardano CDA certification provided by emurgo.io

It is a simple utility console application written in Haskell which shows some use cases for the [cryptonite library](https://hackage.haskell.org/package/cryptonite):

## Application options
Upon execution the user is prompted with a menu consisting of the following options: 
  - "Calculate the SHA 256 hash of a string" - option "1":
  The user must input a string and the output will be the SHA 256 hash of the provided string

  - "Calculate the SHA 256 hash of an existing file" - option "2" <br>
  The user must input the path of an existing file. 
  If the file exists the output will be the SHA 256 hash of the file, if not an error is returned

  - "Compare two files" - option "3" <br>
  The user must input the paths of two existing files ksubmitted for comparison. If any of the files does not exist the user will be prompted with the appropriate error message. If the files exist the output will be the comparison of the hashes of the files provided.
  
  - "Compute the Merkle root of a list of strings separated by a character" - option "4" <br>
  The user is prompted to input a separator character. Afterwards the user is prompted to input a list of strings separated by the chosen character. If the user inputs an invalid character the output will be an error message explaining the issue.
  In the case of valid inputs the output will be a simple Merkle root computed from the list of strings provided as input
  
  - "Check hash of string present in file" - option "5" <br>
  The user is prompted to input a SHA 256 hash. Then the user is prompted to provide a separator character and the path of a text file containing plain text strings separated by the character provided. The program will check if the hash of any of the strings present in the text file corresponds to the hash provided in input. 
    
