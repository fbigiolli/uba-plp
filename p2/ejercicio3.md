```
v. ∀ xs::[a] . ∀ p::a->Bool . ∀ e::a . ((elem e (filter p xs)) ⇒ (elem e xs)) (asumiendo Eq a)
```

Como asumimos Eq a, entonces tenemos que probar que Eq a ⟹ PredEnunciado, ya que si Eq a es falso la implicacion es trivialmente verdadera.

Definamos las ecuaciones de las funciones: 

```
elem :: Eq a => a -> [a] -> Bool
{E0} elem e [] = False
{E1} elem e (x:xs) = (e == x) || elem e xs

filter :: Eq a => a -> [a] -> Bool
{F0} filter _ [] = []
{F1} filter p (x:xs)
    | p x       = x : filter p xs
    | otherwise = filter p xs
```

### Probemos por induccion sobre listas.

Veamos primero caso base donde `ys = []`
```
p([]) = ((elem e (filter p [])) ⟹ (elem e []))
⟺  elem e [] ⟹ elem e [] {F0}
⟺  False ⟹ False         {E0 x2}.
```
Luego, el caso base vale ya que False ⟹ x evalua True x def de la implicacion.

### Paso inductivo
Sea `ys = x:xs`. Nuestra Hipotesis inductiva sera que vale `p(xs)`.

Queremos ver que
```
∀ e :: a (elem e (filter p (x:xs)) ⟹ (elem e (x:xs)))
⟺ (elem e (if p x then x : filter p xs else filter p xs) ⟹ (elem e (x:xs))) {F1}
```
Por L.G. Bool hay que ver solo dos casos: `p x = True` o `p x = False`.

#### Caso `p x = False`
```
⟺ (elem e (if False then x : filter p xs else filter p xs) ⟹ (elem e (x:xs))) {p x = False}
⟺ (elem e (filter p xs) ⟹ (elem e (x:xs)))                                    {IF}
⟺ (elem e (filter p xs) ⟹ (e == x) || elem e xs)                              {E1}
```
Vemos el caso donde `(e == x)` es Falso
```
⟺ elem e (filter p xs) ⟹ (False || elem e xs) 
⟺ elem e (filter p xs) ⟹ elem e xs {Bool}
```
Verdadero por HI. 

Vemos el caso donde (e == x) es Verdadero
```
⟺ elem e (filter p xs) ⟹ (True || elem e xs) 
⟺ elem e (filter p xs) ⟹ True {Bool}
```
Y esto es verdadero ya que el consecuente es verdadero, luego cualquier combinacion de valuaciones para la implicacion vale ( V ⟹ V ✓, F ⟹ V ✓)


#### Caso `p x = True`
```
⟺ (elem e (x : filter p xs)) 
⟺ (e == x) || elem e xs                       {E1}
```
Nuevamente por L.G. Bool tenemos dos posibilidades: `e == x = True` o `e ==x = False`
#### Caso `e == x = False`
```
⟺ False || elem e xs                    
⟺ elem e xs                                       {Def ||}
⟺ elem e xs ⟹ elem e (x:xs)                      {HI}
```
Que es trivialmente cierto ya que si la premisa es falsa la implicacion vale, o si la premisa es verdadera el consecuente tambien lo sera por ser una lista con un elemento mas.
#### Caso `e == x = True`
```
⟺ True || elem e xs
⟺ True ⟹ elem e (x:xs)                      {Def ||}
```

Que es trivialmente verdadero ya que `e==x`, entonces claramente en la primer iteracion de `elem e (x:xs)` `e==x` valdra (se puede desarrollar la ecuacion de elem e (x:xs) para demostrarlo, queda True ⟹ True.)

Como probamos todos los casos y vemos que valen, podemos concluir por induccion que la propiedad vale. ✓

```
(++) :: [a] -> [a] -> [a]
{++0} [] ++ ys = ys
{++1} (x:xs) ++ ys = x : (xs ++ ys)

reverse :: [a] -> [a]
{R0} reverse = foldl (flip (:)) []

foldr :: (a -> b -> b) -> b -> [a] -> b
{F0} foldr _ z []     = z
{F1} foldr f z (x:xs) = f x (foldr f z xs)

foldl :: (b -> a -> b) -> b -> [a] -> b
{FL0} foldl f z []     = z
{FL1} foldl f z (x : xs) = foldl f (f z x) xs

flip :: (a -> b -> c) -> b -> a -> c
{FLIP} flip f x y = f y x

```


