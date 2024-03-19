{--
cabal install containers --lib
--}
module Homework211 where

import Data.Map qualified as Map (Map, fromList, lookup)

helloPerson :: String -> String
helloPerson name = "Hello " <> name <> "!"

persons :: Map.Map Word String
persons = Map.fromList [(1, "Kurt")]

main :: Maybe String
main = do
  name <- Map.lookup 1 persons
  return $ helloPerson name