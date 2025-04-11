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

Entonces, veamos por induccion en xs que la propiedad vale.

#### Caso base
Veamos primero el caso base donde xs = []

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
= foldr (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) (const []) [] ys    {Z0}
= const [] ys       {F0}
= []                {x def Const}
```

#### Caso inductivo
Veamos ahora el caso inductivo  
Tenemos como HI:
```
sea xs = (z:zs)
P(zs) = ∀ys :: [a] zip zs ys = zip' zs ys
```
QVQ vale P(xs)
```
P(xs) = ∀ys :: [a] zip z:zs ys = zip' z:zs ys
```
Desarrollemos primero el lado derecho:
```
zip' z:zs ys 
= if null ys then [] else (z, head ys):zip’ zs (tail ys) {Z’1}
```
Desarollamos el lado izquierdo
```
zip z:zs ys
Siendo f = (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys))
= foldr f (const []) z:zs ys      {Z0}
= (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) z (foldr f (const []) zs) ys {F1}
= if null ys then [] else (z, head ys) : (foldr f (const []) zs) (tail ys)                         3x{b}
```

Por extensionalidad `ys = []` o `w:ws`
Vemos ambos casos
Caso ys = []  
 
Vemos el lado derecho
```
if null [] then [] else (z, head []):zip’ zs (tail [])
if True then [] else (z, head []):zip’ zs (tail [])     {x def. null}
[]                                                      {x def. if}
```
Vemos el lado izquierdo
```
if null [] then [] else (z, head []) : (foldr f (const []) zs) (tail [])
if True then [] else (z, head []) : (foldr f (const []) zs) (tail [])       {x def. null}
[]                                                                          {x def. if}
```
Entonces vale para `ys = []`

Caso ys = w:ws

Vemos el lado derecho

```
if null (w:ws) then [] else (z, head (w:ws)):zip’ zs (tail (w:ws)) 
if False then [] else (z, head (w:ws)):zip’ zs (tail (w:ws))            {x def. null}
(z, head (w:ws)):zip’ zs (tail (w:ws))                                  {x def. if}
(z, w):zip’ zs (tail (w:ws))                                            {x def. head}
(z, w):zip’ zs ws                                                       {x def. tail}
```
Vemos el lado izquierdo
```
if null (w:ws) then [] else (z, head w:ws) : (foldr f (const []) zs) (tail w:ws)
if False then [] else (z, head w:ws) : (foldr f (const []) zs) (tail w:ws)        {x def. null}
(z, head w:ws) : (foldr f (const []) zs) (tail w:ws)                              {x def. if}
(z, w) : (foldr f (const []) zs) (tail w:ws)                                      {x def. head}
(z, w) : (foldr f (const []) zs) (ws)                                             {x def. tail}
(z, w) : zip zs ws                                                                {Z0}
```
Notemos ahora que por HI zip' zs ws = zip zs ws, por ende ambos lados son iguales y vale el caso inductivo. 
Luego, la igualdad vale ∀xs :: [a].


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


#### Caso inductivo
Veamos ahora el caso inductivo  
Tenemos como HI:
```
sea xs = (z:zs)
P(zs) = ∀ys :: [a] zip zs ys = zip' zs ys
```
QVQ vale P(xs)
```
P(xs) = ∀ys :: [a] zip z:zs ys = zip' z:zs ys
```
Desarrollemos primero el lado derecho:
```
zip' z:zs ys 
= if null ys then [] else (z, head ys):zip’ zs (tail ys) {Z’1}
```
Desarollamos el lad
```
zip z:zs ys
Siendo f = (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys))
= foldr f (const []) z:zs ys      {Z0}
= (\x rec ys -> if null ys then [] else (x, head ys) : rec (tail ys)) z (foldr f (const []) zs) ys {F1}
= if null ys then [] else (z, head ys) : (foldr f (const []) zs) (tail ys)                         3x{b}

(foldr f (const []) zs) (tail ys) = zip zs (tail ys) {z0}

= if null ys then [] else (z, head ys) : zip zs (tail ys) {extensionalidad}
= if null ys then [] else (z, head ys) : zip' zs (tail ys) {HI}
= zip' (x:xs) ys


zip zs ys = (foldr f (const []) zs) ys entonces  zip zs (tail ys) = (foldr f (const []) zs) (tail ys)


```