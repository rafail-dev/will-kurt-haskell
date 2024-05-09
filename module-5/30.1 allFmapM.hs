-- allFmapM1 :: (Monad m) => (a -> b) -> m a -> m b
-- allFmapM1 f a = pure f <*> a

-- allFmapM1' :: (Monad m) => (a -> b) -> m a -> m b
-- allFmapM1' = (<*>) . pure

-- --

-- allFmapM2 :: (Monad m) => (a -> b) -> m a -> m b
-- allFmapM2 f a = f <$> a

-- allFmapM2' :: (Monad m) => (a -> b) -> m a -> m b
-- allFmapM2' = fmap

--

allFmapM :: (Monad m) => (a -> b) -> m a -> m b
allFmapM f a = a >>= (\v -> pure $ f v)

allFmapM' :: (Monad m) => (a -> b) -> m a -> m b
allFmapM' = (=<<) . (pure .)