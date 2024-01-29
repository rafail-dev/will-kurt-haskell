cycleSucc :: (Bounded a, Enum a, Eq a) => a -> a
cycleSucc n = if n == maxBound then minBound else succ n

data MyType = Asterisk | DoubleAsterisk | TripleAsterisk
  deriving (Enum, Eq, Bounded)

-- same
-- instance Bounded MyType where
--   minBound = Asterisk
--   maxBound = TripleAsterisk

instance Show MyType where
  show :: MyType -> String
  show Asterisk = "*"
  show DoubleAsterisk = "**"
  show TripleAsterisk = "***"

main = do
  print $ cycleSucc (5 :: Word)
  print $ cycleSucc (maxBound :: Word)
  print $ cycleSucc (5 :: Int)
  print $ cycleSucc (maxBound :: Int)
  print $ cycleSucc TripleAsterisk
  print $ cycleSucc Asterisk

{-
errors
print $ cycleSucc (5)
print $ cycleSucc (5 :: Integer)
Integer not Bounded

ghci> :info Integer
type Integer :: *
data Integer
  = GHC.Num.Integer.IS GHC.Prim.Int#
  | GHC.Num.Integer.IP GHC.Prim.ByteArray#
  | GHC.Num.Integer.IN GHC.Prim.ByteArray#
        -- Defined in ‘GHC.Num.Integer’
instance Read Integer -- Defined in ‘GHC.Read’
instance Enum Integer -- Defined in ‘GHC.Enum’
instance Eq Integer -- Defined in ‘GHC.Num.Integer’
instance Integral Integer -- Defined in ‘GHC.Real’
instance Num Integer -- Defined in ‘GHC.Num’
instance Ord Integer -- Defined in ‘GHC.Num.Integer’
instance Real Integer -- Defined in ‘GHC.Real’
instance Show Integer -- Defined in ‘GHC.Show’

-}