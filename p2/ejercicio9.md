### Enunciado

Dadas las funciones altura y cantNodos definidas en la práctica 1 para árboles binarios, demostrar la siguiente propiedad:
```
∀ x::AB a . altura x ≤ cantNodos x
```

### Resolucion

Recordemos en primer lugar la definicion de ambas funciones:

```
altura :: AB a -> Int
{A0} altura Nil = 0
{A1} altura (Bin izq _ der) = 1 + max (altura izq) (altura der)
```

```
cantNodos :: AB a -> Int
{CN0} cantNodos Nil = 0
{CN1} cantNodos (Bin izq _ der) = 1 + cantNodos izq + cantNodos der
```

Entonces, demostremos por induccion que vale la propiedad.

#### Caso base

Sea x = Nil, tenemos que:

```
altura Nil ≤ cantNodos Nil
0 ≤ 0 ✓                        {A0, CN0}
```

#### Paso inductivo
Recordemos nuestro predicado: 
```
∀ x::AB a . altura x ≤ cantNodos x
```

Sean `izq , der :: AB`, asumimos que valen `P(izq)` y `P(der)`.
Sea `A = Bin (izq r der)`, queremos ver que la propiedad vale para el:
```
P(A) = altura (Bin izq r der) ≤ cantNodos (Bin izq r der).
= 1 + max (altura izq) (altura der) ≤ 1 + cantNodos izq + cantNodos der  {A1, CN1}
= max (altura izq) (altura der) ≤ cantNodos izq + cantNodos der          {INT}
```

Notemos que una vez llegado este punto tenemos dos opciones:   


O bien vale que:
```
max (altura izq) (altura der) = altura izq
```
O vale que:
```
max (altura izq) (altura der) = altura der
```

La demostracion de aqui en adelante es analoga para ambos casos.  
SPG, sea el resultado de aplicar maximo a ambos `altura izq`:
```
altura izq ≤ cantNodos izq + cantNodos der
```
Por HI sabemos que `altura izq ≤ cantNodos izq`. Lo que nos falta probar para poder afirmar que la desigualdad vale es que la cantNodos der no sea un numero negativo. Veamoslo por induccion: 

#### Demostracion lema auxiliar
```
∀ x::AB a . cantNodos x ≥ 0
```

#### Caso base

```
cantNodos Nil ≥ 0 
= 0 ≥ 0  ✓            {CN0}
```

Luego, el caso base vale. Veamos el paso inductivo  

#### Paso inductivo
Asumimos P(izq) y P(der).
```
P(x) = x::AB a . cantNodos x ≥ 0
```
QVQ vale
```
P(Bin(izq r der)) = cantNodos Bin(izq r der) ≥ 0
```
Demostremoslo:

```
cantNodos Bin(izq r der) ≥ 0
= 1 + cantNodos(izq) + cantNodos(der) ≥ 0   {CN1}
```

Lo cual trivialmente vale por HI, ya que tanto cantNodos izq como cantNodos der son mayores o iguales a 0, luego su suma debe ser mayor a 0 por ser numeros naturales, y sumarle 1 sigue siendo mayor a 0. 

∴ Habiendo probado el lema, vale la desigualdad, y luego por inducción estructural sobre árboles binarios, se cumple que:

```
∀ x :: AB a. altura x ≤ cantNodos x ∴
```∴