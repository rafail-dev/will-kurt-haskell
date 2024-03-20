{-# LANGUAGE OverloadedStrings #-}

{-
cabal install text --lib
-}

{-
{-# LANGUAGE OverloadedStrings #-}
or
ghc "23.b OverloadedStrings.hs" -XOverloadedStrings
-}
import Data.Text qualified as T

myText :: T.Text
myText = "World"

main = do
  print $ T.unpack "Hello"
  print $ T.unpack myText
  print "!"
 