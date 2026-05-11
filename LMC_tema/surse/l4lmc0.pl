:- [l2lmc1,c5lmc1].

% afisarea elementelor unei liste cu fiecare element pe cate un rand:

afislista([]).
afislista([H|T]) :- write(H), nl, afislista(T).

% afisarea a N underscoruri:

afislinie(0) :- !.
afislinie(K) :- write('_'), P is K-1, afislinie(P).

/* afisarea elementelor unei liste cu cate un spatiu intre doua elemente consecutive: */

afislist([]).
afislist([H|T]) :- write(H), tab(1), afislist(T).

/* imaginea unei functii f:A->B sub forma listei elementelor f(a), cu a in A, cu elementele lui A in ordinea in care apar in lista care da multimea A: */

listimag([],[]).
listimag([(_,Y)|T],[Y|U]) :- listimag(T,U).

/* afisarea unei liste de functii definite pe aceeasi multime prin tabel de valori: */

afislistfct([]).
afislistfct([F|LF]) :- write('f(x)| '),
	listimag(F,I), afislist(I), nl, afislistfct(LF).

/* afisarea unei liste de functii definite pe aceeasi multime prin tabel de valori, cu tot cu antetul tabelului: */

afislistafct(LF,A) :- write('  x  | '), afislist(A), nl,
	length(A,N), K is 2*N+3, afislinie(K), nl,
	afislistfct(LF).
	
% produsul cartezian a doua multimi:

prodcart(A,B,AxB) :- setof((X,Y), (member(X,A),member(Y,B)), AxB), !.
prodcart(_,_,[]).

% produsul cartezian a doua liste:

prodcartliste(A,B,AxB) :- findall((X,Y),
	(member(X,A),member(Y,B)), AxB).

% generarea relatiilor binare R de la A la B:

relbin(R,A,B) :- prodcart(A,B,AxB), sublista(R,AxB).

/* multimea (i.e. lista fara duplicate) LR a relatiilor binare de la A la B: */

relatiibinare(A,B,LR) :- setof(R, relbin(R,A,B), LR).

/* testarea functionalitatii (adica faptului de a fi functie partiala) unei relatii binare R: */

functionala(R) :- not((member((X,Y),R), member((X,Z),R), Y\=Z)).

/* generarea relatiilor binare functionale (adica a functiilor partiale) F:A-o->B, prin selectarea dintre relatiile binare F de la A la B a celor care satisfac predicatul anterior: */

fctpart(F,A,B) :- relbin(F,A,B), functionala(F).

/* multimea (i.e. lista fara duplicate) LF a relatiilor binare functionale (adica a functiilor partiale) de la A la B: */

functiipartiale(A,B,LF) :- setof(F, fctpart(F,A,B), LF), !.
functiipartiale(_,_,[]).

/* imaginea I a unei relatii binare R (daca R e functie, atunci I e imaginea acelei functii: {R(X) | X in domeniul lui R}): */

imag(R,I) :- setof(Y, X^member((X,Y),R), I), !.
imag(_,[]).

% domeniul D al unei relatii binare R:

dom(R,D) :- setof(X, Y^member((X,Y),R), D), !.
dom(_,[]).

/* Interogati:
?- imag([(1,a),(2,a),(2,b),(2,c)],Imaginea).
?- listimag([(1,a),(2,a),(2,b),(2,c)],ListaImagine).
?- dom([(1,a),(2,a),(2,b),(2,c)],Domeniul).
?- listimag([(1,a),(2,a),(2,b),(2,c),(3,b)],ListaImagine).
?- functie(F,[1,2,3],[a,b,c]), afislistafct([F],[1,2,3]), imag(F,Imaginea), dom(F,Domeniul), listimag(F,ListaImagine), egaldemult(Imaginea,ListaImagine).
?- functie(F,[1,2],[a,b]), afislistafct([F],[1,2]), imag(F,Imaginea), dom(F,Domeniul), listimag(F,ListaImagine), egaldemult(Imaginea,ListaImagine).
?- relatiibinare([a,b],[1,2,3],L), afislista(L), length(L,Cate).
?- functiipartiale([a,b],[1,2,3],L), afislista(L), length(L,Cate).
?- functiile([a,b],[1,2,3],L), afislista(L), length(L,Cate).
?- bijectiile([a,b],[1,2,3],L), afislista(L), length(L,Cate).
?- bijectiile([a,b,c],[1,2,3],L), afislista(L), length(L,Cate).
?- functiile([a,b],[1,2,3],L), afislistafct(L,[a,b]), length(L,Cate).
?- bijectiile([a,b,c],[1,2,3],L), afislistafct(L,[a,b,c]), length(L,Cate).
*/

