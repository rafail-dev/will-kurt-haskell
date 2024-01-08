{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore l1 l2 "Use list literal" #-}
{-# HLINT ignore l7 "Evaluate" #-}

l1 = 1 : []

-- same [1]

l2 = 1 : 2 : 3 : []

-- same [1, 2, 3]

l3 = 'h' : ['e', 'l', 'l', 'o']

-- but error 'h' : ["ello"]
-- 'h' - char, "h" - string

l4 = [1, 2, 3] ++ [4, 5, 6]

l5 = head [1, 2]

l6 = tail [1, 2]

l7 = tail [1] -- []
-- errors
-- head []
-- tail []

l8 = [1 .. 100]

l9 = [1, 3 .. 10] -- [1, 3, 5, 7, 9]

l10 = [1, 1.5 .. 3] -- [1.0, 1.5, 2.0, 2.5, 3.0]

l11 = [10, 5 .. -10] -- [10,5,0,-5,-10]
