data Box a = Box a deriving (Show)

instance Functor Box where
  fmap :: (a -> b) -> Box a -> Box b
  fmap f (Box v) = Box (f v)

myBox :: Box Int
myBox = Box 1

wrapped :: Box (Box Int)
wrapped = fmap Box myBox

unwrap :: Box a -> a
unwrap (Box a) = a

unwrapped :: Box Int
unwrapped = fmap unwrap wrapped