VII. `reverse = foldr (\x rec -> rec ++ (x:[])) []`  
Veamoslo por induccion 

Por extensionalidad, vale que si ∀xs :: [a] reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs entonces la igualdad vale.

`P(xs) = reverse xs = foldr (\x rec -> rec ++ (x:[])) [] xs`

#### Caso base
`p([]) = reverse [] = foldr (\x rec -> rec ++ (x:[])) [] []`

Desarollo el lado izquierdo
```
reverse []
= foldl (flip (:)) [] []         {R0}
= []                             {FL0}               
```

Desarollo el lado derecho
```
foldr (\x rec -> rec ++ (x:[])) [] []
= []                             {F0}
```

Luego, como ambos lados de la igualdad son iguales el caso base vale.

#### Caso inductivo
Sea `xs = (z:zs)`

Asumimos ` ∀zs :: [a] p(zs) = reverse zs = foldr (\x rec -> rec ++ (x:[])) [] zs`
  
QVQ `∀z :: a P(z:zs)`   
`P(z:zs) = reverse (z:zs) = foldr (\x rec -> rec ++ (x:[])) [] (z:zs)`
Veamos primero el lado izquierdo de la ecuacion

```
siendo f = (flip (:))
reverse (z:zs) 
= foldl (flip (:)) [] (z:zs) {R0} 
= foldl (flip (:)) (flip (:) [] z) zs          {FL1}
= foldl (flip (:)) ((:) z []) zs               {FLIP}
= foldl (flip (:)) [z] zs                    {(:)}
= 
```
Veamos ahora el lado derecho de la ecuacion
```
foldr (\x rec -> rec ++ (x:[])) [] (z:zs) 
= (\x rec -> rec ++ (x:[])) z (foldr (\x rec -> rec ++ (x:[])) [] zs)   {F1}
= (foldr (\x rec -> rec ++ (x:[])) [] zs) ++ (z : [])                   2x{b}
= reverse zs ++ (z : [])                                                {HI}
= reverse zs ++ [z]                                                     {x def. cons}
= (foldl (flip (:)) [] zs) ++ [z]

```
Tenemos que probar el lema: `foldl (flip (:)) ws zs = (foldl (flip (:)) [] zs) ++ ws`.
Lo vamos a generalizar mas adelante para toda lista porque si no la demo no sale. 

### Inducción sobre zs 

#### Caso base
Caso `zs = []`

Pruebo lado izquierdo
```
 foldl (flip (:)) ws [] 
 = ws                        {F0}
 
```

Lado derecho

```
(foldl (flip (:)) [] []) ++ ws
[] ++ ws                       {F0}
= ws                          {++0}
```
Entonces vale para `zs = []`


#### Caso inductivo
Sea `zs = (y:ys)`

Asumimos ` ∀ys :: [a] p(ys) = ∀ws :: [a]  foldl (flip (:)) ws ys = (foldl (flip (:)) [] ys) ++ ws`
  
QVQ `∀z :: a P(y:ys)`   
`P(y:ys) = foldl (flip (:)) ws y:ys = (foldl (flip (:)) [] y:ys) ++ ws`
Veamos primero el lado izquierdo de la ecuacion

```
foldl (flip (:)) ws y:ys 
= foldl (flip (:)) ((flip (:)) ws y) ys  {F1}
= foldl (flip (:)) (y:ws) ys             {FLIP}
= foldl (flip (:)) [] ys ++ (y:ws)       {HI vale por forall, aplica a cualquier lista}
```

```
(foldl (flip (:)) [] ys) ++ ws`
= (foldl (flip (:)) ((flip (:)) [] y) ys )++ ws {F1}
= (foldl (flip (:)) ([y]) ys ) ++ ws            {FLIP}
= (foldl (flip (:)) [] ys) ++ [y] ++ ws         {HI}
= (foldl (flip (:)) [] ys) y: [] ++ ws          {++1}
= (foldl (flip (:)) [] ys) y: ws                {++0}
```
Ambos lados de la ecuacion son iguales.
Luego, el caso inductivo vale para toda lista, y en particular para la que nos interesaba
probar en nuestra primera induccion.