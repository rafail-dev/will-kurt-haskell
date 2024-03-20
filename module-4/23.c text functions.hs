{-# LANGUAGE OverloadedStrings #-}

{-
cabal install text --lib
-}

import Data.Semigroup ((<>))
import Data.Text qualified as T
import Data.Text.IO qualified as T

combinedTextMonoid :: T.Text
combinedTextMonoid = mconcat ["some", " ", "text"]

combinedTextSemigroup :: T.Text
combinedTextSemigroup = "some" <> " " <> "text"

splitted :: [T.Text]
splitted = T.splitOn "\n" "some\ntext"

aboutHaskell :: T.Text
aboutHaskell = "In the realm of programming, Haskell stands out for its elegance and purity. As a functional language, Haskell promotes a different approach to software design. It's fascinating to observe how Haskell has influenced the development of programming paradigms. This text, crafted by GPT4, aims to highlight Haskell's unique position in the programming community. Interestingly, despite its niche status, Haskell continues to inspire developers around the world."

highlighted :: T.Text -> T.Text -> T.Text
highlighted all forHighlight = T.intercalate ("{{ " <> forHighlight <> " }}") $ T.splitOn forHighlight all

main :: IO ()
main = do
  T.putStrLn $ highlighted aboutHaskell "Haskell"