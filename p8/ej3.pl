% Considerar las siguientes definiciones
natural(0).
natural(suc(X)) :- natural(X).

menorOIgual(X,X) :- natural(X).
menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).


I)Se va a colgar ya que va a unificar siempre con menorOIgual(X, suc(Y))

II)Si no encuentra un caso base,

III)Trivial


