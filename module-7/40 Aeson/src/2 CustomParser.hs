{-# LANGUAGE OverloadedStrings #-}

import Data.Aeson
import Data.ByteString.Lazy as BL
import Data.Text as T (Text)

data MyErrorMessage = MyErrorMessage
  { message :: T.Text,
    errorCode :: Int
  }
  deriving (Show)

instance FromJSON MyErrorMessage where
  parseJSON (Object v) =
    MyErrorMessage
      <$> v .: "message"
      <*> v .: "error"
  parseJSON _ = fail "Expected an object for MyErrorMessage"

instance ToJSON MyErrorMessage where
  toJSON (MyErrorMessage messageV errorCodeV) = object ["message" .= messageV, "error" .= errorCodeV]

sampleErrorMessageJSON :: BL.ByteString
sampleErrorMessageJSON = "{\"message\":\"Oops\", \"error\": 1}"

decoded :: Either String MyErrorMessage
decoded = eitherDecode sampleErrorMessageJSON

main :: IO ()
main = do
  case decoded of
    Left err -> print $ "Error: " ++ err
    Right msg -> print msg
