### Enunciado
Dados el tipo Polinomio definido en la práctica 1 y las siguientes funciones:
```hs
derivado :: Num a => Polinomio a -> Polinomio a
derivado poli = case poli of
    X -> Cte 1
    Cte _ -> Cte 0
    Suma p q -> Suma (derivado p) (derivado q)
    Prod p q -> Suma (Prod (derivado p) q) (Prod (derivado q) p)

sinConstantesNegativas :: Num a => Polinomio a -> Polinomio a
sinConstantesNegativas = foldPoli True (>=0) (&&) (&&)

esRaiz :: Num a => a -> Polinomio a -> Bool
{R0} esRaiz n p = evaluar n p == 0
```

Demostrar las siguientes propiedades:
```
i. Num a => ∀ p::Polinomio a . ∀ q::Polinomio a . ∀ r::a . (esRaiz r p ⇒ esRaiz r (Prod p q))

ii. Num a => ∀ p::Polinomio a . ∀ k::a . ∀ e::a .
evaluar e (derivado (Prod (Cte k) p)) = evaluar e (Prod (Cte k) (derivado p))

iii. Num a => ∀ p::Polinomio a. (sinConstantesNegativas p⇒sinConstantesNegativas (derivado p))
```

### Definiciones utiles
```hs
data Polinomio a = X
| Cte a
| Suma (Polinomio a) (Polinomio a)
| Prod (Polinomio a) (Polinomio a)


evaluar :: Num a => a -> Polinomio a -> Polinomio a
evaluar x poli = case poli of
    X        -> x                           {E0}
    Cte c    -> c                           {E1}
    Suma p q -> evaluar x p + evaluar x q   {E2}
    Prod p q -> evaluar x p * evaluar x q   {E3}
```

### Resolucion

### Ejercicio 1
```
i. Num a => ∀ p::Polinomio a . ∀ q::Polinomio a . ∀ r::a . (esRaiz r p ⇒ esRaiz r (Prod p q))
```

```
esRaiz r p ⟹ esRaiz r (Prod p q)
⟺ evaluar r p == 0 ⟹ evaluar r (Prod p q) == 0 {R0}
⟺ evaluar r p == 0 ⟹ (evaluar r p * evaluar r q) == 0 {E3}
```

Por L.G. de Bool, sabemos que `evaluar r p == 0` puede ser True o False y nos basta con evaluar ambos casos: 

### Caso `evaluar r p == 0 = False`
Es trivialmente verdadera la implicacion ya que falso implica cualquier cosa

### Caso `evaluar r p == 0 = True`
Observemos la ultima linea de nuestra demo:
```
⟺ evaluar r p == 0 ⟹ (evaluar r p * evaluar r q) == 0 {E3}
⟺ True ⟹ True               {∀x :: INT. 0 * x = 0 }
```
Ya que por hipotesis sabemos que `evaluar r p == 0 = True`. Luego, como `evaluar r p == 0`, sabemos que por propiedad de INT cualquier numero multiplicado por 0 da 0. Luego, la implicacion es verdadera.

∴ Finalmente, como ambos casos valen por L.G. de Bool podemos concluir que la implicacion es verdadera.

### Ejercicio 2

```
ii. Num a => ∀ p::Polinomio a . ∀ k::a . ∀ e::a .
evaluar e (derivado (Prod (Cte k) p)) = evaluar e (Prod (Cte k) (derivado p))
```
En criollo, hacer el producto de una constante por un polinomio y evaluar su derivada es equivalente a evaluar el producto de la constante y la derivada del polinomio.

### Definiciones utiles para la demo
```hs
derivado :: Num a => Polinomio a -> Polinomio a
derivado poli = case poli of
    {D0} X -> Cte 1                                      
    {D1} Cte _ -> Cte 0
    {D2} Suma p q -> Suma (derivado p) (derivado q)
    {D3} Prod p q -> Suma (Prod (derivado p) q) (Prod (derivado q) p)

evaluar :: Num a => a -> Polinomio a -> Polinomio a
evaluar x poli = case poli of
    X        -> x                           {E0}
    Cte c    -> c                           {E1}
    Suma p q -> evaluar x p + evaluar x q   {E2}
    Prod p q -> evaluar x p * evaluar x q   {E3}

```


