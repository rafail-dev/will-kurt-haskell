{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use newtype instead of data" #-}

data Book = Book
  { title :: String,
    bookTitle :: String
  }

-- Multiple declarations of ‘title’
data Vinyl = Vinyl
  { -- title :: String,
    vinylTitle :: String
  }