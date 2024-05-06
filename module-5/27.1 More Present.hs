data Box a = Box a deriving (Show)

instance Functor Box where
  fmap :: (a -> b) -> Box a -> Box b
  fmap f (Box v) = Box (f v)

morePresent :: Int -> Box a -> Box [a]
-- morePresent n box = replicate n <$> box
-- morePresent n = fmap $ replicate n
morePresent = fmap . replicate

--

result = morePresent 10 $ Box 5