{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore sumSquareOrSquareSum "Avoid lambda" #-}

sumSquareOrSquareSum x y =
  ( \sumSquare squareSum ->
      max sumSquare squareSum
  )
    (x ^ 2 + y ^ 2)
    ((x + y) ^ 2)

sumSquareOrSquareSum2 x y =
  max
    (x ^ 2 + y ^ 2)
    ((x + y) ^ 2)