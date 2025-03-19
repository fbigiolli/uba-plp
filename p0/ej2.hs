valorAbsoluto :: Float -> Float
valorAbsoluto n = if n > 0 then n else -n

bisiesto :: Int -> Bool 
bisiesto n = mod n 4 == 0

factorial :: Int -> Int
factorial 1 = 1
factorial n = n * factorial (n-1)

esPrimo :: Int -> Bool
esPrimo n = all (\x -> (mod n x) /= 0)[2..n-1]

cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos n = length (filter (\x -> (mod n x) == 0 && (esPrimo x)) [1..n])