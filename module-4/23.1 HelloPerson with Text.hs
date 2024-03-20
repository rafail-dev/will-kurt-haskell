{-# LANGUAGE OverloadedStrings #-}

{--
cabal install text --lib
--}
import Data.Semigroup ((<>))
import Data.Text qualified as T
import Data.Text.IO qualified as TIO

helloPerson :: T.Text -> T.Text
helloPerson name = "Hello" <> " " <> name <> "!"

main :: IO ()
main = do
  putStrLn "Hello! What's your name?"
  name <- TIO.getLine
  let statement = helloPerson name
  TIO.putStrLn $ statement