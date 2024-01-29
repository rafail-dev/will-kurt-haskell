{-# OPTIONS_GHC -Wall #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

data Sex = Male | Female

data RhesusFactor = Positive | Negative

data ABOSystem = A | B | AB | O

data BloodType = BloodType ABOSystem RhesusFactor

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

canDonateTo :: BloodType -> BloodType -> Bool
canDonateTo (BloodType O _) _ = True
canDonateTo _ (BloodType AB _) = True
canDonateTo (BloodType A _) (BloodType A _) = True
canDonateTo (BloodType B _) (BloodType B _) = True
canDonateTo _ _ = False

--
firstPatientBloodType :: BloodType
firstPatientBloodType = BloodType A Negative

secondPatientBloodType :: BloodType
secondPatientBloodType = BloodType O Positive

main :: IO ()
main = do
  print (showBloodType firstPatientBloodType)
  print (showBloodType secondPatientBloodType)
  print (show (canDonateTo firstPatientBloodType secondPatientBloodType))