type FirstName = String

type Surname = String

type Name = (FirstName, Surname)

type Age = Int

type Height = Int

patientInfo :: Name -> Age -> Height -> String
patientInfo (firstName, surname) age height =
  firstName
    ++ " "
    ++ surname
    ++ "; Age - "
    ++ show age
    ++ "; Height - "
    ++ show height
