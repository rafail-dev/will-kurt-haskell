type Event = String

type Probability = Double

data ProbabilityTable = ProbabilityTable [Event] [Probability]

createProbabilityTable :: [Event] -> [Probability] -> ProbabilityTable
createProbabilityTable events probabilities = ProbabilityTable events normalized
  where
    total = sum probabilities
    normalized = map (/ total) probabilities

showEventProbability :: String -> Double -> String
showEventProbability event propability = mconcat [event, "|", show propability, "\n"]

instance Show ProbabilityTable where
  show :: ProbabilityTable -> String
  show (ProbabilityTable events probabilities) =
    mconcat $
      zipWith showEventProbability events probabilities

cartesianProduct :: (a -> b -> c) -> [a] -> [b] -> [c]
cartesianProduct f l1 l2 = zipWith f l1' (cycle l2)
  where
    l1' = concatMap (replicate $ length l2) l1

combineEvents :: [Event] -> [Event] -> [Event]
combineEvents = cartesianProduct (\x y -> mconcat [x, "-", y])

combineProbabilities :: [Probability] -> [Probability] -> [Probability]
combineProbabilities = cartesianProduct (*)

instance Semigroup ProbabilityTable where
  (<>) table1 (ProbabilityTable [] []) = table1
  (<>) (ProbabilityTable [] []) table2 = table2
  (<>) (ProbabilityTable e1 p1) (ProbabilityTable e2 p2) =
    ProbabilityTable (combineEvents e1 e2) (combineProbabilities p1 p2)

main :: IO ()
main = do
  print $ createProbabilityTable ["a", "b"] [0.2, 0.7]
  print $ cartesianProduct (++) ["a", "b", "c"] ["1", "2", "3"]
  print $
    createProbabilityTable ["a", "b"] [0.25, 0.75]
      <> createProbabilityTable ["x", "y", "z"] [1, 0.5, 0.5]