import Control.Arrow ((&&&))
import Data.Map qualified as Map
import Modules31.Candidate
import Modules31.ReadCandidate (readCandidate)

candidates :: [Candidate]
candidates = [Candidate 1 A A BA, Candidate 2 C A PhD, Candidate 3 A B MS]

db :: Map.Map Int Candidate
db =
  Map.fromList $ map format candidates
  where
    -- format = (\v -> (candidateId v, v))
    format = candidateId &&& id

--

-- assessCandidateIO
assessCandidateIO :: IO String
assessCandidateIO = do
  candidate <- readCandidate
  case (viable candidate) of
    True -> pure "Passed"
    _ -> pure "Failed"

-- assessCandidateMaybe 1
assessCandidateMaybe :: Int -> Maybe String
assessCandidateMaybe id = do
  candidate <- Map.lookup id db
  case (viable candidate) of
    True -> pure "Passed"
    _ -> pure "Failed"

-- assessCandidateMaybe candidates
assessCandidateList :: [Candidate] -> [String]
assessCandidateList candidates = do
  candidate <- candidates
  case (viable candidate) of
    True -> pure "Passed"
    _ -> pure "Failed"

--

-- assessCandidateIO readCandidate
-- assessCandidateMaybe $ Map.lookup 1 db
-- assessCandidateMaybe candidates
assessCandidate :: (Monad m) => m Candidate -> m String
assessCandidate candidateInContext = do
  candidate <- candidateInContext
  case (viable candidate) of
    True -> pure "Passed"
    _ -> pure "Failed"