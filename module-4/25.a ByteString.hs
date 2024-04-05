{-# LANGUAGE OverloadedStrings #-}

{- cabal install --lib bytestring -}
import Data.ByteString qualified as B
import Data.ByteString.Char8 qualified as BC

sample1 :: B.ByteString
sample1 = "Hello!"

sample2 :: BC.ByteString
sample2 = "Hello!"

{-
:t B.unpack
B.unpack :: B.ByteString -> [GHC.Word.Word8]

:t B.unpack
B.unpack :: BC.ByteString -> [GHC.Word.Word8]

:t BC.unpack
BC.unpack :: BC.ByteString -> [Char]
-}

sampleString :: String
sampleString = BC.unpack sample2

byteStringWithInt :: BC.ByteString
byteStringWithInt = "10"

byteStringToInt :: BC.ByteString -> Int
byteStringToInt = read . BC.unpack