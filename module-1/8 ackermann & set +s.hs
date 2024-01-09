ackermann 0 n = n + 1
ackermann m 0 = ackermann (m - 1) 1
ackermann m n = ackermann (m - 1) (ackermann m (n - 1))

-- ghci :set +s ghci> :set +s

-- ghci> ackermann 3 3
-- 61
-- (0.03 secs, 884,856 bytes)

-- ghci> ackermann 3 9
-- 4093
-- (8.77 secs, 3,905,894,200 bytes)