module Rental.Actions (checkout, return', find) where

import Control.Exception (SomeException)
import Data.FileEmbed (embedStringFile)
import Data.Time (getCurrentTime)
import Database.SQLite.Simple (Only (Only), Query (..), execute, query)
import Lib (flip3, withConnection)
import Rental.Model (Rental (..))

checkout :: Int -> Int -> IO (Either SomeException ())
checkout userId' toolId' =
  withConnection $
    flip3
      execute
      "INSERT INTO rental (user_id, tool_id) VALUES (?, ?)"
      (userId', toolId')

return' :: Int -> IO (Either SomeException ())
return' rentId' = do
  time <- getCurrentTime
  withConnection $
    flip3
      execute
      "UPDATE rental SET returnAt = ? WHERE id = ?"
      (time, rentId')

find :: Bool -> IO (Either SomeException [Rental])
find onlyActual =
  withConnection $
    \conn ->
      query
        conn
        sql
        (Only $ not onlyActual)
  where
    sql = Query $(embedStringFile "src/Rental/find.sql")
