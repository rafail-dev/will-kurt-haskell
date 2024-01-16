takeWhileInclusive prdicate [] = []
takeWhileInclusive predicate xs = case span predicate xs of
  (xs, i : _) -> xs ++ [i]
  (xs, []) -> xs

-- ===

attackA = 100

attackB = 50

nextHP 0 _ _ = 0
nextHP hpA hpB attack = if hpB > 0 then max 0 (hpA - attack) else hpA

fightRound (hpA, hpB) = (nextHP hpA hpB attackB, nextHP hpB hpA attackA)

-- series hp1 hp2 xs = (hp1, hp2) : xs
fight (hp1, hp2) = (hp1, hp2) : fight (fightRound (hp1, hp2))

tenRounds = take 10 (fight (200, 500))

whileAliveInclusive = takeWhileInclusive (\(hp1, hp2) -> hp1 > 0 && hp2 > 0) (fight (200, 500))