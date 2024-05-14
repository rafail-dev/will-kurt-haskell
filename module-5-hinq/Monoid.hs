module Monoid where

import Control.Applicative (Alternative)
import Entities
import HINQ
import Main (_join, _select, _where)
import Mock

instance Semigroup (HINQ m a b) where
  (<>) :: HINQ m a b -> HINQ m a b -> HINQ m a b
  (<>) hinq1 HINQ_EMPTY = hinq1
  (<>) HINQ_EMPTY hinq2 = hinq2
  --
  (<>) (HINQ s1 j1 w1) (HINQ _ _ w2) = HINQ (s1) j1 (w1 . w2)
  (<>) hinq1 (HINQ_ _ _) = hinq1
  (<>) (HINQ_ _ _) hinq2 = hinq2

instance Monoid (HINQ m a b) where
  -- mappend = (<>)
  mempty = HINQ_EMPTY

--

query1 :: HINQ [] (Teacher, Course) Name
query1 =
  HINQ
    (_select $ teacherName . fst)
    (_join teachers courses teacherId teacher)
    (_where ((== "English Language") . courseTitle . snd))

query2 :: HINQ [] (Teacher, Course) Name
query2 =
  HINQ
    (_select $ teacherName . fst)
    (_join teachers courses teacherId teacher)
    (_where (\v -> teacherId (fst v) == 200))

combined :: HINQ [] (Teacher, Course) Name
combined = query1 <> query2

folded :: HINQ [] (Teacher, Course) Name
folded = foldr (<>) HINQ_EMPTY [query1, HINQ_EMPTY, query2]
