import Data.Map qualified as Map

type Html = String

data RobotPart = RobotPart
  { name :: String,
    description :: String,
    cost :: Double,
    count :: Int
  }
  deriving (Show)

leftArm :: RobotPart
leftArm = RobotPart {name = "left arm", description = "left arm description", cost = 1000.00, count = 3}

rightArm :: RobotPart
rightArm = RobotPart {name = "right arm", description = "right arm description", cost = 1025.00, count = 5}

robotHead :: RobotPart
robotHead = RobotPart {name = "robot head", description = "robot head description", cost = 5092.25, count = 2}

db :: Map.Map Int RobotPart
db = Map.fromList $ zip [1 ..] [leftArm, rightArm, robotHead]

--

find :: Int -> Maybe RobotPart
find = flip Map.lookup db

prinMaybe :: (Show a) => Maybe a -> IO ()
prinMaybe (Just v) = putStrLn $ show v
prinMaybe _ = putStrLn "-"

main :: IO ()
main = do
  n <- getLine
  prinMaybe (cost <$> (find $ read n))