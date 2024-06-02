module MyList1 (MyList (..)) where

import Data.Aeson (FromJSON, ToJSON)
import GHC.Generics (Generic)

data MyList = Cons Int MyList | EmptyList deriving (Show, Generic)

instance FromJSON MyList

instance ToJSON MyList
