{-# LANGUAGE TupleSections #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Main (main) where

import Control.Monad
import Control.Monad.ST
import Data.Array.ST
import Data.Array.Unboxed
import Lib (bubbleSort, cross, replaceZeros)

aLargeList :: [Int]
aLargeList = [1 .. 10000000]

aLargeArray :: UArray Int Int
aLargeArray = array (0, 9999999) []

zeroIndexArray :: UArray Int Bool
zeroIndexArray = array (0, 9) [(3, True)]

oneIndexArray :: UArray Int Bool
oneIndexArray = array (1, 10) $ map (,True) [1 .. 10]

{--
oneIndexArray ! 0
Exception: Ix{Int}.index: Index (0) out of range ((1,10))
-}

--

beansInBuckets :: UArray Int Int
beansInBuckets = array (0, 3) []

updatedBiB :: UArray Int Int
updatedBiB = beansInBuckets // [(1, 5), (3, 6)]

--

-- s - phantom type parameter
listToSTUArray :: [Int] -> ST s (STUArray s Int Int)
listToSTUArray vals = do
  let end = length vals - 1
  stArray <- newArray (0, end) 0
  forM_ [0 .. end] $ \i -> do
    let val = vals !! i
    writeArray stArray i val
  pure stArray

-- runSTUArray :: ST s (STUArray s i e) -> UArray i e

listToUArray :: [Int] -> UArray Int Int
listToUArray vals = runSTUArray $ listToSTUArray vals

--

listToUArray' :: [Int] -> UArray Int Int
listToUArray' vals = runSTUArray $ do
  let end = length vals - 1
  stArray <- newArray (0, end) 0
  forM_ [0 .. end] $ \i -> do
    let val = vals !! i
    writeArray stArray i val
  pure stArray

--
main :: IO ()
main = do
  putStrLn "Bubble Sort"
  print $
    elems . bubbleSort $
      listArray (0, 5) [7, 6, 4, 8, 10, 2]
  --
  putStrLn ""
  --
  putStrLn "Cross"
  let size = 4
  let allTrue = array (0, size) $ map (,True) [0 .. size]
  let allFalse = array (0, size) []
  let (r1, r2) = cross allTrue allFalse 3
  print $ elems r1
  print $ elems r2
  --
  putStrLn ""
  --
  putStrLn "Replace Zeros"
  print $
    elems . replaceZeros $
      listArray (0, 5) [1, 0, 2, 3, -5, 0]
