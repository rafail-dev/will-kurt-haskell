type Name = String

data RhesusFactor = Positive | Negative

data ABOSystem = A | B | AB | O

data BloodType = BloodType ABOSystem RhesusFactor

data Patient = Patient
  { name :: Name,
    bloodType :: BloodType
  }

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

--

canDonateTo :: BloodType -> BloodType -> Bool
canDonateTo (BloodType O _) _ = True
canDonateTo _ (BloodType AB _) = True
canDonateTo (BloodType A _) (BloodType A _) = True
canDonateTo (BloodType B _) (BloodType B _) = True
canDonateTo _ _ = False

canDonateTo2 :: Patient -> Patient -> Bool
canDonateTo2 Patient {bloodType = (BloodType O _)} _ = True
canDonateTo2 _ Patient {bloodType = (BloodType AB _)} = True
canDonateTo2 Patient {bloodType = (BloodType A _)} Patient {bloodType = (BloodType A _)} = True
canDonateTo2 Patient {bloodType = (BloodType B _)} Patient {bloodType = (BloodType B _)} = True
canDonateTo2 _ _ = False

canDonateTo3 :: Patient -> Patient -> Bool
canDonateTo3 patientA patientB = canDonateTo (bloodType patientA) (bloodType patientB)

--

firstPatient :: Patient
firstPatient =
  Patient
    { name = "First Patient",
      bloodType = BloodType O Negative
    }

secondPatient :: Patient
secondPatient =
  Patient
    { name = "Second Patient",
      bloodType = BloodType A Positive
    }

main :: IO ()
main = do
  print (showBloodType (bloodType firstPatient))
  print (showBloodType (bloodType secondPatient))
  print (show (canDonateTo (bloodType firstPatient) (bloodType secondPatient)))
  print (show (canDonateTo2 firstPatient secondPatient))
  print (show (canDonateTo3 firstPatient secondPatient))