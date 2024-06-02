module Main
  ( main,
  )
where

import Control.Monad (forM_)
import Data.Aeson (eitherDecode, encode)
import Data.ByteString.Lazy as BL
  ( fromStrict,
    readFile,
    writeFile,
  )
import Data.Text as T (pack)
import Data.Text.Encoding as TE (encodeUtf8)
import qualified MyList1 as L1
import qualified MyList2 as L2
import NOAA (NOAAResponse (..), NOAAResult (..))

main :: IO ()
main = do
  jsonData <- BL.readFile "data/data.json"
  let parsed = eitherDecode jsonData :: Either String NOAAResponse

  case parsed of
    (Right v) -> do
      BL.writeFile "data/decoded-encoded.json" $ encode v
    (Left e) -> do
      BL.writeFile "data/error.txt" $ (BL.fromStrict . TE.encodeUtf8 . T.pack) e

  case results <$> parsed of
    (Right v) -> do
      forM_ v (print . name)
    (Left e) -> print e

  putStrLn ""

  let myList1 = L1.Cons 1 $ L1.Cons 2 L1.EmptyList
  print $ encode myList1
  let myList1Json = "{\"contents\":[1,{\"contents\":[2,{\"tag\":\"EmptyList\"}],\"tag\":\"Cons\"}],\"tag\":\"Cons\"}"
  let myList1Decoded = eitherDecode myList1Json :: Either String L1.MyList
  print myList1Decoded

  putStrLn ""

  let myList2 = L2.Cons 1 $ L2.Cons 2 $ L2.Cons 3 L2.EmptyList
  print $ encode myList2
  let myList2Json = "[1,2,3]"
  let myList2Decoded = eitherDecode myList2Json :: Either String L2.MyList
  print myList2Decoded
