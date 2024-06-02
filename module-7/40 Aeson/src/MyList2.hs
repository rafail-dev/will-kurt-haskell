module MyList2 (MyList (..)) where

import Data.Aeson
  ( FromJSON (parseJSON),
    ToJSON (toJSON),
    Value (Array),
  )
import qualified Data.Vector as V
import GHC.Generics

data MyList = Cons Int MyList | EmptyList deriving (Show, Generic)

instance FromJSON MyList where
  parseJSON (Array v) = do
    ints <- Prelude.mapM parseJSON (V.toList v)
    return $ build ints
    where
      build [] = EmptyList
      build (x : xs) = Cons x (build xs)
  parseJSON _ = fail "Only from massive"

instance ToJSON MyList where
  toJSON = toJSON . toList
    where
      toList (Cons v c) = v : toList c
      toList EmptyList = []
