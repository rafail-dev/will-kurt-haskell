module User.Model (User (..)) where

import qualified Data.Text as T
import Database.SQLite.Simple.FromRow

data User = User
  { userId :: Int,
    name :: T.Text
  }

instance Show User where
  show user =
    mconcat
      [ show $ userId user,
        ") ",
        T.unpack $ name user
      ]

instance FromRow User where
  fromRow =
    User
      <$> field
      <*> field
