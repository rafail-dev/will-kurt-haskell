myReplicateM :: (Monad m) => Word -> m a -> m [a]
myReplicateM n f = mapM (const f) [1 .. n]