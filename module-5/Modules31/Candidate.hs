module Modules31.Candidate where

data Grade = F | D | C | B | A
  deriving (Eq, Ord, Enum, Show, Read)

data Degree = HS | BA | MS | PhD
  deriving (Eq, Ord, Enum, Show, Read)

data Candidate = Candidate
  { candidateId :: Int,
    codeReview :: Grade,
    cultureFir :: Grade,
    education :: Degree
  }
  deriving (Show)

viable :: Candidate -> Bool
viable candidate = all (== True) tests
  where
    passedCoding = codeReview candidate > B
    passedCultureFir = codeReview candidate > C
    educationMin = education candidate >= MS
    tests = [passedCoding, passedCultureFir, educationMin]