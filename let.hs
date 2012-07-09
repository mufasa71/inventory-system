add a = do 
          5 + 5
dividedByTen :: (Floating a) => a -> a
dividedByTen = (/10)

multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z
