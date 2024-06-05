module User.Model (User (..)) where

import qualified Data.Text as T
import Database.SQLite.Simple.FromRow

data User = User
  { userId :: Int,
    username :: T.Text
  }

instance Show User where
  show user =
    mconcat
      [ show $ userId user,
        ") ",
        T.unpack $ username user
      ]

instance FromRow User where
  fromRow =
    User
      <$> field
      <*> field
