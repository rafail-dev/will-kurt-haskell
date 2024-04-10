{-# LANGUAGE OverloadedStrings #-}

module Book where

import Data.ByteString (ByteString)
import Data.Text qualified as T

type Author = T.Text

type Title = T.Text

data Book = Book
  { author :: Author,
    title :: Title,
    binary :: ByteString
  }
  deriving (Show)

toBook :: (Maybe Author, Maybe Title, ByteString) -> Book
toBook (Just author, Just title, bs) = Book author title bs
toBook (_, Just title, bs) = Book "Unknown" title bs
toBook (Just author, _, bs) = Book author "Unknown" bs
toBook (_, _, bs) = Book "Error on parse" "Error on parse" bs