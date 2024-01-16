-- robotConstructor (name, attack, hp) = \message -> message (name, attack, hp)
robotConstructor (name, attack, hp) message = message (name, attack, hp)

--

-- name (name, _, _) = name
-- attack (_, attack, _) = attack
-- hp (_, _, hp) = hp

getName robot = robot (\(name, _, _) -> name)

getAttack robot = robot (\(_, attack, _) -> attack)

getHP robot = robot (\(_, _, hp) -> hp)

setName robot newName = robot (\(_, attack, hp) -> robotConstructor (newName, attack, hp))

setAttack robot newAttack = robot (\(name, _, hp) -> robotConstructor (name, newAttack, hp))

setHP robot newHP = robot (\(name, attack, _) -> robotConstructor (name, attack, newHP))

damage robot givenDamage = robot (\(name, attack, hp) -> robotConstructor (name, attack, hp - givenDamage))

fight attacker defender = damage defender attack
  where
    attack = if getHP attacker > 0 then getAttack attacker else 0

printRobot robot = robot (\(name, attack, hp) -> name ++ ", attack: " ++ show attack ++ ", HP: " ++ show hp)

--

firstRobot = robotConstructor ("First", 25, 200)

secondRobot = setName firstRobot "SecondRobot"


result = printRobot (fight firstRobot secondRobot)