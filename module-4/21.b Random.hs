{-
    cabal install random
    cabal install --lib random
    https://github.com/haskell/cabal/issues/6481
-}
import System.Random (randomRIO)

main :: IO ()
main = do
  dieRoll <- randomRIO (1 :: Int, 6 :: Int)
  print dieRoll
  -- or
  -- >>= monadic bind
  randomRIO (1 :: Int, 6 :: Int) >>= print