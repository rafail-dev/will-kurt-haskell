{-# LANGUAGE OverloadedStrings #-}

{- cabal install --lib bytestring -}

{- cabal install --lib random -}

import Control.Monad (foldM)
import Data.ByteString.Char8 as BC
import Data.List
import System.Environment
import System.Random (randomRIO)

maybeFilePath :: [String] -> Maybe FilePath
maybeFilePath (path : _) = Just path
maybeFilePath _ = Nothing

interference :: ByteString -> ByteString
interference bytes = BC.concat [part1, part3, part2, part4]
  where
    point = (BC.length bytes) `div` 4
    length = (BC.length bytes) `div` 10
    part1 = BC.take point bytes
    part2 = BC.take length $ BC.drop point bytes
    part3 = BC.take length $ BC.drop (point + length) bytes
    part4 = BC.drop (point + length * 2) bytes

someByte :: ByteString -> ByteString
someByte bytes = mconcat [part1, intToBC 0, BC.drop 100 part2]
  where
    (part1, part2) = BC.splitAt (div (BC.length bytes) 2) bytes

replaceByte :: Int -> Int -> ByteString -> ByteString
replaceByte location chV bytes = mconcat [part1, intToBC chV, BC.drop 1 part2]
  where
    (part1, part2) = BC.splitAt location bytes

randomReplaceByte :: ByteString -> IO ByteString
randomReplaceByte bytes = do
  let length = BC.length bytes
  location <- randomRIO (1, length)
  chV <- randomRIO (0, 255)
  return $ replaceByte location chV bytes

sortSection :: Int -> Int -> ByteString -> ByteString
sortSection start size bytes = mconcat [p1, BC.sort p21, p22]
  where
    (p1, p2) = BC.splitAt start bytes
    (p21, p22) = BC.splitAt size p2

randomSortSection :: ByteString -> IO ByteString
randomSortSection bytes = do
  let length = BC.length bytes
  size <- randomRIO (2, 20)
  start <- randomRIO (0, length - size)
  return $ sortSection start size bytes

intToBC :: Int -> ByteString
intToBC = BC.singleton . toEnum . mod 255

glitch :: ByteString -> IO ByteString
glitch bytes = foldM (\bytes f -> f bytes) bytes [randomReplaceByte, randomSortSection]

addGlitchedToPath :: FilePath -> FilePath
addGlitchedToPath path = case added of
  Just added -> Prelude.reverse added
  Nothing -> mconcat [path, ".glitched"]
  where
    reversed = Prelude.reverse path
    splitted = Data.List.elemIndex '.' reversed >>= Just . (flip Data.List.splitAt reversed)
    added = splitted >>= Just . (\(p1, p2) -> mconcat [p1, Prelude.reverse "glitched.", p2])

main :: IO ()
main = do
  agrs <- getArgs
  case (maybeFilePath agrs) of
    Just path -> BC.readFile path >>= glitch >>= BC.writeFile (addGlitchedToPath path)
    Nothing -> Prelude.putStrLn "Wrong paths"
