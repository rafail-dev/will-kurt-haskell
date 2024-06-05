module User.Actions (add, delete, findAll) where

import Control.Exception (SomeException)
import Database.SQLite.Simple (Only (Only), execute, query, query_)
import Lib (flip3, withConnection)
import User.Model (User (..))

add :: String -> IO (Either SomeException ())
add name' =
  withConnection $
    flip3
      execute
      "INSERT INTO user (name) VALUES (?);"
      (Only name')

delete :: Int -> IO (Either SomeException ())
delete userId' =
  withConnection $
    flip3
      execute
      "DELETE FROM user WHERE id = ?;"
      (Only userId')

findAll :: String -> IO (Either SomeException [User])
findAll search =
  withConnection $
    case search of
      "" -> flip query_ "SELECT * FROM user;"
      v -> flip3 query "SELECT * FROM user WHERE name like ('%' || ? || '%');" (Only v)
