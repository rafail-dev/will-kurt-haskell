numberToWord n = case n of
  1 -> "One"
  2 -> "Two"
  3 -> "Three"
  n -> "Another"

myHead (x : xs) = x
myHead [] = error "No head for empty list"
