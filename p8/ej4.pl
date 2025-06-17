% juntar(?Lista1,?Lista2,?Lista3)
% juntar(L1,L2,L3) :- append(L1,L2,L3).

juntar([],L,L).
juntar([A|L1],L2,[A|L3]) :- juntar(L1,L2,L3).