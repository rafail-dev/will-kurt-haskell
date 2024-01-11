harmonic = map (1 /) [1 ..]

sumUpToN n = sum (take n harmonic)
