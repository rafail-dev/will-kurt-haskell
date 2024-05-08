import Data.Map qualified as Map

type Html = String

data RobotPart = RobotPart
  { name :: String,
    description :: String,
    cost :: Double,
    count :: Int
  }
  deriving (Show)

db :: Map.Map Int RobotPart
db =
  Map.fromList $
    zip
      [1 ..]
      [ RobotPart "left arm" "left arm description" 500.00 3,
        RobotPart "right arm" "right arm description" 550.00 3,
        RobotPart "robot arm" "robot arm description" 1000.00 3,
        RobotPart "left leg" "left alegrm description" 650.00 3,
        RobotPart "right leg" "right leg description" 600.00 3
      ]

readInt :: IO Int
readInt = read <$> getLine

find :: Int -> Maybe RobotPart
find = flip Map.lookup db

minCost :: RobotPart -> RobotPart -> RobotPart
minCost p1 p2 = if cost p1 < cost p1 then p1 else p2

main :: IO ()
main = do
  print "First"
  id1 <- readInt
  print "Second"
  id2 <- readInt
  print $ minCost <$> find id1 <*> find id2
