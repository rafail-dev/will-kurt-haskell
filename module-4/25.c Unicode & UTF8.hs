{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString.Char8 qualified as BC
import Data.Text qualified as T
import Data.Text.Encoding qualified as E
import Data.Text.IO qualified as TIO

{-
ghci> sampleByteString
"(.8M$G, /9 &G5(>\ETB0@ 2?*? .G\STX 2?\SYN> \ETB/> 9Hd"
-}
sampleByteString :: BC.ByteString
sampleByteString = "नमस्ते, यह देवनागरी लिपि में लिखा गया है।"

sampleText :: T.Text
sampleText = "नमस्ते, यह देवनागरी लिपि में लिखा गया है।"

main :: IO ()
main = do
  TIO.putStrLn sampleText -- नमस्ते, यह देवनागरी लिपि में लिखा गया है।
  BC.putStrLn $ (BC.pack . T.unpack) sampleText -- (.8M$G, /9 &G5(>0@ 2?*? .G 2?> /> 9Hd
  TIO.putStrLn $ (E.decodeUtf8 . E.encodeUtf8) sampleText -- नमस्ते, यह देवनागरी लिपि में लिखा गया है।