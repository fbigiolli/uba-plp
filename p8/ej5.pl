
% last(?L, ?U) 
last(L,U) :- append(L1,[U], L).

% reverse(+L, ?R)
reversee([], []).
reversee([A|L] , R) :- reversee(L, L2), append(L2,[A], R). 

% pertenece(?X, +L)
pertenece(X, [X|_]).
pertenece(X, [B|L]) :- pertenece(X,L).