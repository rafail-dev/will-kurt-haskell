example :: Int
example = (*) ((+) 2 4) 6

exampleMaybe1 :: Maybe Int
exampleMaybe1 = pure $ (*) ((+) 2 4) 6

exampleMaybe2 :: Maybe Int
exampleMaybe2 = pure (*) <*> sub <*> Just 6
  where
    sub = (+) <$> Just 2 <*> Just 4

exampleMaybe3 :: Maybe Int
exampleMaybe3 = pure (*) <*> sub <*> Just 6
  where
    sub = pure (+) <*> Just 2 <*> Just 4