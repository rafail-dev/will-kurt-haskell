-- for "Pattern match(es) are non-exhaustive" in price f
{-# OPTIONS_GHC -Wall #-}

type FirstName = String

type Surname = String

data Name = Name FirstName Surname

newtype Author = Author Name

data Artist = Person Name | Band String

data Creator = AuthorCreator Author | ArtistCreator Artist

data StoreItem = BookItem Book | VinylItem Vinyl | ToyItem Toy | PamphletItem Pamphlet

data Book = Book
  { bookAuthor :: Author,
    bookIsbn :: String,
    bookTitle :: String,
    bookYear :: Int,
    bookPrice :: Double
  }

data Vinyl = Vinyl
  { vinylCreator :: Creator,
    vinylTitle :: String,
    vinylYear :: Int,
    vinylPrice :: Double
  }

data Toy = Toy
  { toyName :: String,
    toyDescrption :: String,
    toyPrice :: Double
  }

data Pamphlet = Pamphlet
  { pamphletTitle :: String,
    pamphletDescription :: String,
    pamphletContact :: String
  }

price :: StoreItem -> Double
price (BookItem item) = bookPrice item
price (VinylItem item) = vinylPrice item
price (ToyItem item) = toyPrice item
price (PamphletItem _) = 10 -- fix price
