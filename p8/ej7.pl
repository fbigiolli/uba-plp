% -------------------------------------------------------- item a

%intersección(+L1, +L2, -L3)
interseccion([],_,[]).
interseccion([X|L1], L2, L3) :- not( member(X, L2) ), interseccion(L1,L2,L3).
interseccion([X|L1], L2, [X|L3]) :- member(X,L2), interseccion(L1,L2,L3).

%partir(?N, ?L, ?L1, ?L2)
partir(N, L, L1, L2) :-  append(L1,L2,L), length(L1,N).

% -------------------------------------------------------- item b

%borrar(+ListaOriginal, +X, -ListaSinXs)
borrar([], _, []).                                    
borrar([X|XS], X, R) :-  borrar(XS, X, R).              
borrar([Y|YS], X, [Y|R]) :- X \= Y,  borrar(YS, X, R).

%sacarDuplicados(+L1, -L2),
sacarDuplicados([], []).
sacarDuplicados([X | L1], [X | L2]) :- borrar(L1, X, L3), sacarDuplicados(L3, L2).

%permutacion(+L1, ?L2)
permutacion([], []).
permutacion(L1, [X|XS]) :-
    append(A, [X|B], L1),
    append(A, B, Resto),
    permutacion(Resto, XS).

%reparto(+L, +N, -LListas)
reparto(L,1,[L]).
reparto(L,N,[X|LListas]) :- 
    N > 1, % condicion enunciado
    M is N-1, % porque la parto en dos necesito que sea N-1
    length(LListas,M), % debe haber M listas en la parte rec
    append(X,Rec,L), % L va a ser el resultado de appendear la lista X con la recursion
    reparto(Rec,M,LListas). % hago que rec sea el resultado recursivo con este llamado a reparto.

% repartoSinVacias(+L, -LListas) 
repartoSinVacias(L,[L]) :- L \= [].
repartoSinVacias(L,[X|LListas]) :-
    append(X,Rec,L),
    X \= [],
    repartoSinVacias(Rec,LListas).
