-- allApp' :: (Monad m) => m (a -> b) -> m a -> m b
-- allApp' f v = f >>= (\f -> pure f <*> v)

allApp :: (Monad m) => m (a -> b) -> m a -> m b
allApp f v = f >>= (\f -> v >>= (\v' -> pure $ f v'))