Desarrollemos primero el lado izquierdo
```
evaluar e (derivado (Prod (Cte k) p)) 
= evaluar e (Suma (Prod (derivado Cte k) p) (Prod (derivado p) Cte k))             {D3}
= evaluar e (Suma (Prod Cte 0 p) (Prod (derivado p)cte k))                         {D1}
= evaluar e (Prod Cte 0 p) + evaluar (Prod (derivado p) cte k)                     {E2}
= (evaluar e Cte 0) * (evaluar e p) + (evaluar e (derivado p)) * (evaluar e cte k) {E3}
= 0 * (evaluar e p) + (evaluar e (derivado p)) * k                                 {E1}
= evaluar e (derivado p) * k
```

Desarrollemos el lado derecho 
```
evaluar e (Prod (Cte k) (derivado p))
= evaluar e (Prod (Cte k)) * evaluar e (derivado p) {E3}
= k * evaluar e (derivado p)                        {E1} 
= evaluar e (derivado p) * k                        {INT} (Conmutatividad multiplicacion)
```

∴ Finalmente, como ambos lados son equivaletes podemos concluir que la igualdad es verdadera.

### Ejercicio 3

```
iii. Num a => ∀ p::Polinomio a. (sinConstantesNegativas p ⟹ sinConstantesNegativas (derivado p))
```

### Definiciones utiles
```hs
data Polinomio a = X
| Cte a
| Suma (Polinomio a) (Polinomio a)
| Prod (Polinomio a) (Polinomio a)

sinConstantesNegativas :: Num a => Polinomio a -> Polinomio a
{SCN} sinConstantesNegativas = foldPoli True (>=0) (&&) (&&)

foldPoli :: (a -> b) -> b -> (b -> b -> b) -> (b -> b -> b) -> Polinomio a -> b -- cortesia gpt :)
foldPoli fCte fX fSuma fProd poli = case poli of
    {FP0} X -> fX
    {FP1} Cte a -> fCte a
    {FP2} Suma p q -> fSuma (rec p) (rec q)
    {FP3} Prod p q -> fProd (rec p) (rec q)
  where
    rec = foldPoli fCte fX fSuma fProd 

derivado :: Num a => Polinomio a -> Polinomio a
derivado poli = case poli of
    {D0} X -> Cte 1                                      
    {D1} Cte _ -> Cte 0
    {D2} Suma p q -> Suma (derivado p) (derivado q)
    {D3} Prod p q -> Suma (Prod (derivado p) q) (Prod (derivado q) p)
```

Veamoslo por induccion

### Caso(s) base
Al tener dos constructores no recursivos tenemos que chequear ambos casos base.
#### Caso `Cte a`

```
sinConstantesNegativas Cte a ⟹ sinConstantesNegativas (derivado (Cte a))
⟺ foldPoli True (>=0) (&&) (&&) (Cte a) ⟹ foldPoli True (>=0) (&&) (&&) (derivado (Cte a))     {SCN}
⟺ >= 0 a ⟹ >= 0 0                                                                              {FP1}
⟺ >= 0 a ⟹ True
```

Que claramente vale porque `False ⟹ _` evalua True, y `True ⟹ True` evalua True. (Formalmente habria que usar L.G. Bool creo, pero no lo pienso hacer aca)

#### Caso `X`

```
sinConstantesNegativas x ⟹ sinConstantesNegativas (derivado x)
⟺ foldPoli True (>=0) (&&) (&&) x ⟹ foldPoli True (>=0) (&&) (&&) (derivado x)     {SCN}
⟺ >= 0 x ⟹ >= 0 1                                                                  {FP0}
⟺ >= 0 a ⟹ True
```

Idem que arriba

### Paso(s) inductivo(s)

Supongamos que la afirmacion vale para i ,d :: Polinomio a.

Tenemos que analizar los casos p = Suma i d. p = Prod i d.

Recordemos que nuestra HI es: 
```
P(p) = sinConstantesNegativas p ⟹ sinConstantesNegativas (derivado p)
```

#### Caso `p = Suma i d`
Suponemos verdadera la premisa, ya que si fuese falsa la implicacion vale trivialmente.  
QVQ `sinConstantesNegativas p ⟹ sinConstantesNegativas (derivado p)`

```
sinConstantesNegativas (derivado p)
= sinConstantesNegativas (Suma (derivado i) (derivado d))                       {D2}
= foldPoli True (>=0) (&&) (&&) (Suma (derivado i) (derivado d))                {SCN}
= foldPoli True (>=0) (&&) (&&) (derivado i) 
                && foldPoli True (>=0) (&&) (&&) (derivado d)                   {FP2}
= sinConstantesNegativas (derivado i) && sinConstantesNegativas (derivado d)    {SCN}
= True && True                                                                  {HI}
= True                                                                          {&&}
```
Luego, la implicacion vale (chequear...)

#### `Caso p = Prod i d`
TODO