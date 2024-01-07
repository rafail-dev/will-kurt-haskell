{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore ifEvenX "Redundant lambda" #-}
{-# HLINT ignore ifEvenX "Avoid lambda using `infix`" #-}
ifEven f x = if even x then f x else x

ifEvenX x = \f -> ifEven f x

ifEvenXInflix x f = ifEven f x

result1 = ifEvenX 5 (* 2)

result2 = ifEvenX 4 (* 2)
