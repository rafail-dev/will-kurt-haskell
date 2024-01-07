{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore doubleDoubleLamda "Avoid lambda using `infix`" #-}

doubleDouble x = dubs * 2
  where
    dubs = x * 2

doubleDoubleLamda x = (\dubs -> dubs * 2) (x * 2)

doubleDoubleLet x =
  let dubs = x * 2
   in dubs * 2

doubleDoubleLamdaInfix x = (* 2) (x * 2)
