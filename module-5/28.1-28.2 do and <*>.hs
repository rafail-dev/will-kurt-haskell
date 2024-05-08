x :: String -> String -> String
x = (++)

ff :: IO String -> IO String -> IO String
ff v1 v2 = do
  v1' <- v1
  v2' <- v2
  return $ x v1' v2'

ff' :: IO String -> IO String -> IO String
ff' v1 v2 = x <$> v1 <*> v2