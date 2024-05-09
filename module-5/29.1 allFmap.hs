allFmap :: Applicative f => (a -> b) -> f a -> f b
allFmap f v = pure f <*> v