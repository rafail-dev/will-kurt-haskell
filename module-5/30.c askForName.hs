askForName :: IO ()
askForName = putStrLn "What is your name?"

nameStatement :: String -> String
nameStatement name = "Hello, " ++ name ++ "!"

r1 :: IO ()
r1 =
  askForName
    >> getLine
    >>= (\name -> return $ nameStatement name)
    >>= putStrLn

r2 :: IO ()
r2 =
  askForName
    >> getLine
    >>= pure . nameStatement
    >>= putStrLn
