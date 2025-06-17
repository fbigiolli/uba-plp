% aplanar(+Xs, -Ys)
aplanar([], []).
aplanar(X, [X]) :- not(is_list(X)).
aplanar([X|XS], YS) :- aplanar(X,L2), aplanar(XS,L3), append(L2,L3,YS).

% aplanar([[1, [2, 3], [a]], [[[]]]], L).→ L=[1, 2, 3, a]

