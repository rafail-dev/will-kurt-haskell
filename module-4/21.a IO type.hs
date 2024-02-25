f1 :: IO ()
f1 = do
  {-
      f1 :: IO ()
      putStrLn :: String -> IO ()

      () - empty tuple
  -}
  putStrLn "Hello"

{-
    ghci> :kind Maybe
    Maybe :: * -> *
    ghci> :kind IO
    IO :: * -> *
    ghci>
-}

main :: IO ()
main = do
  putStrLn "Hello!"
  input <- getLine
  -- getLine :: IO String
  -- input :: String
  let statement = reverse input
  putStrLn statement

{-
    main isn’t a function - it doesn’t return a value
    main as an IO action
-}