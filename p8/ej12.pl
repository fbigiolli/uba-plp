% inorder(+AB, -Lista)
inorder(nil, []).
inorder(bin(Izq, R, Der), XS) :-
	inorder(Izq, InorderIzq),
	inorder(Der, InorderDer), % hasta aca tengo en ambas vars los recorridos inorder
	append(InorderIzq, [R], InorderHastaRaiz), % InorderHastaRaiz tiene el recorrido del subarbol izq y la raiz
	append(InorderHastaRaiz, InorderDer, XS). % XS es el resutado inorder

% arbolConInorder(+Lista, -AB)
arbolConInorder([], nil).
arbolConInorder(Lista, bin(Izq, R, Der)) :-
    Lista \= [],
    length(Lista, L),
    Mid is L // 2,
    nth0(Mid, Lista, R),
    length(LeftList, Mid),
    append(LeftList, [R|RightList], Lista),
    arbolConInorder(LeftList, Izq),
    arbolConInorder(RightList, Der).
       
% abb(+Arbol)
abb(nil).
abb(bin(Izq, R, Der)) :-
    todosMenores(Izq, R),
    todosMayores(Der, R),
    abb(Izq),
    abb(Der).

% todosMenores(+Arbol, +Valor)
todosMenores(nil, _).
todosMenores(bin(Izq, R, Der), V) :-
    R < V,
    todosMenores(Izq, V),
    todosMenores(Der, V).

% todosMayores(+Arbol, +Valor)
todosMayores(nil, _).
todosMayores(bin(Izq, R, Der), V) :-
    R > V,
    todosMayores(Izq, V),
    todosMayores(Der, V).

% aBBInsertar(+X, +T1, -T2)
aBBInsertar(Elem, nil, bin(nil,Elem,nil)).
aBBInsertar(Elem, bin(Izq, R, Der), bin(NuevaIzq, R, Der)) :-
    Elem < R,
    aBBInsertar(Elem, Izq, NuevaIzq).
aBBInsertar(Elem, bin(Izq, R, Der), bin(Izq, R, NuevoDer)) :-
    Elem > R,
    aBBInsertar(Elem, Der, NuevoDer).
aBBInsertar(Elem, bin(Izq, R, Der), bin(Izq, R, Der)) :-
    Elem =:= R.
            
