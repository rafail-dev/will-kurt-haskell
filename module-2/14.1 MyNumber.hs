data MyNumber = One | Two | Three | Four | Five deriving (Enum)

{-
ghci> :info Eq
type Eq :: * -> Constraint
class Eq a where
  (==) :: a -> a -> Bool
  (/=) :: a -> a -> Bool
  {-# MINIMAL (==) | (/=) #-}
-}

instance Eq MyNumber where
  (==) :: MyNumber -> MyNumber -> Bool
  (==) n1 n2 = fromEnum n1 == fromEnum n2
