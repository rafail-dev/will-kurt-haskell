fib 0 = 0
fib 1 = 1
fib n = fib (n - 1) + fib (n - 2)

fastFib = calculate 1 1
  where
    calculate _ _ 0 = 0
    calculate _ _ 1 = 1
    calculate _ _ 2 = 1
    calculate x y 3 = x + y
    calculate x y c = calculate (x + y) x (c - 1)

{-

fastFib 10
calculate 1  1   10
          2  1   9
          3  2   8
          5  3   7
          8  5   6
          13 8   5
          21 13  4
          34 21  3
          55

-}
