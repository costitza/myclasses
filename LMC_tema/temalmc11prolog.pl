% helpers
minoreaza(X,S,Ord) :- not((member(Y,S), not(member((X,Y),Ord)))).

minim(M,P,Ord) :- member(M,P), minoreaza(M,P,Ord).

majoreaza(X,S,Ord) :- not((member(Y,S), not(member((Y,X),Ord)))).

maxim(M,P,Ord) :- member(M,P), majoreaza(M,P,Ord).

minorant(M,S,P,Ord) :- member(M,P), minoreaza(M,S,Ord).

minoranti(S,P,Ord,LM) :- setof(M, minorant(M,S,P,Ord), LM), !.
minoranti(_,_,_,[]).

majorant(M,S,P,Ord) :- member(M,P), majoreaza(M,S,Ord).

majoranti(S,P,Ord,LM) :- setof(M, majorant(M,S,P,Ord), LM), !.
majoranti(_,_,_,[]).

inf(Inf,S,P,Ord) :- minoranti(S,P,Ord,LM), maxim(Inf,LM,Ord).

sup(Sup,S,P,Ord) :- majoranti(S,P,Ord,LM), minim(Sup,LM,Ord).

sublista([],_).
sublista([H|T],[H|L]) :- sublista(T,L).
sublista([H|T],[_|L]) :- sublista([H|T],L).

sublat(S,L,OrdL) :- sublista(S,L), not((member(X,S), member(Y,S),
	inf(XsiY,[X,Y],L,OrdL), sup(XsauY,[X,Y],L,OrdL),
	not((member(XsiY,S), member(XsauY,S))))).

sublatmarg(S,L,OrdL) :- sublat(S,L,OrdL), minim(Zero,L,OrdL),
	maxim(Unu,L,OrdL), member(Zero,S), member(Unu,S).





distrib(Multime, Ordine) :-
    \+ (
        member(X, Multime),
        member(Y, Multime),
        member(Z, Multime),
        inf(YsiZ, [Y, Z], Multime, Ordine),
        sup(MS, [X, YsiZ], Multime, Ordine),
        sup(XsauY, [X, Y], Multime, Ordine),
        sup(XsauZ, [X, Z], Multime, Ordine),
        inf(MD, [XsauY, XsauZ], Multime, Ordine),
        MS \= MD
    ).

sublatdistrib(Sublatice, Multime, Ordine) :-
    sublat(Sublatice, Multime, Ordine),
    distrib(Sublatice, Ordine).


sublaticidistrib(Multime, Ordine, ListaSublaticiDistrib) :-
    findall(Sublatice, sublatdistrib(Sublatice, Multime, Ordine), ListaSublaticiDistrib).


sublatmargdistrib(Sublatice, Multime, Ordine) :-
    sublatmarg(Sublatice, Multime, Ordine),
    distrib(Sublatice, Ordine).


sublaticimargdistrib(Multime, Ordine, ListaSublaticiMargDistrib) :-
    findall(Sublatice, sublatmargdistrib(Sublatice, Multime, Ordine), ListaSublaticiMargDistrib).