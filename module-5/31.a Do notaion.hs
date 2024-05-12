maxPairM :: (Monad m, Ord a) => m (a, a) -> m a
maxPairM v = v >>= (\(v1, v2) -> pure $ max v1 v2)

maxPairM' :: (Monad m, Ord a) => m (a, a) -> m a
maxPairM' v = do
  (v1, v2) <- v
  pure $ max v1 v2

-- from 30.c askForName

askForName :: IO ()
askForName = putStrLn "What is your name?"

nameStatement :: String -> String
nameStatement name = "Hello, " ++ name ++ "!"

helloNameDo :: IO ()
helloNameDo = do
  askForName
  name <- getLine
  putStrLn $ nameStatement name
