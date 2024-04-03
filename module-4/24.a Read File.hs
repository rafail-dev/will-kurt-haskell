import System.IO

main = do
  descriptor <- openFile "24.a.txt" ReadMode

  hasLine <- not <$> hIsEOF descriptor
  firstLine <-
    if hasLine
      then hGetLine descriptor
      else return "File is empty"

  putStrLn firstLine