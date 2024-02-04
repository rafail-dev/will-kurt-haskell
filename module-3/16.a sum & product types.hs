type FirstName = String

type MiddleName = String

type Surname = String

-- OR - Sum (|) & AND - Product (FirstName Surname ...)
data Name = NameWithoutMiddleName FirstName Surname | NameWithMiddleName FirstName MiddleName Surname

newtype Author = Author Name

-- OR - Sum
data Artist = Person Name | Band String

-- OR - Sum
data Creator = AuthorCreator Author | ArtistCreator Artist

-- AND - Product
data Book = Book
  { bookAuthor :: Author,
    bookIsbn :: String,
    bookTitle :: String,
    bookYear :: Int,
    bookPrice :: Double
  }

-- prefix vinyl|book -> name conflict
data Vinyl = Vinyl
  { vinylCreator :: Creator,
    vinylTitle :: String,
    vinylYear :: Int,
    vinylPrice :: Double
  }
