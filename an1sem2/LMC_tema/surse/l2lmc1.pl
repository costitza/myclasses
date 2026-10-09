/* Fie A, B, C multimi arbitrare. Fie x element arbitrar.
Pentru orice multime M, notez:
	x in M <=> x apartine lui M
Sa notam cu urmatoarele variabile Prolog aceste enunturi:
	_a: x in A
	_b: x in B
	_c: x in C
Sa demonstram ca:
	AU(B^C)=(AUB)^(AUC)
Avem de demonstrat ca:
	x in AU(B^C) <=> x in (AUB)^(AUC)
pentru elementul arbitrar x,
adica, indiferent carora dintre multimile A,B,C le apartine x:
	[(x in A) sau ((x in B) si (x in C))] <=>
	[(x in A sau x in B) si (x in A sau x in C)],
adica, indiferent ce valori de adevar au enunturile x in A, x in B, x in C, enunturile compuse:
	[(x in A) sau ((x in B) si (x in C))] si
	[(x in A sau x in B) si (x in A sau x in C)]
au aceeasi valoare de adevar.
Avem de demonstrat ca, pentru orice triplet de valori de adevar pentru
(_a,_b,_c), enunturile de mai sus au aceeasi valoare de adevar, adica:
[_a sau (_b si _c)] <=> [(_a sau _b) si (_a sau _c)], adica:
	pentru orice triplet de valori de adevar pentru (_a,_b,_c),
	echiv(_a;_b,_c,(_a;_b),(_a;_c)) intoarce true,
   adica:
	nu exista triplet de valori de adevar pentru (_a,_b,_c) pentru care not(echiv(_a;_b,_c,(_a;_b),(_a;_c))) sa intoarca true.
La al doilea curs am efectuat aceasta demonstratie pentru distributivitatea disjunctiei fata de conjunctie, adica proprietatea ca, oricare ar fi enunturile p,q,r fiecare avand valoarea de adevar fals sau adevarat, are loc:
	[p sau (q si r)] <=> [(p sau q) si (p sau r)],
adica, pentru orice triplet de valori de adevar pentru enunturile p,q,r, cei doi termeni ai echivalentei de mai sus au aceeasi valoare de adevar.
Reprezentand enunturile p,q,r prin variabilele Prolog P,Q, respectiv R:
*/

implica(P,Q) :- not(P), ! ; Q.
echiv(P,Q) :- implica(P,Q), implica(Q,P).

ms(P,Q,R) :- P ; Q,R.
md(P,Q,R) :- (P ; Q) , (P ; R).

distribdisjfdconj(P,Q,R) :- echiv(ms(P,Q,R),md(P,Q,R)).

demdistribdisjfdconj :- not((member(P,[false,true]),
	member(Q,[false,true]), member(R,[false,true]),
	write((P,Q,R)), nl, not(distribdisjfdconj(P,Q,R)))).

/* Daca inlocuim (P,Q,R) cu (_a,_b,_c), obtinem exact proprietatea de mai sus: [_a sau (_b si _c)] <=> [(_a sau _b) si (_a sau _c)], adica:
AU(B^C)=(AUB)^(AUC). */

/* Sa demonstram ca:
	A^(BUC)=(A^B)U(A^C)
Cu aceleasi notatii ca mai sus, avem de demonstrat:
	x in A^(BUC) <=> x in (A^B)U(A^C), adica:
   [(x in A) si (x in B sau x in C)] <=> 
	[(x in A si x in B) sau (x in A si x in C)]
adica: [_a,(_b;_c)] <=> [(_a,_b);(_a,_c)], adica:
	pentru orice triplet de valori de adevar pentru (_a,_b,_c),
	echiv(_a,(_b;_c),(_a,_b);(_a,_c)) intoarce true,
adica:
	nu exista triplet de valori de adevar pentru (_a,_b,_c) pentru care not(echiv(_a,(_b;_c),(_a,_b);(_a,_c))) sa intoarca true:
*/

distribintersfdreun(_a,_b,_c) :- echiv((_a,(_b;_c)),(_a,_b);(_a,_c)).

demdistribintersfdreun :- not((member(_a,[false,true]),
	member(_b,[false,true]), member(_c,[false,true]),
	write((_a,_b,_c)), nl,
	not(distribintersfdreun(_a,_b,_c)))).

