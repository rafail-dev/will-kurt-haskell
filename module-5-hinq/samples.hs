module Samples where

import Entities
import Main
import Mock

_selectSample1 :: [String]
_selectSample1 = _select (firstName . studentName) students

_selectSample2 :: [GradeLevel]
_selectSample2 = _select gradeLevel students

_select3Sample :: [(Name, Int)]
-- _select3Sample = _select (liftM2 (,) studentName studentId) students
_select3Sample = _select (\v -> (studentName v, studentId v)) students

--

startsWith :: Char -> String -> Bool
startsWith _ [] = False
startsWith char (first : _) = char == first

_whereSample1 :: [Name]
_whereSample1 = _where (startsWith 'J' . firstName) $ _select studentName students

_whereSample2 :: [Student]
_whereSample2 = _where ((Freshman ==) . gradeLevel) $ _select id students

--

_joinSample1 :: [(Teacher, Course)]
_joinSample1 = _join teachers courses teacherId teacher