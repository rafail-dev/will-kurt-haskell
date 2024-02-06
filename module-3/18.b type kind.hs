{-
kind - type of type

ghci> :kind Int
Int :: *

ghci> :kind []
[] :: * -> *

gchi> :l "18.a type arguments.hs"
ghci> :kind Triple
Triple :: * -> *

ghci> :kind (,)
(,) :: * -> * -> *

-- import qualified  Data.Map as Map
ghci> :kind Map.Map
Map.Map :: * -> * -> *

ghci> :kind [Int]
[Int] :: *

gchi> :l "18.a type arguments.hs"
ghci> :kind Triple Char
Triple Char :: *

-}

