robotConstructor (name, attack, hp) message = message (name, attack, hp)

getHP robot = robot (\(_, _, hp) -> hp)

firstRobot = robotConstructor ("First", 10, 300)

secondRobot = robotConstructor ("Second", 20, 200)

thirdRobot = robotConstructor ("Third", 30, 100)

allRobotsHP = map getHP [firstRobot, secondRobot, thirdRobot]