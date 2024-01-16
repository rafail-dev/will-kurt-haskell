-- make :: (Int, Int) -> ((Int, Int) -> a) -> a
robotConstructor (name, attack, hp) message = message (name, attack, hp)

getName (name, _, _) = name

getAttack (_, attack, _) = attack

getHP (_, _, hp) = hp

threeRounds closureA closureB = winner
  where
    atkA = getAttack (closureA id)
    atkB = getAttack (closureB id)

    winner
      | (snd result <= 0) && (fst result <= 0) = "Dead heat"
      | (snd result > 0) && (fst result > 0) = "Dead heat"
      | snd result < 0 = getName (closureA id) ++ " - winner"
      | otherwise = getName (closureB id) ++ " - winner"

    nextHP hpA hpB atk = if hpB > 0 then hpA - atk else hpA
    nextRound (hpA, hpB) = (nextHP hpA hpB atkB, nextHP hpB hpA atkA)

    result =
      nextRound
        ( nextRound
            ( nextRound
                (getHP (closureA id), getHP (closureB id))
            )
        )

result = threeRounds (robotConstructor ("A", 1000, 200)) (robotConstructor ("B", 1000, 200))