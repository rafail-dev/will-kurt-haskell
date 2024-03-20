{-# LANGUAGE OverloadedStrings #-}

{--
cabal install text --lib
--}

import Data.Text.Lazy qualified as TL
import Data.Text.Lazy.IO qualified as TLIO

toInts :: TL.Text -> [Int]
toInts = map (read . TL.unpack) . TL.lines

main :: IO ()
main = do
  userInput <- TLIO.getContents
  let numbers = toInts userInput
  print (sum numbers)