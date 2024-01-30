-- like a triangular prism
data FiveSidedDie = S1 | S2 | S3 | S4 | S5 deriving (Show)

class Die a where
  turnOver :: a -> [a]

instance Die FiveSidedDie where
  turnOver :: FiveSidedDie -> [FiveSidedDie]
  turnOver S1 = [S5]
  turnOver S2 = [S3, S4]
  turnOver S3 = [S1, S4]
  turnOver S4 = [S2, S3]
  turnOver S5 = [S1]

myPrism :: FiveSidedDie
myPrism = S2

main :: IO ()
main = do
  print $ turnOver myPrism