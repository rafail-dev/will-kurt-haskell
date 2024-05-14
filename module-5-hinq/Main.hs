module Main where

import Control.Applicative (Alternative)
import Control.Arrow ((***))
import Control.Monad (guard)

import Entities
import HINQ
import Mock

_select :: (Monad m) => (a -> b) -> m a -> m b
_select prop values = values >>= pure . prop

--
_where :: (Monad m, Alternative m) => (a -> Bool) -> m a -> m a
_where predicate values = do
  value <- values
  guard (predicate value)
  pure value

--

_join :: (Monad m, Alternative m, Eq c) => m a -> m b -> (a -> c) -> (b -> c) -> m (a, b)
_join data1 data2 prop1 prop2 = do
  dpairs <- liftA2 (,) data1 data2
  guard (prop1 (fst dpairs) == prop2 (snd dpairs))
  pure dpairs

--

result :: [Name]
result = _select (teacherName . fst) whereResult
  where
    whereResult = _where (((== "English Language")) . courseTitle . snd) joinData
    joinData = _join teachers courses teacherId teacher

--

_hinq :: (t1 -> t2) -> t3 -> (t3 -> t1) -> t2
_hinq selectQuery joinQuery whereQuery =
  (\joinData -> (\whereResult -> selectQuery whereResult) (whereQuery joinData)) joinQuery

_hinq' :: (t1 -> t2) -> t3 -> (t3 -> t1) -> t2
_hinq' selectQuery joinQuery whereQuery =
  selectQuery $ whereQuery joinQuery

_hinq''' :: (t1 -> t2) -> t3 -> (t3 -> t1) -> t2
_hinq''' = flip . (.)

hinqResult :: [Name]
hinqResult =
  _hinq'
    (_select (teacherName . fst))
    (_join teachers courses teacherId teacher)
    (_where ((== "English Language") . courseTitle . snd))

--

runHINQ :: (Monad m, Alternative m) => HINQ m a b -> m b
runHINQ (HINQ selectClause joinClause whereClause) =
  _hinq selectClause joinClause whereClause
runHINQ (HINQ_ selectClause joinClause) =
  _hinq selectClause joinClause (_where $ const True)

--

studentEnrollementsQuery :: HINQ [] (Student, Enrollment) (Name, Int)
studentEnrollementsQuery =
  HINQ_
    (_select $ studentName *** course)
    (_join students enrollments studentId student)

englishStudentQuery :: HINQ [] ((Name, Int), Course) Name
englishStudentQuery =
  HINQ
    (_select (fst . fst))
    (_join (runHINQ studentEnrollementsQuery) courses snd courseId)
    (_where ((== "English Language") . courseTitle . snd))

--

main :: IO ()
main =
  print $ runHINQ englishStudentQuery