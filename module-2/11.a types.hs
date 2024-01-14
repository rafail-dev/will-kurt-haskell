{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore makeAddressLambda "Redundant lambda" #-}
{-# HLINT ignore makeAddressLambda "Collapse lambdas" #-}
{-# HLINT ignore makeAddressLambda "Use tuple-section" #-}

-- unary functions
double :: Int -> Int
double = (2 *)

half :: Int -> Double
half = (/ 2) . fromIntegral

halve :: Integer -> Integer
halve = (`div` 2)

printMultipliedBy2 :: Int -> [Char]
printMultipliedBy2 = show . (* 2)

toInt :: [Char] -> Int
toInt = read

toDouble :: [Char] -> Double
toDouble = read

-- function with multiple arguments

makeAddress :: Int -> [Char] -> [Char] -> (Int, [Char], [Char])
makeAddress number street town = (number, street, town)

makeAddressLambda = \number -> \street -> \town -> (number, street, town)

