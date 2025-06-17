desde(N, N).
desde(N, X) :-
    N1 is N + 1,
    desde(N1, X).

coprimos(X, Y) :-
    desde(2,X),         % Voy generando los X infinitamente
    between(1,X,Y),     % Para cada X generado genero Y entre 1 y X
    G is gcd(X, Y),     % Hago la cuentita para ver si son coprimos
    G =:= 1.

