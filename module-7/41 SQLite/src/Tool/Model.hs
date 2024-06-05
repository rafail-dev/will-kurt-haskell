module Tool.Model (Tool (..)) where

import qualified Data.Text as T
import Data.Time (UTCTime)
import Database.SQLite.Simple.FromRow (FromRow (..), field)

data Tool = Tool
  { toolId :: Int,
    name :: T.Text,
    description :: T.Text,
    lastReturned :: Maybe UTCTime,
    timesBorrowed :: Int
  }

instance Show Tool where
  show tool =
    mconcat
      [ show $ toolId tool,
        ") ",
        T.unpack $ name tool,
        "\n",
        T.unpack $ description tool,
        "\nlast returned: ",
        maybe "No returns" show (lastReturned tool),
        "\ntimes borrowed: ",
        show $ timesBorrowed tool
      ]

instance FromRow Tool where
  fromRow =
    Tool
      <$> field
      <*> field
      <*> field
      <*> field
      <*> field
