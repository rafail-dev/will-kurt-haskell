module Types.NOAAResponse
  ( NOAAResponse (..),
  )
where

import Data.Aeson
import GHC.Generics (Generic)
import Types.Metadata (Metadata)
import Types.NOAAResult (NOAAResult)

data NOAAResponse = NOAAResponse
  { metadata :: Metadata,
    results :: [NOAAResult]
  }
  deriving (Show, Generic)

instance FromJSON NOAAResponse
instance ToJSON NOAAResponse
