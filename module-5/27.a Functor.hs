-- fmap :: (Functor f) => (a -> b) -> f a -> f b

-- instance Functor MyMaybe where
--   fmap f (Just v) = f v
--   fmap f Nothing = Nothing

-- :k Functor
-- Functor :: (* -> *) -> Constraint


main :: IO ()
main = do
  print $ fmap ((+ 1) . (* 2)) (Just 1)
  print $ fmap ((+ 1) . (* 2)) (Nothing)

  print $ ((+ 1) . (* 2)) <$> (Just 1)
  print $ ((+ 1) . (* 2)) <$> (Nothing)


