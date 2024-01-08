{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore x2 "Use last" #-}
l1 = [1 ..]

x1 = head l1 -- 1

x2 = head (reverse l1) -- trouble
-- or x2 = last l1, same trouble
