module Types.Resultset (Resultset (..)) where

import Data.Aeson
import GHC.Generics (Generic)

data Resultset = Resultset
  { offset :: Int,
    count :: Int,
    limit :: Int
  }
  deriving (Show, Generic)

instance FromJSON Resultset

instance ToJSON Resultset
