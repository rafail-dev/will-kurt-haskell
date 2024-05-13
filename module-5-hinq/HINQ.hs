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

-- instance Semigroup (HINQ m a b) where
--   (<>) :: HINQ m a b -> HINQ m a b -> HINQ m a b
--   (<>) (HINQ s1 j1 w1) (HINQ _ _ w2) = HINQ (s1) j1 (w1 . w2)
--   (<>) hinq1 (HINQ_ _ _) = hinq1
--   (<>) (HINQ_ _ _) hinq2 = hinq2

-- instance Monoid (HINQ m a b) where
--   mappend = (<>)
--   mempty = HINQ_EMPTY