/* testarea totalitatii unei relatii binare R de la A la o (alta) multime: */

totala(R,A) :- not((member(X,A), not(member((X,_),R)))).

/* generarea relatiilor binare totale R de la A la B, prin selectarea dintre relatiile binare R de la A la B a celor care satisfac predicatul anterior: */

reltotala(R,A,B) :- relbin(R,A,B), totala(R,A).

/* generarea functiilor F:A->B, mai putin eficient decat cu predicatul functie */

relfcttot(F,A,B) :- fctpart(F,A,B), totala(F,A).

relatiifcttot(A,B,LF) :- setof(F, relfcttot(F,A,B), LF), !.
relatiifcttot(_,_,[]).

/* Interogati:
?- functiile([a,b],[1,2,3],L), write('Functiile:'), nl, afislista(L), length(L,Cate), nl, relatiifcttot([a,b],[1,2,3],M), write('Relatiile functionale totale:'), nl, afislista(M), length(M,CateSunt), nl, egaldemult(L,M), write('Sunt unele si aceleasi.').
*/

% testarea injectivitatii unei relatii binare R:

inj(R) :- not((member((Y,X),R), member((Z,X),R), Y\=Z)).

% testarea surjectivitatii unei relatii binare R:

surj(R,B) :- not((member(X,B), not(member((_,X),R)))).

/* generarea functiilor injective F de la A la B, prin selectarea dintre functiile F:A->B a celor care satisfac predicatul unar inj de mai sus: */

fctinj(F,A,B) :- functie(F,A,B), inj(F).

/* multimea (i.e. lista fara duplicate) LF a functiilor injective F:A->B; le pot colecta si cu findall, pentru ca fctinj(F,A,B) nu duplica solutiile, intrucat functie(F,A,B) nu duplica solutiile: */

functiileinj(A,B,LF) :- setof(F, fctinj(F,A,B), LF), !.
functiileinj(_,_,[]).

functiiinj(A,B,LF) :- findall(F, fctinj(F,A,B), LF).

/* generarea functiilor surjective F de la A la B, prin selectarea dintre functiile F:A->B a celor care satisfac predicatul binar surj de mai sus cu al doilea argument B: */

fctsurj(F,A,B) :- functie(F,A,B), surj(F,B).

/* multimea (i.e. lista fara duplicate) LF a functiilor surjective F:A->B; le pot colecta si cu findall, pentru ca fctsurj(F,A,B) nu duplica solutiile, intrucat functie(F,A,B) nu duplica solutiile: */

functiilesurj(A,B,LF) :- setof(F, fctsurj(F,A,B), LF), !.
functiilesurj(_,_,[]).

functiisurj(A,B,LF) :- findall(F, fctsurj(F,A,B), LF).

/* generarea bijectiilor F de la A la B, mai dezavantajos decat cu predicatul bijectie de la Cursul 5, anume prin selectarea dintre functiile F:A->B a celor care satisfac predicatul unar inj si predicatul binar surj de mai sus cu al doilea argument B: */

fctbij(F,A,B) :- functie(F,A,B), inj(F), surj(F,B).

/* multimea (i.e. lista fara duplicate) LF a bijectiilor F:A->B; le pot colecta si cu findall, pentru ca fctbij(F,A,B) nu duplica solutiile, intrucat functie(F,A,B) nu duplica solutiile: */

functiilebij(A,B,LF) :- setof(F, fctbij(F,A,B), LF), !.
functiilebij(_,_,[]).

functiibij(A,B,LF) :- findall(F, fctbij(F,A,B), LF).

/* Interogati:
?- functiileinj([a,b],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b]).
?- functiiinj([a,b],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b]).
?- functiilesurj([a,b],[1,2,3],L), length(L,Cate).
?- functiisurj([a,b],[1,2,3],L), length(L,Cate).
?- functiileinj([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- functiiinj([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- functiilesurj([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- functiisurj([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- functiilebij([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- functiibij([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- bijectiile([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- bijectii([a,b,c],[1,2,3],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- functiilesurj([a,b,c],[1,2],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
?- functiisurj([a,b,c],[1,2],L), length(L,Cate), afislista(L), nl, afislistafct(L,[a,b,c]).
*/

% inversa unei liste:

