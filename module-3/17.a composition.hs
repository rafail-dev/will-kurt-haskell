{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore myLast myMax "Avoid reverse" #-}

{-# HLINT ignore myAll myAll' "Use and" #-}
{-# HLINT ignore myAll "Fuse foldr/map" #-}
{-# HLINT ignore myAll'' "Use all" #-}

{-# HLINT ignore myAny "Fuse foldr/map" #-}
{-# HLINT ignore myAny "Use or" #-}
{-# HLINT ignore myAny' "Use any" #-}

import Data.List (sort)

{-# HLINT ignore "Use last" #-}
{-# HLINT ignore "Use minimum" #-}

myLast :: [a] -> a
myLast = head . reverse

myMin :: (Ord a) => [a] -> a
myMin = head . sort

myMax :: (Ord a) => [a] -> a
myMax = head . reverse . sort

-- myAll (< 1000) [1 .. ] works
myAll :: (a -> Bool) -> [a] -> Bool
myAll predicate = foldr (&&) True . map predicate

-- myAll' (< 1000) [1 .. ] works
myAll' :: (a -> Bool) -> [a] -> Bool
myAll' predicate = foldr ((&&) . predicate) True

-- myAll'' (< 1000) [1 .. ] works
myAll'' :: (a -> Bool) -> [a] -> Bool
myAll'' predicate = and . map predicate

-- myAny (>1000) [1..] works
myAny :: (a -> Bool) -> [a] -> Bool
myAny predicate = foldr (||) False . map predicate

-- myAny' (>1000) [1..] works
myAny' :: (a -> Bool) -> [a] -> Bool
myAny' predicate = or . map predicate

myAny'' :: (a -> Bool) -> [a] -> Bool
myAny'' = (or .) . map