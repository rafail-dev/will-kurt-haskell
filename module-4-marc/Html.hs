{-# LANGUAGE OverloadedStrings #-}

module Html (booksToHtml) where

import Data.ByteString qualified as B
import Data.Text qualified as T
import Data.Text.Encoding qualified as E
import Data.Text.IO qualified as TIO
import Book (Book (..))

type Html = T.Text

bookToHtml :: Book -> Html
bookToHtml book =
  mconcat
    [ "<p>",
      "<strong>",
      title book,
      "</strong>",
      "<em>",
      author book,
      "</em>",
      "</p>"
    ]

template :: T.Text -> T.Text -> Html
template title text =
  mconcat
    [ "<!DOCTYPE html>",
      "<html>",
      "<head>",
      "<title>",
      title,
      "</title>",
      "</head>",
      "<body>",
      text,
      "</body>",
      "</html>"
    ]

booksToHtml :: [Book] -> Html
booksToHtml books = template "Books" $ (mconcat . (map bookToHtml)) books