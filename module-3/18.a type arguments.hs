{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore Box "Use newtype instead of data" #-}

data Box a = Box a deriving (Show)

newtype Box2 a = Box2 a deriving (Show)

data Triple a = Triple a a a deriving (Show)

type Point3D = Triple Double

-- Triple 1 1 "str" error
aPoint :: Point3D
aPoint = Triple 1 1 1.5

-- getter
second :: Triple a -> a
second (Triple _ v _) = v

toList :: Triple a -> [a]
toList (Triple a b c) = [a, b, c]

transform :: (a -> a) -> Triple a -> Triple a
transform f (Triple a b c) = Triple (f a) (f b) (f c)

--

data OneOrPair a = One a | Pair a a

oop1 :: OneOrPair Int
oop1 = One 3

oop2 :: OneOrPair Char
oop2 = Pair 'a' 'b'

--

data MyList a = MyEmpty | MyConstructor a (MyList a) deriving (Show)

myMap :: (a -> b) -> MyList a -> MyList b
myMap _ MyEmpty = MyEmpty
myMap f (MyConstructor a rest) = MyConstructor (f a) (myMap f rest)

-- MyConstructor 1 (MyConstructor 2 (MyConstructor 3 MyEmpty))
list1 :: MyList Int
list1 = MyConstructor 1 (MyConstructor 2 (MyConstructor 3 MyEmpty))

-- MyConstructor 0.5 (MyConstructor 1.0 (MyConstructor 1.5 MyEmpty))
list2 :: MyList Double
list2 = myMap ((/ 2) . fromIntegral) list1

--
{-
tuple built-in type constructor

data (,) a b = (,) a b
-}