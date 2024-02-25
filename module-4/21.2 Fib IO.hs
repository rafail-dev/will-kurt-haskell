module Homewrok212 where

fib :: [Integer]
fib = 1 : 2 : zipWith (+) fib (tail fib)

main :: IO ()
main = do
  putStrLn "N for Fib"
  n <- getLine
  print $ fib !! read n