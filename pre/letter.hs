module Main where

toPart recipient = "Dear " ++ recipient ++ "!\n"

bodyPart bookTitle = "Thank you for bying \"" ++ bookTitle ++ "\"!\n"

fromPart author = "Best regarts, \n" ++ author

createEmail recipient bookTitle author =
  toPart recipient
    ++ bodyPart bookTitle
    ++ fromPart author

main = do
  putStrLn "Кто получатель этого письма?"
  recipient <- getLine
  putStrLn "Название книги:"
  bookTitle <- getLine
  putStrLn "Кто автор этого письма?"
  author <- getLine
  putStrLn (createEmail recipient bookTitle author)
