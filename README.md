# Haskell_CDA_Project

This is a project meant for the Cardano CDA certification provided by emurgo.io

It is a simple utility application written in Haskell which should provide the following use cases:
  1. If the arguments are 2 or more and the option provided is -f it should compare two or more files provided by the user as input and evaluate if the files are exctly the same
  2. If the argument is just one and the option provided is -f, so a file, it should output the hash (SHA256) of the file provided as input
  3. If the argument is just one and the option provided is -s, so a simple string,  it should output the hash (SHA256) of the string provided as input