inversa([],[]).
inversa([H|T],L) :- inversa(T,M), append(M,[H],L).

/* Interogati:
?- inversa([a,b,c,d],L).
?- inversa(L,[a,b,c,d]).
?- reverse([a,b,c,d],L).
?- reverse(L,[a,b,c,d]).
*/

% diagonala D a unei multimi A, cu doua variante de calcul:

diag(A,D) :- setof((X,X), member(X,A), D), !.
diag(_,[]).

diagonala([],[]).
diagonala([H|T],[(H,H)|U]) :- diagonala(T,U).

% inversa I a unei relatii binare R, cu doua variante de calcul:

invrel(R,I) :- setof((Y,X), member((X,Y),R), I), !.
invrel(_,[]).

inversarel([],[]).
inversarel([(X,Y)|T],[(Y,X)|U]) :- inversarel(T,U).

% compunerea a doua relatii binare:

comp(S,R,SoR) :- 
	setof((X,Z), Y^(member((X,Y),R), member((Y,Z),S)), SoR), !.
comp(_,_,[]).

/* puterea a N-a a unei relatii binare R pe o multime A, adica a unei relatii binare R de la A la A: */

putere(_,A,0,Rla0) :- diag(A,Rla0), !.
putere(R,_,N,RlaN) :- putere(R,N,RlaN).

/* puterea a N-a a unei relatii binare R pe o multime, cu N nenul; prima clauza trateaza cazul N intreg negativ, iar urmatoarele doua clauze calculeaza recursiv pe R la N in cazul N natural nenul: */

putere(R,N,RlaN) :- N<0, !, K is -N, invrel(R,I), putere(I,K,RlaN).
putere(R,1,R).
putere(R,N,RlaN) :- N>1, K is N-1, putere(R,K,RlaK),
	comp(RlaK,R,RlaN).

% produsul direct a doua relatii binare:

prodrel(R,S,RxS) :- setof(((A,X),(B,Y)),
	 (member((A,B),R), member((X,Y),S)), RxS), !.
prodrel(_,_,[]).

/* produsul direct a N relatii binare date sub forma unei liste de relatii binare:
	prodrelatii(+ListaRelatiiBinare,-ProdusulDirect)=true <=>
ListaRelatiiBinare=[R1,R2,...,RN], unde R1,R2,...,RN sunt relatii binare, iar ProdusulDirect = R1 x R2 x ... x RN: */

prodrelatii([R],R).
prodrelatii([R|LR],Prod) :- prodrelatii(LR,P), prodrel(R,P,Prod).

/* Interogati:
?- diag([a,b,c],Diag).
?- diag([a,b,c,a,b,b],Diag).
?- diagonala([a,b,c],Diag).
?- diagonala([a,b,c,a,b,b],Diag).
?- invrel([(a,b),(c,a)],Inversa).
?- inversarel([(a,b),(c,a)],Inversa).
?- invrel([(a,b),nuepereche,(c,a),(a,b)],Inversa).
?- inversarel([(a,b),(c,a),(a,b)],Inversa).
?- inversarel([(a,b),nuepereche,(c,a),(a,b)],Inversa).
?- comp([(b,e),(c,e)],[(a,b),(a,c),(d,c)],Comp).
?- comp([(a,b),(a,c),(d,c)],[(b,e),(c,e)],Comp).
?- putere([(a,b),(b,c),(c,d)],[a,b,c,d],0,Rla0).
?- putere([(a,b),(b,c),(c,d)],1,Rla1).
?- putere([(a,b),(b,c),(c,d)],-1,RlaMinus1).
?- putere([(a,b),(b,c),(c,d)],[a,b,c,d],2,Rla2).
?- putere([(a,b),(b,c),(c,d)],2,Rla2).
?- putere([(a,b),(b,c),(c,d)],-2,RlaMinus2).
?- putere([(a,b),(b,c),(c,d)],3,Rla3).
?- putere([(a,b),(b,c),(c,d)],-3,RlaMinus3).
?- putere([(a,b),(b,c),(c,d)],4,Rla4).
?- putere([(a,b),(b,c),(c,d)],-4,RlaMinus4).
?- prodrel([(a,b),(a,c)],[(1,2)],ProdRel).
?- prodrelatii([[(a,b),(a,c)]],ProdRel).
?- prodrelatii([[(a,b),(a,c)],[(1,2)]],ProdRel).
?- prodrelatii([[(a,b),(a,c)],[(1,2)],[(x,y)]],ProdRel).
*/

