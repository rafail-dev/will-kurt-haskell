quotes :: String -> String
quotes "1" = "Quote A"
quotes "2" = "Quote B"
quotes "3" = "Quote C"
quotes "4" = "Quote D"
quotes _ = "No quote"

ui :: String -> [String] -> [String]
ui "n" _ = []
ui "y" lazy = "Please enter number" : lazy
ui current lazy = (quotes $ current) : "Another quote?" : lazy

main :: IO ()
main = do
  userInput <- getContents
  mapM_ putStrLn . foldr ui [] $ lines userInput

{-
vscode ➜ /workspaces/will-kurt/_sand (main) $ ./main
1
Quote A
Another quote?
2
Quote B
Another quote?
y
Please enter number
3
Quote C
Another quote?
n
-}
