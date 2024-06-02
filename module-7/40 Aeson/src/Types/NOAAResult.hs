module Types.NOAAResult (NOAAResult (..)) where

import Data.Aeson
import Data.Text as T (Text)

data NOAAResult = NOAAResult
  { uid :: T.Text,
    minDate :: T.Text,
    maxDate :: T.Text,
    name :: T.Text,
    datacoverage :: Float,
    resultId :: T.Text
  }
  deriving (Show)

instance FromJSON NOAAResult where
  parseJSON (Object v) =
    NOAAResult
      <$> v .: "uid"
      <*> v .: "mindate"
      <*> v .: "maxdate"
      <*> v .: "name"
      <*> v .: "datacoverage"
      <*> v .: "id"
  parseJSON _ = fail "Only objects"

instance ToJSON NOAAResult where
  toJSON NOAAResult {..} =
    object
      [ "uid" .= uid,
        "mindate" .= minDate,
        "maxdate" .= maxDate,
        "name" .= name,
        "datacoverage" .= datacoverage,
        "id" .= resultId
      ]
