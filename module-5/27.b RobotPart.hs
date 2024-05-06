import Data.Map qualified as Map

type Html = String

data RobotPart = RobotPart
  { name :: String,
    description :: String,
    cost :: Double,
    count :: Int
  }
  deriving (Show)

partToHtml :: RobotPart -> Html
partToHtml part =
  mconcat
    [ "<div",
      "<h2>",
      name part,
      "</h2>",
      "<p>",
      description part,
      "</p>",
      "<p>Cost: ",
      show (cost part),
      "</p>",
      "<p>Count: ",
      show (count part),
      "</p>",
      "</div>"
    ]

leftArm :: RobotPart
leftArm = RobotPart {name = "left arm", description = "left arm description", cost = 1000.00, count = 3}

rightArm :: RobotPart
rightArm = RobotPart {name = "right arm", description = "right arm description", cost = 1025.00, count = 5}

robotHead :: RobotPart
robotHead = RobotPart {name = "robot head", description = "robot head description", cost = 5092.25, count = 2}

partDb :: Map.Map Int RobotPart
partDb = Map.fromList $ zip [1 ..] [leftArm, rightArm, robotHead]

--

partWithDoubleCost :: RobotPart -> RobotPart
partWithDoubleCost part = part {cost = 2 * cost part}

htmlDb :: Map.Map Int Html
htmlDb = partToHtml <$> partWithDoubleCost <$> partDb

--

leftArmIO :: IO RobotPart
leftArmIO = return leftArm

htmlSnippet :: IO Html
htmlSnippet = partToHtml <$> leftArmIO