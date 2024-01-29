type FirstName = String

type Surname = String

type MiddleName = String

data Name
  = NameWithoutMiddleName FirstName Surname
  | NameWithMiddleName FirstName MiddleName Surname

type Age = Int

type Height = Int

type Weight = Int

data Sex = Male | Female

data RhesusFactor = Positive | Negative

data ABOSystem = A | B | AB | O

data BloodType = BloodType ABOSystem RhesusFactor

data Patient = Patient
  { name :: Name,
    sex :: Sex,
    age :: Age,
    height :: Height,
    weight :: Weight,
    bloodType :: BloodType
  }

showName :: Name -> String
showName (NameWithoutMiddleName firstName surname) = firstName ++ " " ++ surname
showName (NameWithMiddleName firstName middlename surname) = firstName ++ " " ++ middlename ++ " " ++ surname

firstPatient :: Patient
firstPatient =
  Patient
    { name = NameWithoutMiddleName "First" "Patient",
      sex = Male,
      age = 30,
      height = 178,
      weight = 98,
      bloodType = BloodType A Negative
    }

firstPatientWithUpdatedName :: Patient
firstPatientWithUpdatedName = firstPatient {name = NameWithMiddleName "First" "Middle" "Patient"}

main = do
  print (showName (name firstPatient))
  print (showName (name firstPatientWithUpdatedName))
