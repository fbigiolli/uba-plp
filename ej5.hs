data AB a = Nil | Bin (AB a) a (AB a)

-- aux method for AB datatype printing
instance Show a => Show (AB a) where
    show Nil = "Nil"
    show (Bin left val right) =
        "Bin (" ++ show left ++ ") " ++ show val ++ " (" ++ show right ++ ")"


vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB _ = False

negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin i r d) = Bin (negacionAB i) (not r) (negacionAB d)

productoAB :: AB Int -> Int
productoAB Nil = 1
productoAB (Bin i r d) = (productoAB i) * (r) * (productoAB d)