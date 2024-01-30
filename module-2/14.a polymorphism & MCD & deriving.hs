data Box = S | M | L | XL deriving (Enum)

instance Show Box where
  show :: Box -> String
  show S = "Small Box"
  show M = "Medium Box"
  show L = "Large Box"
  show XL = "Extra Large Box"

instance Eq Box where
  (==) S S = True
  (==) M M = True
  (==) L L = True
  (==) XL XL = True
  (==) _ _ = False

-- /= automatically

{-
Minimal COmplete Definition
ghci> :info Eq
type Eq :: * -> Constraint
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
  ...

https://hackage.haskell.org/package/base-4.19.0.0/docs/Data-Eq.html#t:Eq

-}

instance Ord Box where
  compare :: Box -> Box -> Ordering
  compare XL XL = EQ
  compare XL _ = GT
  compare _ XL = LT
  compare L L = EQ
  compare L _ = GT
  compare _ L = LT
  compare M M = EQ
  compare M _ = GT
  compare _ M = LT
  compare S S = EQ

-- problem
-- prefer ... deriving (Ord)

result1 :: [Box]
result1 = [S .. L]

-- [Small Box,Medium Box,Large Box]

result2 :: [Box]
result2 = [M ..]

-- [Medium Box,Large Box,Extra Large Box]

{-
problem with manual Enum

instance Enum Box where
  fromEnum S = 0
  fromEnum M = 1
  fromEnum L = 2
  fromEnum XL = 3
  toEnum 0 = S
  toEnum 1 = M
  toEnum 2 = L
  toEnum 3 = XL

[S..]
[Medium Box,Large Box,Extra Large Box,*** Exception: ... Non-exhaustive patterns in function toEnum

-}