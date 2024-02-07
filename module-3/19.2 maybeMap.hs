maybeMap :: (a -> b) -> [Maybe a] -> [Maybe b]
maybeMap _ [] = []
maybeMap f ((Just a) : xs) = Just (f a) : maybeMap f xs
maybeMap f (Nothing : xs) = Nothing : maybeMap f xs

main = do
  print $ maybeMap (* 2) [Just 10, Nothing, Just 5]