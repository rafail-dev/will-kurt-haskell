myInc :: Int -> Int
myInc = (+ 1)

sampleWithMyInc :: Int
sampleWithMyInc = myInc maxBound :: Int

-- sampleWithMyInc == -9223372036854775808

sampleWithSucc :: Int
sampleWithSucc = succ maxBound :: Int

-- *** Exception: Prelude.Enum.succ{Int}: tried to take `succ' of maxBound