% helpers

sublista([],_).
sublista([H|T],[H|L]) :- sublista(T,L).
sublista([H|T],[_|L]) :- sublista([H|T],L).


prodcart(A,B,AxB) :- setof((X,Y), (member(X,A),member(Y,B)), AxB), !.
prodcart(_,_,[]).

relbin(R,A,B) :- prodcart(A,B,AxB), sublista(R,AxB).

inj(R) :- not((member((Y,X),R), member((Z,X),R), Y\=Z)).

invrel(R,I) :- setof((Y,X), member((X,Y),R), I), !.
invrel(_,[]).

surj(R,B) :- not((member(X,B), not(member((_,X),R)))).

imag(R,I) :- setof(Y, X^member((X,Y),R), I), !.
imag(_,[]).

inclusa(A,B) :- not((member(X,A), not(member(X,B)))).

functionala(R) :- not((member((X,Y),R), member((X,Z),R), Y\=Z)).

egaldemult(A,B) :- inclusa(A,B), inclusa(B,A).

inclusain([],_).
inclusain([H|T],M) :- member(H,M), inclusain(T,M).

egalecamult(A,B) :- inclusain(A,B), inclusain(B,A).

irefl(R) :- not(member((X,X),R)).
relbinpe(R,A) :- relbin(R,A,A).

relirefl(R,A) :- relbinpe(R,A), irefl(R).

sim(R) :- not((member((X,Y),R), not(member((Y,X),R)))).

relsim(R,A) :- relbinpe(R,A), sim(R).

antisim(R) :- not((member((X,Y),R), member((Y,X),R), X\=Y)).

relantisim(R,A) :- relbinpe(R,A), antisim(R).

tranz(R) :- not((member((X,Y),R), member((Y,Z),R),
	not(member((X,Z),R)))).

reltranz(R,A) :- relbinpe(R,A), tranz(R).

tot(R,A) :- not((member(X,A), member(Y,A), X\=Y,
	not(member((X,Y),R);member((Y,X),R)))).

reltot(R,A) :- relbinpe(R,A), tot(R,A).

completa(R,A) :- not((member(X,A), member(Y,A),
	not(member((X,Y),R); member((Y,X),R)))).

relcompleta(R,A) :- relbinpe(R,A), completa(R,A).

refl(R,A) :- not((member(X,A), not(member((X,X),R)))).

preord(R,A) :- refl(R,A), tranz(R).

relpreord(R,A) :- relbinpe(R,A), preord(R,A).

afisLista([]).
afisLista([H|T]) :- write(H), (T=[], ! ; write(',')), afisLista(T).

asim(R) :- not((member((X,Y),R), member((Y,X),R))).

relasim(R,A) :- relbinpe(R,A), asim(R).

% exercitii rezolvate


relinj(R, A, B) :- relbin(R, A, B), inj(R).

relatiiinj(A, B, LR) :- setof(R, relinj(R, A, B), LR).

injectiva(R) :- invrel(R, InvR), functionala(InvR).

relsurj(R, A, B) :- relbin(R, A, B), surj(R, B).

relatiisurj(A, B, LR) :- setof(R, relsurj(R, A, B), LR).

surjectiva(R, B) :- imag(R, Im), egalecamult(Im, B).

relatiiirefl(A, LR) :- setof(R, relirefl(R, A), LR).

relatiisim(A, LR) :- setof(R, relsim(R, A), LR).

relatiiantisim(A, LR) :- setof(R, relantisim(R, A), LR).

relatiiasim(A, LR) :- setof(R, relasim(R, A), LR).

relatiitranz(A, LR) :- setof(R, reltranz(R, A), LR).

relatiitot(A, LR) :- setof(R, reltot(R, A), LR).

relatiicomplete(A, LR) :- setof(R, relcompleta(R, A), LR).

relatiipreord(A, LR) :- setof(R, relpreord(R, A), LR).

relatiipreordcuafis(A, LR, Nr) :- relatiipreord(A, LR), length(LR, Nr), afisLista(LR).

