module Rental.Model (Rental (..)) where

import qualified Data.Text as T
import Data.Time (UTCTime)
import Database.SQLite.Simple (FromRow, field, fromRow)

data Rental = Rental
  { rentalId :: Int,
    userId :: Int,
    userName :: T.Text,
    toolId :: Int,
    toolName :: T.Text,
    checkoutAt :: UTCTime,
    returnAt :: Maybe UTCTime
  }

instance Show Rental where
  show rental =
    unlines
      [ "Rental ID: " ++ show (rentalId rental),
        "User ID: " ++ show (userId rental),
        "User Name: " ++ T.unpack (userName rental),
        "Tool ID: " ++ show (toolId rental),
        "Tool Name: " ++ T.unpack (toolName rental),
        "Checkout At: " ++ show (checkoutAt rental),
        "Return At: " ++ maybe "No return" show (returnAt rental)
      ]

instance FromRow Rental where
  fromRow =
    Rental
      <$> field
      <*> field
      <*> field
      <*> field
      <*> field
      <*> field
      <*> field
