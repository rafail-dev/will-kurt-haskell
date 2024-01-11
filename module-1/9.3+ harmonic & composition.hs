harmonic = map (1 /) [1 ..]

sumUpToN = sum . (`take` harmonic)
