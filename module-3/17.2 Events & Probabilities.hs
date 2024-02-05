type Event = String

newtype Events = Events [String]

type Probability = Double

newtype Probabilities = Probabilities [Probability]

cartesianProduct :: (a -> b -> c) -> [a] -> [b] -> [c]
cartesianProduct f l1 l2 = zipWith f l1' (cycle l2)
  where
    l1' = concatMap (replicate $ length l2) l1

combineEvents :: Events -> Events -> Events
combineEvents (Events e1) (Events e2) = Events (cartesianProduct (\x y -> mconcat [x, "-", y]) e1 e2)

combineProbabilities :: Probabilities -> Probabilities -> Probabilities
combineProbabilities (Probabilities p1) (Probabilities p2) = Probabilities (cartesianProduct (*) p1 p2)

instance Semigroup Events where
  (<>) :: Events -> Events -> Events
  (<>) = combineEvents

instance Monoid Events where
  mempty :: Events
  mempty = Events []
  mappend :: Events -> Events -> Events
  mappend = (<>)

instance Semigroup Probabilities where
  (<>) :: Probabilities -> Probabilities -> Probabilities
  (<>) = combineProbabilities

instance Monoid Probabilities where
  mempty :: Probabilities
  mempty = Probabilities []
  mappend :: Probabilities -> Probabilities -> Probabilities
  mappend = (<>)
