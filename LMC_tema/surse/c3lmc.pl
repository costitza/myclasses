/* Pentru a observa functionarea predicatului member, interogati:
?- member(X,[a,b]), member(Y,[1,2,3]), write((X,Y)), nl, fail.
?- not((member(X,[a,b]), member(Y,[1,2,3]), write((X,Y)), nl, fail)).

Metapredicate care colecteaza in lista ListaTermeni termenii de forma Termen care satisfac scopul (predicatul) Conditie:
	setof(Termen,Conditie,ListaTermeni)
	bagof(Termen,Conditie,ListaTermeni)
	findall(Termen,Conditie,ListaTermeni)
   setof: fara duplicate si intorcand false cand nu exista termeni care sa satisfaca scopul Conditie;
   bagof: cu duplicate si intorcand false cand nu exista termeni care sa satisfaca scopul Conditie;
   findall: cu duplicate si returnand lista vida: ListaTermeni=[], cand nu exista termeni care sa satisfaca scopul Conditie.
Interogati:
?- setof((X,Y), (member(X,[a,b]), member(Y,[1,2,3])), ProdCart).
?- bagof((X,Y), (member(X,[a,b]), member(Y,[1,2,3])), ProdCart).
?- findall((X,Y), (member(X,[a,b]), member(Y,[1,2,3])), ProdCart).
?- setof((X,Y), (member(X,[a,a,b]), member(Y,[1,2,3])), ProdCart).
?- bagof((X,Y), (member(X,[a,a,b]), member(Y,[1,2,3])), ProdCart), write(ProdCart).
?- findall((X,Y), (member(X,[a,a,b]), member(Y,[1,2,3])), ProdCart), write(ProdCart).
?- setof((X,Y), (member(X,[a,a,b]), member(Y,[])), ProdCart).
?- bagof((X,Y), (member(X,[a,a,b]), member(Y,[])), ProdCart).
?- findall((X,Y), (member(X,[a,a,b]), member(Y,[])), ProdCart).

Cazul in care scopul Conditie contine variabile care nu apar in Termen:
?- setof((X,Y), (member(X,[1,10]), member(Y,[1,2,3,4]), member(Z,[2,5]), X<Z, Z<Y), L).
?- bagof((X,Y), (member(X,[1,10]), member(Y,[1,2,3,4]), member(Z,[2,5]), X<Z, Z<Y), L).
?- findall((X,Y), (member(X,[1,10]), member(Y,[1,2,3,4]), member(Z,[2,5]), X<Z, Z<Y), L).
?- setof((X,Y), (member(X,[1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
?- bagof((X,Y), (member(X,[1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
?- findall((X,Y), (member(X,[1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
?- setof((X,Y), (member(X,[1,1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
?- bagof((X,Y), (member(X,[1,1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
?- findall((X,Y), (member(X,[1,1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
Findall face automat cuantificare existentiala pentru aceste variabile din Conditie care nu apar in Termen. Sintaxa pentru fortarea cuantificarii existentiale a acestor variabile in setof si bagof:
?- bagof((X,Y), Z^(member(X,[1,1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
?- setof((X,Y), Z^(member(X,[1,1,10]), member(Y,[1,2,3,4]), member(Z,[2,3]), X<Z, Z<Y), L).
Si pentru cuantificarea existentiala a mai multor astfel de variabile:
?- setof(Y, (X,Z)^(member(X,[1,5]), member(Y,[1,2,2,3,4]), member(Z,[3,5]), X<Y, Y<Z), L).
?- bagof(Y, (X,Z)^(member(X,[1,5]), member(Y,[1,2,2,3,4]), member(Z,[3,5]), X<Y, Y<Z), L).
Urmatoarea interogare produce acelasi rezultat precum cea anterioara; la fel mai sus; pentru anumite astfel de interogari, ordonarea elementelor in ListaTermeni poate diferi in cazul lui findall fata de bagof cu fortarea cuantificarii existentiale pentru variabilele din Conditie care nu apar in Termen:
?- findall(Y, (member(X,[1,5]), member(Y,[1,2,2,3,4]), member(Z,[3,5]), X<Y, Y<Z), L).

Sa ne amintim ce perechi de valori booleene satisfac implicatia, respectiv echivalenta:
?- member(P,[false,true]), member(Q,[false,true]), implica(P,Q), write((P,Q)), nl, fail.
?- member(P,[false,true]), member(Q,[false,true]), echiv(P,Q), write((P,Q)), nl, fail.

Sa demonstram ca disjunctia logica e distributiva fata de conjunctie, adica, pentru orice enunturi p,q,r:
	[p sau (q si r)] <=> [(p sau q) si (p sau r)]
adica enunturile [p sau (q si r)] si [(p sau q) si (p sau r)] au aceeasi valoare de adevar: */

implica(P,Q) :- not(P), ! ; Q.
echiv(P,Q) :- implica(P,Q), implica(Q,P).

ms(P,Q,R) :- P ; Q,R.
md(P,Q,R) :- (P ; Q) , (P ; R).

distribdisjfdconj(P,Q,R) :- echiv(ms(P,Q,R),md(P,Q,R)).

demdistribdisjfdconj :- not((member(P,[false,true]),
	member(Q,[false,true]), member(R,[false,true]),
	write((P,Q,R)), nl, not(distribdisjfdconj(P,Q,R)))).

/* Stergerea unei aparitii a unui element intr-o lista de pe o pozitie arbitrara: adaugand clauza de mai jos pentru stergere din lista vida, se obtine stergerea elementului de pe cel mult o pozitie, ceea ce produce in predicatul urmator si permutarile sublistelor: */

% sterge(_,[],[]).
sterge(H,[H|T],T).
sterge(X,[H|T],[H|L]) :- sterge(X,T,L).

/* Interogati:
?- sterge(a,[1,2,3,4],L).
si dati ;/Next pentru a obtine toate solutiile.
Sa observam ca acest predicat poate fi folosit pentru adaugarea unui element la o lista pe o pozitie arbitrara; interogati:
?- sterge(a,DinCeLista,[1,2,3,4]).
si dati ;/Next pentru a obtine toate solutiile.
Asadar putem folosi acest predicat in urmatoarea recurenta pentru a obtine permutarile unei liste: */

permutare([],[]).
permutare([H|T],P) :- permutare(T,Q), sterge(H,P,Q).

permutari(L,LP) :- setof(P, permutare(L,P), LP).

/* Interogati:
?- permutari([1,2,3],ListaPermutari).
?- permutari([1,2,2],ListaPermutari).
*/





