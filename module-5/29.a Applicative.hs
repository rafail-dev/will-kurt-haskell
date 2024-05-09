{-
class Functor f => Applicative f where
    (<*>) :: f (a -> b) -> f a -> f b
    pure :: a -> f a
-}

doorPrize :: [Int]
doorPrize = [1000,2000,3000]

boxPrize :: [Int]
boxPrize = [500, 20000]

r1 :: [Int]
r1 = (pure (+)) <*> doorPrize <*> boxPrize