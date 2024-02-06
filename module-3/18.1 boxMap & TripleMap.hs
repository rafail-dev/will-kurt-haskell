newtype Box a = Box a deriving (Show)

data Triple a = Triple a a a deriving (Show)

boxMap :: (a -> b) -> Box a -> Box b
boxMap f (Box v) = Box $ f v

tripleMap :: (a -> b) -> Triple a -> Triple b
tripleMap f (Triple a b c) = Triple (f a) (f b) (f c)
