{-# LANGUAGE OverloadedStrings #-}

module Consts where

import Data.Text qualified as T

leaderLength :: Int
leaderLength = 24

lengthLength :: Int
lengthLength = 5

directoryEntryLength :: Int
directoryEntryLength = 12

fieldDelimiter :: Char
fieldDelimiter = toEnum 31

titleTag :: T.Text
titleTag = "245"

titleSubfield :: Char
titleSubfield = 'a'

additionalTitleSubfield :: Char
additionalTitleSubfield = 'b'

authorTag :: T.Text
authorTag = "100"

authorSubfield :: Char
authorSubfield = 'a'