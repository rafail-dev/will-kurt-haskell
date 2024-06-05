module Lib
  ( flip3,
    dup,
    withConnection,
  )
where

import Control.Exception (SomeException, bracket, try)
import Database.SQLite.Simple (Connection, close, open)

flip3 :: (a -> b -> c -> d) -> (b -> c -> a -> d)
flip3 f c a b = f b c a

dup :: a -> (a, a)
dup a = (a, a)

-- problem with lazy
-- withConnection :: (Connection -> IO ()) -> IO ()
-- withToolsDb action = do
--   conn <- open "tools.db"
--   action conn
--   close conn

withConnection :: (Connection -> IO a) -> IO (Either SomeException a)
withConnection action = bracket (open "tools.db") close $ \conn ->
  try (action conn)
