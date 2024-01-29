type FirstName = String

type Surname = String

type MiddleName = String

data Name
  = NameWithoutMiddleName FirstName Surname
  | NameWithMiddleName FirstName MiddleName Surname

showName :: Name -> String
showName (NameWithoutMiddleName firstName surname) = firstName ++ " " ++ surname
showName (NameWithMiddleName firstName middlename surname) = firstName ++ " " ++ middlename ++ " " ++ surname
