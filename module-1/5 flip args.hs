{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore flipBinaryArgs "Redundant lambda" #-}
{-# HLINT ignore flipBinaryArgs "Avoid lambda" #-}
f a b = a ++ b

fFLipped b a = f a b

flipBinaryArgs f = \x y -> f y x

flipBinaryArgs2 = flip

result1 = flipBinaryArgs f "a" "b"

-- "ba"

result2 = flipBinaryArgs2 f "a" "b"

-- "ba"
