import Control.Monad

evensGuard :: Int -> [Int]
evensGuard n = do
  value <- [1 .. n]
  guard (even value)
  pure value
