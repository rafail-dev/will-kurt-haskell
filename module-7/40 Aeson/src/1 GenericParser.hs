{-# LANGUAGE OverloadedStrings #-}

module Lib
  ( bookInJSON,
    bookFromJSON,
    bookFromWrongJSON,
  )
where

import Data.Aeson (FromJSON, ToJSON, decode, eitherDecode, encode)
import Data.ByteString.Lazy.Char8 as BLC (ByteString)
import Data.Text as T (Text)
import GHC.Generics (Generic)

data Book = Book
  { author :: T.Text,
    title :: String,
    year :: Int
  }
  deriving (Show, Generic)

instance FromJSON Book

instance ToJSON Book

bookInJSON :: BLC.ByteString
bookInJSON =
  encode
    Book
      { author = "Will Kurt",
        title = "Get Programming with Haskell",
        year = 2019
      }

--

bookFromJSON :: Maybe Book
bookFromJSON = decode "{\"author\":\"Will Kurt\",\"title\":\"Get Programming with Haskell\",\"year\":2019}"

bookFromWrongJSON :: Either String Book
bookFromWrongJSON = eitherDecode "{\"author\":\"Will Kurt\",\"title\":\"Get Programming with Haskell\",\"year\":\"2019\"}"
