module MillerRabin
  ( test,
    MillerRabin (..),
  )
where

data MillerRabin
  = PossiblyPrime
  | Composite
  deriving (Show, Eq)

instance Semigroup MillerRabin where
  Composite <> _ = Composite
  _ <> Composite = Composite
  PossiblyPrime <> PossiblyPrime = PossiblyPrime

type S = Integer

type D = Integer

type A = Integer

type N = Integer

test :: Int -> Maybe MillerRabin
test n
  | n < 2 = Nothing
  | even n = Nothing
  | otherwise = do
      (s, d) <- decomposition (toInteger n - 1)
      pure $ check 4 d (toInteger n) s

decomposition :: Integer -> Maybe (S, D)
decomposition n
  | odd n = Nothing
  | otherwise = Just $ f (1, n `div` 2)
  where
    f :: (Integer, Integer) -> (Integer, Integer)
    f (degree, factor)
      | odd factor = (degree, factor)
      | otherwise = f (degree + 1, factor `div` 2)

check :: A -> D -> N -> S -> MillerRabin
check a d n s =
  if firstX `elem` [1, n - 1]
    then PossiblyPrime
    else f (nextX firstX) s
  where
    firstX = modExp a d n
    nextX v = modExp v 2 n
    f _ 0 = Composite
    f 1 _ = Composite
    f x s' =
      if x == (n - 1)
        then PossiblyPrime
        else f (nextX x) (s' - 1)

modExp :: Integer -> Integer -> Integer -> Integer
modExp base degree modulus
  | modulus == 1 = 0
  | degree == 0 = 1
  | even degree =
      let halfPower = modExp base (degree `div` 2) modulus
       in (halfPower * halfPower) `mod` modulus
  | otherwise = (base * modExp base (degree - 1) modulus) `mod` modulus
