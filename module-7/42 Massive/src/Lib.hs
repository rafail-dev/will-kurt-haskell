module Lib
  ( bubbleSort,
    cross,
    replaceZeros,
  )
where

import Control.Monad
import Control.Monad.ST (runST)
import Data.Array.ST
import Data.Array.Unboxed
import qualified GHC.ST

bubbleSort :: UArray Int Int -> UArray Int Int
bubbleSort uArray = runSTUArray $ do
  stArray <- thaw uArray
  let end = (snd . bounds) uArray

  forM_ [1 .. end] $ \i -> do
    forM_ [0 .. (end - i)] $ \j -> do
      value <- readArray stArray j
      nextValue <- readArray stArray (j + 1)

      when (value > nextValue) $ do
        writeArray stArray j nextValue
        writeArray stArray (j + 1) value

  pure stArray

cross :: UArray Int Bool -> UArray Int Bool -> Int -> (UArray Int Bool, UArray Int Bool)
cross a b cuttingPoint = runST $ do
  a' <- thaw a :: GHC.ST.ST s (STUArray s Int Bool)
  b' <- thaw b :: GHC.ST.ST s (STUArray s Int Bool)

  let end = (snd . bounds) a
  forM_ [cuttingPoint .. end] $ \i -> do
    bufferA <- readArray a' i
    readArray b' i >>= writeArray a' i
    writeArray b' i bufferA

  liftM2 (,) (freeze a') (freeze b')

replaceZeros :: UArray Int Int -> UArray Int Int
replaceZeros a = runSTUArray $ do
  a' <- thaw a

  let end = (snd . bounds) a
  forM_ [0 .. end] $ \i -> do
    element <- readArray a' i
    when (element == 0) $ do
      writeArray a' i (-1)

  pure a'
