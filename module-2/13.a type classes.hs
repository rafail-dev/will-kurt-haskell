{-
ghci> :t 1
1 :: Num a => a
ghci>
-}

class Describable a where
  describe :: a -> String

{-
ghci> :info Describable
type Describable :: * -> Constraint
class Describable a where
  describe :: a -> String
  {-# MINIMAL describe #-}
        -- Defined at 13.a type classes.hs:1:1
ghci>
-}

data Icecream = Chocolate | Vanilla deriving (Show, Eq, Ord)

{-
ghci> :info Icecream
type Icecream :: *
data Icecream = Chocolate | Vanilla
        -- Defined at 13.a type classes.hs:14:1
instance Eq Icecream -- Defined at 13.a type classes.hs:14:53
instance Ord Icecream -- Defined at 13.a type classes.hs:14:57
instance Show Icecream -- Defined at 13.a type classes.hs:14:47
ghci>
-}

{-
Checking "Show"

ghci> Chocolate
Chocolate
ghci>
-}

{-
Checking "Eq"

ghci> Chocolate == Vanilla
False
ghci>
-}

{-
Checking "Ord"
Based on the order of declaration in the enumeration

ghci> Chocolate > Vanilla
True
ghci>
-}

