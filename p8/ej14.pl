desde(N, N).
desde(N, X) :-
    N1 is N + 1,
    desde(N1, X).

% cuadradoSemiMágico(+N, -XS) 
cuadradoSemiMagico(N, XS) :- 
    desde(0, K),                            
    length(XS, N),
    todasLasFilasSumanKConLengthN(XS, N, K).

% todasLasFilasSumanKConLengthN(-XS, +N, +K)
todasLasFilasSumanKConLengthN([], _, _).
todasLasFilasSumanKConLengthN([Fila|Filas], N, K) :-
    filaSumaK(N, K, Fila),
    todasLasFilasSumanKConLengthN(Filas, N, K).

% filaSumaK(+N, +K, -Fila): genera una lista Fila de longitud N que suma K
filaSumaK(0, 0, []).
filaSumaK(N, K, [X|Xs]) :-
    N > 0,
    between(0, K, X),        % generamos un número entre 0 y K
    K1 is K - X,             % la suma que falta para el resto
    N1 is N - 1,             % la longitud restante
    filaSumaK(N1, K1, Xs).   % recursión sobre el resto


% ------------------- item b ---------------------------
% cuadradoMagico(+N, -XS)
cuadradoMagico(N, XS) :-
    cuadradoSemiMagico(N, CuadradoSemiMagico),
    valorSumadoPorLasFilas(K, CuadradoSemiMagico),
    todasLasColumnasSumanK(CuadradoSemiMagico, K),
    XS = CuadradoSemiMagico.
    
% suma_lista(+Lista, -Suma)
suma_lista([], 0).
suma_lista([X|Xs], S) :-
    suma_lista(Xs, S1),
    S is S1 + X.

% valorSumadoPorLasFilas(-N, +CuadradoSemiMagico)
% importante que se le pase un semi magico porque toma la suma de la primer fila
valorSumadoPorLasFilas(N, [X|_]) :- 
    suma_lista(X, N).

% todasLasColumnasSumanK(+CuadradoSemiMagico, +K)
todasLasColumnasSumanK([Fila|_], K) :-
    length(Fila, N),
    columnasSumanKDesde0(0, N, [Fila|_], K, [Fila|_]).

% columnasSumanKDesde0(+IndiceActual, +TotalColumnas, +Matriz, +K)
columnasSumanKDesde0(I, N, _, _, _) :-
    I >= N. % ya revisamos todas las columnas
columnasSumanKDesde0(I, N, CuadradoSemiMagico, K, OriginalCuadradoSemiMagico) :-
    sumarColumna(CuadradoSemiMagico, I, 0, Suma),
    Suma =:= K,
    I1 is I + 1,
    columnasSumanKDesde0(I1, N, OriginalCuadradoSemiMagico, K, OriginalCuadradoSemiMagico).

% sumarColumna(+CuadradoSemiMagico, +Indice, +Acumulador, -Suma)
sumarColumna([], _, S, S).
sumarColumna([Fila|Filas], I, Acum, Suma) :-
    nth0(I, Fila, Elem),
    Acum1 is Acum + Elem,
    sumarColumna(Filas, I, Acum1, Suma).
