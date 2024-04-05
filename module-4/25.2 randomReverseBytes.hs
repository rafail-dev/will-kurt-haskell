import Data.ByteString.Char8 as BC
import Data.List
import System.Random (randomRIO)

reverseSection :: Int -> Int -> ByteString -> ByteString
reverseSection start size bytes = mconcat [p1, BC.reverse p21, p22]
  where
    (p1, p2) = BC.splitAt start bytes
    (p21, p22) = BC.splitAt size bytes

randomSortSection :: ByteString -> IO ByteString
randomSortSection bytes = do
  let length = BC.length bytes
  size <- randomRIO (0, 20)
  start <- randomRIO (0, length - size)
  return $ reverseSection start size bytes