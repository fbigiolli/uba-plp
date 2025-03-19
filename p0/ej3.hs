inverso :: Float -> Maybe Float
inverso n = if n == 0 then Nothing else Just (1 / n)

aEntero :: Either Int Bool -> Int
aEntero (Left n) = n
aEntero (Right True) = 1
aEntero (Right False) = 0