module HINQ where

import Control.Applicative (Alternative)

-- {-
-- (m a -> m b) - select
-- (m a) - join
-- (m a -> m a) - where
-- -}
data HINQ m a b
  = HINQ (m a -> m b) (m a) (m a -> m a)
  | HINQ_ (m a -> m b) (m a)
  | HINQ_EMPTY