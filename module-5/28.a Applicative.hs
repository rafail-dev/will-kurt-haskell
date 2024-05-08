{-
(<*>) :: Applicative f => f (a -> b) -> f a -> f b
-}

maybeS1 :: Maybe String
maybeS1 = Just "Alan"

maybeS2 :: Maybe String
maybeS2 = Just "Turing"

concat2Maybe :: Maybe String -> Maybe String -> Maybe String
concat2Maybe (Just v1) (Just v2) = Just $ v1 ++ " " ++ v2
concat2Maybe _ _ = Nothing

concat2 :: Maybe String -> Maybe String -> Maybe String
concat2 maybeS1 maybeS2 = (<>) <$> maybeS1 <*> maybeS2

concat2' :: Maybe String -> Maybe String -> Maybe String
concat2' = (<*>) . ((<>) <$>)

--

maybeInc :: Maybe (Integer -> Integer)
maybeInc = (+) <$> Just 1

applicative :: Maybe Integer
applicative = maybeInc <*> Just 1

--

resultFrom2Arg :: Maybe Integer
resultFrom2Arg = (+) <$> Just 1 <*> Just 2

resultFrom3Arg :: Maybe Integer
resultFrom3Arg = addThree <$> Just 1 <*> Just 2 <*> Just 3
  where
    addThree :: (Num a) => a -> a -> a -> a
    addThree a b c = a + b + c
