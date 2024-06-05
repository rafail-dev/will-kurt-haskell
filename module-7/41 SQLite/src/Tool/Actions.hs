module Tool.Actions (add, delete, findAll) where

import Control.Exception (SomeException)
import Data.FileEmbed (embedStringFile)
import Database.SQLite.Simple (Only (Only), Query (..), execute, query)
import Lib (dup, flip3, withConnection)
import Tool.Model (Tool (..))

add :: String -> String -> IO (Either SomeException ())
add name' description' =
  withConnection $
    flip3
      execute
      "INSERT INTO tools (name, description) VALUES (?, ?);"
      (name', description')

delete :: Int -> IO (Either SomeException ())
delete toolId' =
  withConnection $
    flip3
      execute
      "DELETE FROM tools WHERE id = (?);"
      (Only toolId')

findAll :: String -> IO (Either SomeException [Tool])
findAll search =
  withConnection $
    flip3
      query
      sql
      (dup search)
  where
    sql = Query $(embedStringFile "src/Tool/find-all.sql")
