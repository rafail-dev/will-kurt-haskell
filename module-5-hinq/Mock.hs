module Mock where

import Entities

students :: [Student]
students =
  zipWith
    (\id (grade, name) -> Student id grade name)
    [1 ..]
    [ (Senior, Name "Audrey" "Lorde"),
      (Junior, Name "Leslie" "Silko"),
      (Freshman, Name "Judith" "Butler"),
      (Senior, Name "Guy" "Debord"),
      (Sophomore, Name "Jean" "Baudrillard"),
      (Junior, Name "Julia" "Kristeva")
    ]

teachers :: [Teacher]
teachers =
  [ Teacher 100 (Name "Simone" "de Beauvoir"),
    Teacher 200 (Name "Susan" "Sontag")
  ]

courses :: [Course]
courses =
  [ Course 101 "French Language" 100,
    Course 201 "English Language" 200
  ]

enrollments :: [Enrollment]
enrollments =
  [ (Enrollment 1 101),
    (Enrollment 2 101),
    (Enrollment 2 201),
    (Enrollment 3 101),
    (Enrollment 4 201),
    (Enrollment 4 101),
    (Enrollment 5 101),
    (Enrollment 6 201)
  ]