### Enunciado
Dadas las siguientes funciones:  

```
zip :: [a] -> [b] -> [(a,b)]
{Z0} zip = foldr (\x rec ys ->
                    if null ys
                        then []
                        else (x, head ys) : rec (tail ys))
                    (const [])

zip’ :: [a] -> [b] -> [(a,b)]
{Z’0} zip’ [] ys = []
{Z’1} zip’ (x:xs) ys = if null ys then [] else (x, head ys):zip’ xs (tail ys)

foldr :: (a -> b -> b) -> b -> [a] -> b
{F0} foldr _ z []     = z
{F1} foldr f z (x:xs) = f x (foldr f z xs)
```

Demostrar que zip = zip’ utilizando inducción estructural y el principio de extensionalidad.

### Demostracion

Por *extensionalidad*, para ver que `zip = zip'` basta con probar que:
`∀xs,ys :: [a] zip xs ys = zip' xs ys`

Entonces, veamos por induccion en ys que la propiedad vale.

#### Caso base
Veamos primero el caso base donde ys = []

```
QVQ
zip [] ys = zip' [] ys
```
Desarrollemos primero el lado derecho:
```
zip' [] ys
= []              {Z'0}
```
Veamos ahora el lado izquierdo
```
zip [] ys
= foldr (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) (const []) xs [] {Z0}
= 
```