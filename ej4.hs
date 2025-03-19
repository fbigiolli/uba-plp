limpiar :: String -> String -> String
limpiar s1 s2 = filter (\x -> not (elem x s1)) s2

promedio :: [Float] -> Float
promedio s1 = (sum s1) /  (fromIntegral (length s1))

difPromedio :: [Float] -> [Float]
difPromedio s1 = map (\x -> x - (promedio s1)) s1

todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales xs = all (\x -> x == head xs) xs