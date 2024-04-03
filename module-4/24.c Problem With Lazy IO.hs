import System.IO

filename :: String
filename = "24.c.txt"

--  *** Exception: 24.c.txt: withFile: resource busy (file is locked)
attempt1 :: IO ()
attempt1 = do
  input <- readFile filename
  writeFile filename $ input ++ "!"

--  *** Exception: 24.c.txt: withFile: illegal operation (delayed read on closed handle)
attempt2 :: IO ()
attempt2 = do
  descriptor <- openFile filename ReadMode
  input <- hGetContents descriptor
  hClose descriptor
  writeFile filename $ input ++ "!"

--  working
attempt3 :: IO ()
attempt3 = do
  descriptor <- openFile filename ReadMode
  input <- hGetContents descriptor
  putStrLn input
  hClose descriptor
  writeFile filename $ input ++ "!"
