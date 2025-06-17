% vacio(+AB)
vacio(nil).

% raiz(+AB, ?R)
raiz(bin(_,R,_), R).

% altura(+AB, Alt?)
altura(nil, 0).
altura(bin(Izq, _, Der), Alt) :-
    altura(Izq, AltIzq),
    altura(Der, AltDer),
    MaxAlt is max(AltIzq, AltDer),
    Alt is MaxAlt + 1.

% cantidadDeNodos(+AB, ?Cant)
cantidadDeNodos(nil,0).
cantidadDeNodos(bin(Izq, _, Der), Cant) :-
	cantidadDeNodos(Izq, CantIzq),
	cantidadDeNodos(Der, CantDer),
	Cant is 1 + CantIzq + CantDer.
