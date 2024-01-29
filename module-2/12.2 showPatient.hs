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

showSex :: Sex -> String
showSex Male = "Male"
showSex Female = "Female"

showABOSystem :: ABOSystem -> String
showABOSystem A = "A"
showABOSystem B = "B"
showABOSystem AB = "AB"
showABOSystem O = "O"

showRhesusFactor :: RhesusFactor -> String
showRhesusFactor Positive = "+"
showRhesusFactor Negative = "-"

showBloodType :: BloodType -> String
showBloodType (BloodType aboSystem rhesusFactor) = showABOSystem aboSystem ++ showRhesusFactor rhesusFactor

asterisks :: String
asterisks = replicate 14 '*'

showPatient :: Patient -> String
showPatient patient =
  asterisks
    ++ "\n"
    ++ "Name: "
    ++ showName (name patient)
    ++ "\n"
    ++ "Sex: "
    ++ showSex (sex patient)
    ++ "\n"
    ++ "Age: "
    ++ show (age patient)
    ++ "\n"
    ++ "Height: "
    ++ show (height patient)
    ++ "sm"
    ++ "\n"
    ++ "Weight: "
    ++ show (weight patient)
    ++ "kg"
    ++ "\n"
    ++ "BloodType: "
    ++ showBloodType (bloodType patient)
    ++ "\n"
    ++ asterisks
    ++ "\n"

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

main = do
  putStrLn (showPatient firstPatient)
