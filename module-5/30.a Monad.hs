{-
getLine :: IO String
putStrLn :: String -> IO ()

IO String -> (String -> IO ()) -> IO ()

Applicative f => f a -> (a -> f b) -> f b

trouble ...

but monad!

(>>=) :: Monad m => m a -> (a -> m b) -> m b
-}

{-
class Applicative m => Monad (m :: * -> *) where
    (>>=) :: m a -> (a -> m b) -> m b (min required)
    (>>) :: m a -> m b -> m b
    return :: a -> m a
    fail :: String -> m a
-}

echo :: IO ()
echo = getLine >>= putStrLn

echoVerbose :: IO ()
echoVerbose = putStrLn "Echo verbose" 
    >> getLine 
    >>= putStrLn

--

readInt :: IO Int
readInt = read <$> getLine

printDouble :: Int -> IO ()
printDouble n = print (n * 2)

main :: IO ()
main = readInt >>= printDouble