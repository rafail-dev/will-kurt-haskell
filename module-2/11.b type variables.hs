simpleBool :: Bool -> Bool
simpleBool x = x

simpleChar :: Char -> Char
simpleChar x = x

simpleWithTypeViriable :: a -> a
simpleWithTypeViriable x = x

withCharArgument :: Char -> Char
withCharArgument x = x

result1 :: Char
result1 = withCharArgument (simpleChar 'a')

result2 :: Char
result2 = withCharArgument (simpleWithTypeViriable 'a')

-- 

makeTuple :: a -> b -> c -> (a, b, c)
makeTuple a b c = (a, b, c)

{-
f1 :: a -> a 
is a subset of 
f2 :: a -> b 
-}

