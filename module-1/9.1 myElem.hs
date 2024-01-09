{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore myElem1 "Use null" #-}
{-# HLINT ignore myElem2 "Use any" #-}
{-# HLINT ignore myElem3 "Use elem" #-}

myElem1 elem list = length (filter (== elem) list) > 0

myElem2 elem list = not (null (filter (== elem) list))

myElem3 elem = any (== elem)
