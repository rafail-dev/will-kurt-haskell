module Types.Metadata (Metadata (..)) where

import Data.Aeson
import GHC.Generics (Generic)
import Types.Resultset (Resultset)

data Metadata where
  Metadata :: {resultset :: Resultset} -> Metadata
  deriving (Show, Generic)

instance FromJSON Metadata

instance ToJSON Metadata