/* Sa demonstram ca:
	A<=B => AUC<=BUC,
adica are loc, pentru orice x:
   [(x in A => x in B)] => [(x in A sau x in C) => (x in B sau x in C)],
adica:
	pentru orice triplet de valori de adevar pentru (_a,_b,_c):
	[(_a => _b)] => [(_a sau _c) => (_b sau _c)]
adica:
	pentru orice triplet de valori de adevar pentru (_a,_b,_c):
	implica(implica(_a,_b),implica(_a;_c,_b;_c)) intoarce true,
adica:
	nu exista triplet de valori de adevar pentru (_a,_b,_c) pentru care not(implica(implica(_a,_b),implica(_a;_c,_b;_c))) sa intoarca true: */

reunambiimembriincl(_a,_b,_c) :- 
	implica(implica(_a,_b),implica(_a;_c,_b;_c)).

demreunambiimembriincl :- not((member(_a,[false,true]),
	member(_b,[false,true]), member(_c,[false,true]),
	write((_a,_b,_c)), nl,
	not(reunambiimembripastrincl(_a,_b,_c)))).

%%%%%%%%%%%%MATERIAL FACULTATIV%%%%%%%%%%%%
/* Vedeti inregistrarea Laboratorului 2 de la grupa 143.
Interogati cu predicatele zeroare de mai jos:
?- testconjunctie.
?- testulconjunctie.
?- testaltenuntcompus.
?- testimplicatie.
?- testdistribintersfdreun.
*/

afiscunr([],_).
afiscunr([H|T],N) :- K is N+1, write(H), write(' e solutia '), write(K),
	nl, afiscunr(T,K).

testconjunctie :- testconj(L), afiscunr(L,0).

testconj(L) :- setof((_a,_b,_c), (member(_a,[false,true]),
	member(_b,[false,true]), member(_c,[false,true]),
	(not(_a);not(_b);not(_c))), L).

testulconjunctie :- not((member(_a,[false,true]),
	member(_b,[false,true]), member(_c,[false,true]),
	write((_a,_b,_c)), nl,
	not((not(_a);not(_b);not(_c))))).

testaltenuntcompus :- not((member(_a,[false,true]),
	member(_b,[false,true]), member(_c,[false,true]),
	write((_a,_b,_c)), nl,
	not(implica(_a,_b;_c)))).

testimplicatie :- testimplica(L), afiscunr(L,0).

testimplica(L) :- setof((_a,_b,_c), (member(_a,[false,true]),
	member(_b,[false,true]), member(_c,[false,true]),
	implica(_a,_b;_c)), L).

testdistribintersfdreun :- testdistribintersreun(L), afiscunr(L,0).

