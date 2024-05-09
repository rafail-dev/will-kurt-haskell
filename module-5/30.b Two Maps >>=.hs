import Data.Map qualified as Map

type Username = String

type GamerId = Int

type Credits = Int

usernames :: [Username]
usernames = ["Username1", "Username2", "Username3", "Username4", "Username5", "Username6"]

usernameDB :: Map.Map GamerId Username
usernameDB =
  Map.fromList $
    zip [1 ..] usernames

creditsDB :: Map.Map Username Credits
creditsDB =
  Map.fromList $
    zip usernames [2000, 15000, 300, 12, 50000, 150000]

--

lookupUsername :: GamerId -> Maybe Username
lookupUsername = flip Map.lookup usernameDB

lookupCredits :: Username -> Maybe Credits
lookupCredits = flip Map.lookup creditsDB

-- creditsFromId :: GamerId -> Maybe PlayerCredits

{-
Maybe UserName
  -> (UserName -> Maybe PlayerCredits)
  -> Maybe PlayerCredits

Applicative f => f a -> (a -> f b) -> f b

-}

lookupCredits' :: Maybe Username -> Maybe Credits
lookupCredits' Nothing = Nothing
lookupCredits' (Just username) = lookupCredits username

creditsFromId' :: GamerId -> Maybe Credits
creditsFromId' id = lookupCredits' (lookupUsername id)

--

creditsFromId :: GamerId -> Maybe Credits
-- creditsFromId = (lookupCredits =<<) . lookupUsername
creditsFromId id = lookupUsername id >>= lookupCredits