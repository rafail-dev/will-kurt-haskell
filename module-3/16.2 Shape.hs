data Shape = CircleShape Circle | SquareShape Square | RecrangleShape Recrangle

type Radius = Double

type Side = Double

newtype Circle = Circle Radius

newtype Square = Square Side

newtype Recrangle = Recrangle (Side, Side)

area :: Shape -> Double
area (CircleShape (Circle radius)) = radius ^ 2 * pi
area (SquareShape (Square side)) = side * 2
area (RecrangleShape (Recrangle (side1, side2))) = side1 * side2

perimeter :: Shape -> Double
perimeter (CircleShape (Circle radius)) = radius * 2 * pi
perimeter (SquareShape (Square side)) = side * 4
perimeter (RecrangleShape (Recrangle (side1, side2))) = side1 * 2 + side2 * 2