testdistribintersreun(L) :- setof((_a,_b,_c),
	(member(_a,[false,true]), member(_b,[false,true]),
	member(_c,[false,true]),
	distribintersfdreun(_a,_b,_c)), L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/* Demonstratii precum cele de mai sus prin calcul cu valori de adevar pentru proprietati ale operatiilor si relatiilor intre multimi sunt valabile pentru orice multimi, de orice cardinale.
Daca vrem sa calculam rezultatul unei operatii cu multimi sau sa determinam relatii intre multimi in Prolog, putem lucra cu multimi finite date de liste (fara duplicate) in Prolog. */

% Incluziunea intre multimi - variante de definire:
% recursiv:

inclusain([],_).
inclusain([H|T],M) :- member(H,M), inclusain(T,M).

% simuland recursia prin folosirea negatiei, ca mai sus:

inclusa(A,B) :- not((member(X,A), not(member(X,B)))).

/* Egalitatea de multimi, definita prin dubla incluziune, folosind unul dintre predicatele de mai sus: */

egalecamult(A,B) :- inclusain(A,B), inclusain(B,A).

egaldemult(A,B) :- inclusa(A,B), inclusa(B,A).

/* Predicatele inclusain si inclusa de mai sus functioneaza doar sub forma:
inclusain(+Submultime,+Multime) si inclusa(+Submultime,+Multime); acestea nu pot fi folosite pentru generarea submultimilor unei multimi.
Pentru a le genera, putem folosi predicatul sublista de mai jos, care genereaza sublistele unei liste L cu elementele in ordinea in care apar in L, dar nu neaparat pe pozitii consecutive in L.
Putem colecta, apoi, toate sublistele unei liste ca in predicatul sublistele de mai jos, si folosi acest predicat pentru a obtine partile unei multimi; pentru liste fara duplicate, predicatul sublistele intoarce partile multimilor date de acele liste. */

sublista([],_).
sublista([H|T],[H|L]) :- sublista(T,L).
sublista([H|T],[_|L]) :- sublista([H|T],L). % fara aceasta ultima clauza,
		% predicatul ar genera doar prefixele listei

sublistele(L,LS) :- setof(S, sublista(S,L), LS).

partimult(M,PM) :- eldup(M,Mult), sublistele(Mult,PM).

/* Interogati:
?- sublistele([1,2,3],Care), length(Care,Cate).
?- sublistele([1,2,2],Care), length(Care,Cate).
?- partimult([1,2,3],Care), length(Care,Cate).
?- partimult([1,2,2],Care), length(Care,Cate).
pentru a afla si cate subliste/submultimi are lista/multimea respectiva. */

% Stergerea tuturor aparitiilor unui element dintr-o lista:

stergetot(_,[],[]).
stergetot(H,[H|T],L) :- stergetot(H,T,L), !.
stergetot(X,[H|T],[H|L]) :- stergetot(X,T,L).

/* Pentru a transforma o lista in multime, vom elimina duplicatele din aceasta. Sigur ca, in lista rezultata, ca termen Prolog, va conta ordinea elementelor, pe cand intr-o multime (finita) nu conteaza in ce ordine enumeram elementele.
Eliminarea duplicatelor dintr-o lista cu pastrarea primei aparitii a fiecarui element in lista: */

elimdup([],[]).
elimdup([H|T],[H|L]) :- stergetot(H,T,U), elimdup(U,L).

/* Eliminarea duplicatelor dintr-o lista cu pastrarea ultimei aparitii a fiecarui element in lista: */

elimdupl([],[]).
elimdupl([H|T],[H|L]) :- not(member(H,T)), !, elimdupl(T,L).
elimdupl([_|T],L) :- elimdupl(T,L).

/* Eliminarea duplicatelor dintr-o lista cu sortarea elementelor dupa ordinea pe termeni @=< in Prolog: */

eldup(L,M) :- setof(X, member(X,L), M), !.
eldup(_,[]).

/* Reuniunea a doua multimi - variante de calcul (o alta varianta ar fi o recursie de tipul celei de mai jos pentru calculul intersectiei a doua multimi): */
% concatenare urmata de eliminarea duplicatelor, cu un predicat anterior:

reuniune(A,B,R) :- append(A,B,C), elimdup(C,R).

reuniunea(A,B,R) :- append(A,B,C), elimdupl(C,R).

reuni(A,B,R) :- append(A,B,C), eldup(C,R).

% cu definitia reuniunii, folosind metapredicatul setof:

reun(A,B,R) :- setof(X, (member(X,A) ; member(X,B)), R), !.
reun(_,_,[]).

% Intersectia a doua multimi - variante de calcul:
% recursiv, cu eliminarea duplicatelor dupa incheierea recursiei:

intersectia(A,B,I) :- intersectie(A,B,C), elimdupl(C,I).

intersectie([],_,[]).
intersectie([H|T],M,[H|L]) :- member(H,M), !, intersectie(T,M,L).
intersectie([_|T],M,L) :- intersectie(T,M,L).

% cu definitia intersectiei, folosind metapredicatul setof:

inters(A,B,I) :- setof(X, (member(X,A) , member(X,B)), I), !.
inters(_,_,[]).

% Sa calculam diferenta de multimi:
% cu definitia diferentei, folosind metapredicatul setof:

dif(A,B,AminusB) :- setof(X, (member(X,A), not(member(X,B))), AminusB), !.
dif(_,_,[]).

% folosind recursie dupa al doilea argument, urmata de eliminarea duplicatelor:

diferenta(A,B,AminusB) :- difer(A,B,D), eldup(D,AminusB).

difer(A,[],A).
difer(A,[H|T],D) :- stergetot(H,A,L), difer(L,T,D).

% folosind recursie dupa primul argument, urmata de eliminarea duplicatelor:

diferentae(A,B,AminusB) :- diferen(A,B,D), eldup(D,AminusB).

diferen([],_,[]).
diferen([H|T],B,[H|L]) :- not(member(H,B)), !, diferen(T,B,L).
diferen([_|T],B,L) :- diferen(T,B,L).

/* Sa calculam diferenta simetrica a doua multimi:
cu definitia diferentei simetrice, folosind metapredicatul setof si urmatorul predicat, care calculeaza sau-ul exclusiv intre doua expresii booleene: */

xor(P,Q) :- P,not(Q) ; Q,not(P).

difsim(A,B,D) :- setof(X, xor(member(X,A),member(X,B)), D), !.
difsim(_,_,[]).

/* aplicand unul dintre predicatele de mai sus pentru calculul celor doua diferente, apoi unul dintre cele pentru calculul reuniunii: */

difersim(A,B,D) :- dif(A,B,AminusB), dif(B,A,BminusA), reun(AminusB,BminusA,D).

/* cum cele doua diferente sunt disjuncte, daca am utilizat unul dintre predicatele care calculeaza diferenta fara duplicate, putem folosi apoi si concatenarea in locul reuniunii: */

diferentasim(A,B,D) :- dif(A,B,AminusB), dif(B,A,BminusA),
		append(AminusB,BminusA,D).

/* Sa rezolvam, prin tabel de adevar efectuat in Prolog, Exercitiul 4 din prima parte a Seminarului 1.
O varianta ar fi sa scriem proprietatile a,b,c,d ca predicate unare, in maniera: notam cu a(s) faptul ca o substanta s are proprietatea a; dar ar fi mai dificil de scris si implementat rationamentul in Prolog.
Asadar vom considera proprietatile a,b,c,d asupra unei substante date (fixate: substanta la care ne referim la momentul curent) ca fiind intotdeauna false sau adevarate, deci ca fiind propozitii.

ipoteza1(a,b,c,d):    (a si b) => (c xor d)
ipoteza2(a,b,c,d):    (b si c) => [(a si d) sau (non a si non d)]
ipoteza3(a,b,c,d):    (non a si non b) => (non c si non d)

ipoteza(a,b,c,d): ipoteza1(a,b,c,d) si ipoteza2(a,b,c,d) si ipoteza3(a,b,c,d)

cerintaI(a,b,c):    (non a si non b) => non c
cerintaII(a,b,c):   non(a si b si c)

cerinta(a,b,c): cerintaI(a,b,c) si cerintaII(a,b,c)

Notez astfel cuantificatorii:
	\/ : oricare ar fi
	E  : exista

Avem de demonstrat ca:
\/ a,b,c,d in {false,true} (ipoteza(a,b,c,d) => cerinta(a,b,c)),
	adica:
\/ a in {false,true} \/ b in {false,true} \/ c in {false,true}
\/ d in {false,true} (ipoteza(a,b,c,d) => cerinta(a,b,c)), <=>

non non [\/ a in {false,true} \/ b in {false,true} \/ c in {false,true}
\/ d in {false,true} (ipoteza(a,b,c,d) => cerinta(a,b,c))] <=>

non [E a in {false,true} E b in {false,true} E c in {false,true}
E d in {false,true} non (ipoteza(a,b,c,d) => cerinta(a,b,c))] <=>

non [E a in {false,true} E b in {false,true} E c in {false,true}
E d in {false,true} non (non ipoteza(a,b,c,d) sau cerinta(a,b,c))] <=>

non [E a in {false,true} E b in {false,true} E c in {false,true}
E d in {false,true} (non non ipoteza(a,b,c,d) si non cerinta(a,b,c))] <=>

non [E a in {false,true} E b in {false,true} E c in {false,true}
E d in {false,true} (ipoteza(a,b,c,d) si non cerinta(a,b,c))].

Reprezentam proprietatile a,b,c,d prin variabilele Prolog
_a,_b,_c,respectiv _d. */

ipoteza1(_a,_b,_c,_d) :- implica((_a,_b),xor(_c,_d)).
ipoteza2(_a,_b,_c,_d) :- implica((_b,_c),(_a,_d;not(_a),not(_d))).
ipoteza3(_a,_b,_c,_d) :- implica((not(_a),not(_b)),(not(_c),not(_d))).

ipoteza(_a,_b,_c,_d) :- ipoteza1(_a,_b,_c,_d), ipoteza2(_a,_b,_c,_d),
			ipoteza3(_a,_b,_c,_d).

cerintaI(_a,_b,_c) :- implica((not(_a),not(_b)),not(_c)).
cerintaII(_a,_b,_c) :- not((_a,_b,_c)).

cerinta(_a,_b,_c) :- cerintaI(_a,_b,_c), cerintaII(_a,_b,_c).

demPrinTabelValAdev :- not((member(_a,[false,true]), member(_b,[false,true]),
	member(_c,[false,true]), member(_d,[false,true]),
	write((_a,_b,_c,_d)), nl,
	ipoteza(_a,_b,_c,_d), not(cerinta(_a,_b,_c)))).

/* Interogati:
?- demPrinTabelValAdev.
Demonstratia de mai sus se scrie in acelasi mod daca notam multimile A,B,C,D ca in acel material de seminar, consideram o substanta arbitrara s si notam cu urmatoarele variabile Prolog aceste enunturi:
	_a : s in A
	_b : s in B
	_c : s in C
	_d : s in D
unde, ca mai sus, "in" semnifica "apartine lui". */

/* La grupa 144 am demonstrat pe rand cele doua cerinte, si fara predicatul ipoteza pentru evaluarea conjunctiei celor trei ipoteze: */

demcerintaI :- not((member(_a,[false,true]), member(_b,[false,true]),
	member(_c,[false,true]), member(_d,[false,true]),
	write((_a,_b,_c,_d)), nl, ipoteza1(_a,_b,_c,_d), ipoteza2(_a,_b,_c,_d),
	ipoteza3(_a,_b,_c,_d), not(cerintaI(_a,_b,_c)))).

demcerintaII :- not((member(_a,[false,true]), member(_b,[false,true]),
	member(_c,[false,true]), member(_d,[false,true]),
	write((_a,_b,_c,_d)), nl, ipoteza1(_a,_b,_c,_d), ipoteza2(_a,_b,_c,_d),
	ipoteza3(_a,_b,_c,_d), not(cerintaII(_a,_b,_c)))).

/*Interogati:
?- demcerintaI.
?- demcerintaII.
*/

/* Revenim la cadrul de la inceputul acestei baze de cunostinte:
fie A, B, C multimi arbitrare; fie x element arbitrar.
Notam cu urmatoarele variabile aceste enunturi:
	_a: x in A
	_b: x in B
	_c: x in C
Sa demonstram ca intersectia a doua multimi este inclusa in primul sau termen, adica:
	A^B <= A
Avem de demonstrat ca:
	x in A^B => x in A
adica:
	(x in A si x in B) => x in A
adica:
	(_a si _b) => _a
*/

intersinclItermen(_a,_b) :- implica((_a,_b),_a).

demintersinclItermen :- not((member(_a,[false,true]), member(_b,[false,true]),
	write((_a,_b)), nl, not(intersinclItermen(_a,_b)))).

/* Sa demonstram ca incluziunea nestricta este tranzitiva, adica:
	A<=B<=C => A<=C
adica:
	[(x in A => x in B) si (x in B => x in C)] => (x in A => x in C)
adica:
	[(_a => _b) si (_b => _c)] => (_a => _c)
*/

tranzincl(_a,_b,_c) :- implica((implica(_a,_b),implica(_b,_c)),
			implica(_a,_c)).

demtranzincl :- not((member(_a,[false,true]), member(_b,[false,true]),
	member(_c,[false,true]), write((_a,_b,_c)), nl,
	not(tranzincl(_a,_b,_c)))).

/* La grupa 144 am mai demonstrat si:
comutativitatea intersectiei:
	A^B=B^A
adica:
	x in A^B <=> x in B^A
adica:
	(x in A si x in B) <=> (x in B si x in A)
adica:
	(_a si _b) <=> (_b si _a)
*/

comutinters(_a,_b) :- echiv((_a,_b),(_b,_a)).

demcomutinters :- not((member(_a,[false,true]), member(_b,[false,true]),
	write((_a,_b)), nl, not(comutinters(_a,_b)))).

/*
daca o multime e inclusa in doua multimi, atunci e inclusa in intersectia lor:
	(A<=B si A<=C) => A<=B^C
adica:
	[(x in A => x in B) si (x in A => x in C)] => (x in A => x in B^C)
adica:
[(x in A => x in B) si (x in A => x in C)] => [x in A => (x in B si x in C)]
adica:
[(_a => _b) si (_a => _c)] => [_a => (_b si _c)]
*/

incl2mult(_a,_b,_c) :- implica((implica(_a,_b),implica(_a,_c)),
			implica(_a,(_b,_c))).

demincl2mult :-  not((member(_a,[false,true]), member(_b,[false,true]),
	member(_c,[false,true]), write((_a,_b,_c)), nl,
	not(incl2mult(_a,_b,_c)))).

/* Vom continua in aceasta maniera cu proprietatile operatiilor si relatiilor intre multimi folosite in rezolvarea prin calcul cu multimi a Exercitiului 4 din partea 1 a Seminarului 1 pe care nu le-am demonstrat in Prolog (la grupele 141, 142, 143). */
