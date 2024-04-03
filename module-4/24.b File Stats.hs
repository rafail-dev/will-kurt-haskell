import System.IO

type SymbolCount = Int

type WordCount = Int

type LineCount = Int

stats :: String -> (SymbolCount, WordCount, LineCount)
stats input = (length input, (length . words) input, (length . lines) input)

format :: (SymbolCount, WordCount, LineCount) -> String
format (sc, wc, lc) =
  unwords
    [ "SymbolCount\t",
      show sc,
      "\nWordCount\t",
      show wc,
      "\nLineCount\t",
      show lc
    ]

main :: IO ()
main = do
  source <- readFile "24.b source.txt"
  let results = format $ stats source
  putStrLn results
  appendFile "24.b results.txt" $ unwords [results, "\n\n"]