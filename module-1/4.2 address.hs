sfOffice name =
  if surname < "L"
    then nameText ++ ": SF Address for < L abonents"
    else nameText ++ ": SF Address for > L abonents"
  where
    surname = snd name
    nameText = fst name ++ " " ++ snd name

nyOffice name = nameText ++ ": NY Address"
  where
    nameText = fst name ++ " " ++ snd name

renoOffice name = nameText ++ ": RN Address"
  where
    nameText = snd name

dcOffice name = nameText ++ ": DC Address"
  where
    nameText = "Dear" ++ fst name ++ " " ++ snd name

getLocationFunction location =
  case location of
    "ny" -> nyOffice
    "sf" -> sfOffice
    "reno" -> renoOffice
    "dc" -> dcOffice
    _ -> (\name -> fst name ++ " " ++ snd name)

addressLetter name location = f name
  where
    f = getLocationFunction location