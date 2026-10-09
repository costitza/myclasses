:- [c1lmcID1].

/* Aceeasi rugaminte ca pentru baza de cunostinte de la primul curs: pana adaug comentarii pentru semnificatiile tuturor predicatelor urmatoare, vedeti aceste comentarii in bazele de cunostinte de la lectiile seriei 14.

Va amintesc ca acest fisier .pl se incarca in interpretorul Prolog-ului desktop cu interogarea:
?- ['d:/tempwork/c2lmcID4.pl'].
   daca se afla pe drive-ul d:, in folderul tempwork (pentru subfoldere: /.../.../), iar, dupa o actualizare, cu aceeasi interogare, pe care o putem chema folosind tasta sageata in sus,
   sau cu optiunea Consult din meniul File, iar, dupa o actualizare, cu optiunea Reload modified files, tot din meniul File.

conjunctia (si): ,
disjunctia (sau): ;
negatia (non): not
negatia (non): \+

Simbolul neck, semnificand "daca": :- 
devine "daca si numai daca" (ddaca) pentru urmatoarele doua reguli, intrucat:
	prima dintre ele este singura clauza de definitie a predicatului binar implica, asadar implica(P,Q) e satisfacut daca e satisfacut scopul compus "not(P), ! ; Q" (dat de disjunctia dintre conjunctia negatiei lui P cu predicatul predefinit cut (!, care taie backtracking-ul, spunandu-i Prolog-ului sa nu mai dea alte solutii dupa prima solutie) si Q) si numai daca e satisfacut acest membru drept al acestei reguli, pentru ca nu are alte clauze care sa-l defineasca, adica sa-i dea alte cazuri de satisfacere;
	a doua dintre ele este singura clauza de definitie a predicatului binar echiv, asadar echiv(P,Q) e satisfacut daca e satisfacut scopul compus dat de conjunctia "implica(P,Q), implica(Q,P)" si numai daca e satisfacut acest membru drept al acestei reguli, pentru ca nu are alte clauze care sa-l defineasca, adica sa-i dea alte cazuri de satisfacere. */

implica(P,Q) :- not(P), ! ; Q.
echiv(P,Q) :- implica(P,Q), implica(Q,P).
xor(P,Q) :- P,not(Q) ; Q,not(P).

/* Fie A, B, C, D multimi arbitrare, iar x element arbitrar.
Notam, pentru orice multime M, cu:
	x in M <=> x apartine lui M.
Notam reuniunea cu U, intersectia cu ^, diferenta cu \, diferenta simetrica cu /\, produsul cartezian cu x, incluziunea nestricta cu <=, incluziunea stricta cu < si multimea vida cu 0.
Urmatoarele variabile Prolog vor reprezenta aceste enunturi:
	_a: x in A
	_b: x in B
	_c: x in C
	_d: x in D
Notam cu:
	\/ cuantificatorul universal
	E cuantificatorul existential

Renuntam temporar la fixarea lui x.

A=B <=> (\/x)(x in A<=>x in B) <=> (\/_a,_b in {false,true})(_a<=>_b)
 <=> (\/_a in {false,true})(\/_b in {false,true})(_a<=>_b)
	<=> echiv(_a,_b) intoarce true pentru orice pereche de valori booleene (i.e. valori de adevar) pentru variabilele _a,_b
	<=> non non [(\/x)(x in A<=>x in B)]
	<=> non (E x)[non(x in A<=>x in B)]
 <=> non non [(\/_a in {false,true})(\/_b in {false,true})(_a<=>_b)]
 <=> non (E_a in {false,true})(E_b in {false,true})[non(_a<=>_b)]
	<=> nu exista pereche de valori booleene pentru variabilele _a,_b pentru care echiv(_a,_b) sa nu intoarca true
	<=> nu exista pereche de valori booleene pentru variabilele _a,_b pentru care not(echiv(_a,_b)) sa intoarca true 

A<=B <=> (\/x)(x in A=>x in B) <=> (\/_a,_b in {false,true})(_a=>_b)
	<=> implica(_a,_b) intoarce true pentru orice pereche de valori booleene pentru variabilele _a,_b
	<=> nu exista pereche de valori booleene pentru variabilele _a,_b pentru care not(implica(_a,_b)) sa intoarca true 

A<B <=> (A<=B si not(A=B))
	<=> (implica(_a,_b), not(echiv(_a,_b))) intoarce true pentru orice pereche de valori booleene pentru variabilele _a,_b
	<=> nu exista pereche de valori booleene pentru variabilele _a,_b pentru care not((implica(_a,_b), not(echiv(_a,_b)))) sa intoarca true 

Pentru cele ce urmeaza, avem din nou x arbitrar, fixat.

x in AUB <=> (x in A sau x in B) <=> (_a sau _b) <=>
	_a;_b intoarce true
x in A^B <=> (x in A si x in B) <=> (_a si _b) <=>
	_a,_b intoarce true
x in A\B <=> (x in A si non(x in B)) <=> _a,not(_b) intoarce true
x in A/\B <=> x in (A\B)U(B\A) <=> (x in A\B sau x in B\A)
 <=> [(x in A si non(x in B)) sau (x in B si non(x in A))]
	<=> _a,not(_b);_b,not(_a) intoarce true
	<=> xor(_a,_b) intoarce true
*/

% A=B <=> (A<=B si B<=A)

egaledublaincl(_a,_b) :- echiv(echiv(_a,_b),
	(implica(_a,_b),implica(_b,_a))).

/* Interogati:
?- member(_a,[false,true]), member(_b,[false,true]), egaledublaincl(_a,_b).
   si dati ;/Next pentru a obtine toate solutiile.
Interogati:
?- fail.
?- member(_a,[false,true]), member(_b,[false,true]), egaledublaincl(_a,_b), write((_a,_b)), nl, fail.
?- not((member(_a,[false,true]), member(_b,[false,true]), egaledublaincl(_a,_b), write((_a,_b)), nl, fail)).
?- not((member(_a,[false,true]), member(_b,[false,true]), (_a;_b), write((_a,_b)), nl, fail)).
?- not((member(_a,[false,true]), member(_b,[false,true]), write((_a,_b)), nl, not(egaledublaincl(_a,_b)))).
*/

demegaledublaincl :- not((member(_a,[false,true]), 
	member(_b,[false,true]), write((_a,_b)), nl,
	not(egaledublaincl(_a,_b)))).

% (A<=B si C<=D) => A^C<=B^D

compinclinters(_a,_b,_c,_d) :- 
	implica((implica(_a,_b),implica(_c,_d)),
	implica((_a,_c), (_b,_d))).

demcompinclinters :- not((member(_a,[false,true]), 
	member(_b,[false,true]), member(_c,[false,true]), 
	member(_d,[false,true]), write((_a,_b,_c,_d)), nl,
	not(compinclinters(_a,_b,_c,_d)))).

listaBool([]).
listaBool([H|T]) :- member(H,[false,true]), listaBool(T).

demIIegaledublaincl :- not((listaBool([_a,_b]), write((_a,_b)), nl,
	not(egaledublaincl(_a,_b)))).

demIIcompinclinters :- not((listaBool([_a,_b,_c,_d]),
	write((_a,_b,_c,_d)), nl,
	not(compinclinters(_a,_b,_c,_d)))).

listaValBool(L) :- listaBool(L), write(L), nl.

demIIIegaledublaincl :- not((listaValBool([_a,_b]),
	not(egaledublaincl(_a,_b)))).

demIIIcompinclinters :- not((listaValBool([_a,_b,_c,_d]),
	not(compinclinters(_a,_b,_c,_d)))).

afisLista([]).
afisLista([H|T]) :- write(H), (T=[], ! ; write(',')), afisLista(T).

listaValoriBool(L) :- listaBool(L), afisLista(L), nl.

demIVegaledublaincl :- not((listaValoriBool([_a,_b]),
	not(egaledublaincl(_a,_b)))).

demIVcompinclinters :- not((listaValoriBool([_a,_b,_c,_d]),
	not(compinclinters(_a,_b,_c,_d)))).

% din temele colective: A<B<=C => A<C

/* Sa demonstram ca: A<=B<C => A<C,
adica: (A<=B si B<C) => A<C
*/

inclinclstr(_a,_b,_c) :- implica((implica(_a,_b), 
	(implica(_b,_c), not(echiv(_b,_c)))),
	(implica(_a,_c), not(echiv(_a,_c)))).

deminclinclstr :- not((listaValBool([_a,_b,_c]),
	not(inclinclstr(_a,_b,_c)))).

/* Pentru orice p,q,r in {false,true}:
[p si (q si r)] <=> [(p si q) si r] <=> (p si q si r)
   Asadar, pentru orice x:
	[_a si (_b si _c)] <=> [(_a si _b) si _c],
adica:
   [x in A si (x in B si x in C)] <=> [(x in A si x in B) si x in C],
adica:
	(x in A si x in B^C) <=> (x in A^B si x in C),
adica:
	x in A^(B^C) <=> x in (A^B)^C
adica: A^(B^C)=(A^B)^C (=A^B^C).
   La fel ca mai sus, proprietatea ca:
   pentru orice p,q,r in {false,true}:
[p sau (q sau r)] <=> [(p sau q) sau r] <=> (p sau q sau r)
   aplicata lui (_a,_b,_c) in loc de (p,q,r),
adica pentru enunturile p,q,r inlocuite cu: x in A, x in B, respectiv x in C, devine:
	AU(BUC)=(AUB)UC (=AUBUC).
*/

/* Principiul reducerii la absurd:
	(p => q) <=> (non q => non p)
*/

princredabs(P,Q) :- echiv(implica(P,Q), implica(not(Q),not(P))).

demprincredabs :- not((listaValBool([P,Q]), not(princredabs(P,Q)))).

% A<=B <=> A^B=A

intersecmmica(_a,_b) :- echiv(implica(_a,_b), echiv((_a,_b),_a)).

demintersecmmica :- not((listaValBool([_a,_b]),
	not(intersecmmica(_a,_b)))).

/* 
Pentru orice multimi M si T cu M<=T, notam cu -M complementara lui M fata de T:
	-M = T\M
Fie T o multime cu A<=T si B<=T.
Presupunem ca x in T. Atunci, pentru orice M<=T:
	x in -M <=> x in T\M <=> [x in T si non(x in M)]
	 <=> [true si non(x in M)] <=> non(x in M)
Sa demonstram ca:
	(AUB=T si A^B=0) <=> A=-B <=> B=-A
Adica, pentru orice x in T:
[(x in AUB <=> x in T) si (x in A^B <=> x in 0)]
 <=> (x in A <=> x in -B) <=> (x in B <=> x in -A),
adica:
[((x in A sau x in B) <=> true) si ((x in A si x in B) <=> false)]
 <=> [x in A <=> non(x in B)] <=> [x in B <=> non(x in A)],
adica:
[[((x in A sau x in B) <=> true) si ((x in A si x in B) <=> false)]
 	<=> [x in A <=> non(x in B)]]
 si [[x in A <=> non(x in B)] <=> [x in B <=> non(x in A)]]
*/

bipartitie(_a,_b) :- echiv((echiv(_a;_b,true), echiv((_a,_b),false)),
		echiv(_a,not(_b))),
	echiv(echiv(_a,not(_b)), echiv(_b,not(_a))).

dembipartitie :- not((listaValBool([_a,_b]),
	not(bipartitie(_a,_b)))).

% generarea sublistelor unei liste:

sublista([],_).
sublista([H|T],[H|L]) :- sublista(T,L).
sublista([H|T],[_|L]) :- sublista([H|T],L).

sublistele(L,LS) :- setof(S, sublista(S,L), LS).

% generarea partilor (i.e. submultimilor) unei multimi:

parte(S,M) :- eldup(M,Mult), sublista(S,Mult).

partile(M,PM) :- eldup(M,Mult), sublistele(Mult,PM).

parti(M,PM) :- setof(S, parte(S,M), PM).

% afisarea unei liste cu fiecare element pe o noua linie:

afislista([]).
afislista([H|T]) :- write(H), nl, afislista(T).

/* Orice f:A->B se poate identifica cu graficul ei:
	f = {(a,f(a)) | a in A} <= AxB"
   Predicat pentru generarea functiilor F de la multimea A la multimea B:
   functie(-F,+A,+B)=true <=> F:A->B, identificata cu graficul ei
F : {H} U T -> B <=> F = {(a,F(a)) | a in {H} U T}
 <=> F = {(H,F(H))} U {(a,F(a)) | a in T}, unde:
	{(a,F(a)) | a in T} : T->B
*/

functie([],[],_).
functie([(H,FH)|L],[H|T],B) :- member(FH,B), functie(L,T,B).

functiile(A,B,LF) :- setof(F, functie(F,A,B), LF), !.
functiile(_,_,[]).

/* Interogati:
?- functiile([],[],Care), length(Care,Cate).
?- functiile([],[1],Care), length(Care,Cate).
?- functiile([1,2],[],Care), length(Care,Cate).
?- functiile([1,2,3],[a,b],Care), afislista(Care), length(Care,Cate).
?- functiile([a,b],[1,2,3],Care), afislista(Care), length(Care,Cate).
*/

afislist([]).
afislist([H|T]) :- write(H), tab(1), afislist(T).

listimag([],[]).
listimag([(_,FH)|L],[FH|T]) :- listimag(L,T).

afisfct(F) :- write('f(x)|'), listimag(F,Im), afislist(Im).

afisfunctii([]).
afisfunctii([F|LF]) :- afisfct(F), nl, afisfunctii(LF).

afislinie(0) :- !.
afislinie(N) :- write('_'), K is N-1, afislinie(K).

afislistafct(LF,A) :- write(' x |'), afislist(A), nl,
	length(A,Nr), N is 2*Nr+3, afislinie(N), nl,
	afisfunctii(LF).

/* Interogati:
?- functiile([1,2,3],[a,b],Care), afislistafct(Care,[1,2,3]), length(Care,Cate).
?- functiile([a,b],[1,2,3],Care), afislistafct(Care,[a,b]), length(Care,Cate).
*/

% generarea bijectiilor de la A la B:

prodscal([],[],[]).
prodscal([H|T],[K|U],[(H,K)|L]) :- prodscal(T,U,L).

bijectie(F,A,B) :- permutare(B,P), prodscal(A,P,F).

bijectiile(A,B,LF) :- setof(F, bijectie(F,A,B), LF), !.
bijectiile(_,_,[]).

/* Interogati:
?- bijectie(F,[1,2,3],[a,b]).
?- bijectie(F,[1,2],[a,b,c]).
?- bijectie(F,[1,2,3],[a,b,c]).
?- bijectiile([1,2,3],[a,b,c],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
*/

afisbij(P) :- write('f(x)|'), afislist(P).

afisbijectii([]).
afisbijectii([P|LP]) :- afisbij(P), nl, afisbijectii(LP).

afislistabij(LF,A) :- write(' x |'), afislist(A), nl,
	length(A,Nr), N is Nr+3, afislinie(N), nl,
	afisbijectii(LF).

afislistabijectii(A,B) :- listapermutari(B,LP), afislistabij(LP,A).

/* Interogati:
?- afislistabijectii([1,2,3],[a,b,c]).
*/

% generarea relatiilor binare de la A la B:

relbin(R,A,B) :- prodcart(A,B,AxB), sublista(R,AxB).

relatiibinare(A,B,LR) :- setof(R, relbin(R,A,B), LR).

/* Interogati:
?- relbin(Cine,[1,2,3],[a,b]).
?- relatiibinare([1,2,3],[a,b],Care), afislista(Care), length(Care,Cate).

Notez cu =/= nonegalitatea:

F : A -o-> B <=> F <= AxB a.i.:
	(\/ X in A)(\/ B1,B2 in B)[(X F B1 si X F B2) => B1=B2],
adica:
	(\/ X in A)[non[(E B1,B2 in B)(B1=/=B2 si X F B1 si X F B2)]]
adica:
	non non[(\/ X in A)[non[(E B1,B2 in B)(B1=/=B2 si X F B1 si X F B2)]]]
adica:
	non [(E X in A)[non non[(E B1,B2 in B)(B1=/=B2 si X F B1 si X F B2)]]]
adica:
	non [(E X in A)(E B1,B2 in B)(B1=/=B2 si X F B1 si X F B2)]
adica, in ipoteza ca F <= AxB:
	non [(E X in A)(E B1,B2)(X F B1 si X F B2 si B1=/=B2)]

functionala(F,A)
 <=> non [(E X in A)(E B1,B2)(X F B1 si X F B2 si B1=/=B2)]
*/

/* generarea functiilor partiale (i.e. a relatiilor binare functionale) de la A la B: */

functionala(F) :- not((member((X,B1),F), member((X,B2),F), B1\=B2)).

fctpart(F,A,B) :- relbin(F,A,B), functionala(F).

functiilepartiale(A,B,LF) :- setof(F, fctpart(F,A,B), LF), !.
functiilepartiale(_,_,[]).

/* R <= AxB e totala <=> (\/ X in A)(E Y in B)(X R Y)
	 <=> (\/ X in A)(E Y)(X R Y)
totala(R,A) <=> (\/ X in A)(E Y)(X R Y)
	<=> non non[(\/ X in A)(E Y)(X R Y)]
	<=> non [(E X in A)(\/ Y)(non(X R Y))]
	<=> non [(E X in A)(\/ Y)(non(X R Y))]
	<=> non [(E X in A)[non non((\/ Y)(non(X R Y)))]]
	<=> non [(E X in A)[non (E Y)(non non(X R Y)))]]
	<=> non [(E X in A)[non (E Y)(X R Y))]]
*/

% generarea relatiilor binare totale de la A la B:

totala(R,A) :- not((member(X,A), not(member((X,_),R)))).

relbintot(R,A,B) :- relbin(R,A,B), totala(R,A).

relatiibinaretot(A,B,LF) :- setof(F, relbintot(F,A,B), LF), !.
relatiibinaretot(_,_,[]).

/* generarea relatiilor binare functionale totale, i.e. a functiilor, de la A la B, mai putin avantajos decat mai sus: */

relbinfcttot(F,A,B) :- fctpart(F,A,B), totala(F,A).

relatiibinarefcttot(A,B,LF) :- setof(F, relbinfcttot(F,A,B), LF), !.
relatiibinarefcttot(_,_,[]).

/* Interogati:
?- functiilepartiale([a,b,c],[1,2],Care), afislista(Care), length(Care,Cate).
?- relatiibinaretot([a,b,c],[1,2],Care), afislista(Care), length(Care,Cate).
?- relatiibinarefcttot([a,b,c],[1,2],Care), afislista(Care), length(Care,Cate).
?- relatiibinarefcttot([a,b,c],[1,2],RelBinFctTot), length(RelBinFctTot,CateRelBinFctTot), functiile([a,b,c],[1,2],Fct), length(Fct,CateFct), egaldemult(RelBinFctTot,Fct).
?- functiilepartiale([a,b],[1,2,3],Care), afislista(Care), length(Care,Cate).
?- relatiibinaretot([a,b],[1,2,3],Care), afislista(Care), length(Care,Cate).

Daca F:A->B, i.e. F = {(a,F(a)) | a in A} <= AxB, atunci:
	not((member((A1,Y),F), member((A2,Y),F), A1\=A2))
semnifica:
	non[(E A1,A2,Y)(A1 F Y si A2 F Y si A1=/=A2)]
adica:
	non[(E A1,A2,Y)(F(A1)=Y si F(A2)=Y si A1=/=A2)]
adica:
	non[(E A1,A2)(F(A1)=F(A2) si A1=/=A2)]
adica:
	(\/ A1,A2)[non(F(A1)=F(A2) si A1=/=A2)]
adica:
	(\/ A1,A2)[non(F(A1)=F(A2)) sau non(A1=/=A2)]
adica:
	(\/ A1,A2)[non(F(A1)=F(A2)) sau non non(A1=A2)]
adica:
	(\/ A1,A2)[non(F(A1)=F(A2)) sau A1=A2]
adica:
	(\/ A1,A2)[non(F(A1)=F(A2)) sau A1=A2]
adica:
	(\/ A1,A2)(F(A1)=F(A2) => A1=A2)
adica F e injectiva;
	iar: not((member(Y,B), not(member((_,Y),R))))
semnifica:
	non(E Y in B) [non(E X in A) (X F Y)]
adica:
	(\/ Y in B) [non non (E X in A) (X F Y)]
adica:
	(\/ Y in B) (E X in A) (X F Y)
adica:
	(\/ Y in B) (E X in A) (F(X)=Y)
*/

% testarea injectivitatii unei relatii binare:

inj(R) :- not((member((A1,Y),R), member((A2,Y),R), A1\=A2)).

% testarea surjectivitatii unei relatii binare:

surj(R,B) :- not((member(Y,B), not(member((_,Y),R)))).

% generarea functiilor injective de la A la B:

fctinj(F,A,B) :- functie(F,A,B), inj(F).

functiiinj(A,B,LF) :- setof(F, fctinj(F,A,B), LF), !.
functiiinj(_,_,[]).

% generarea functiilor surjective de la A la B:

fctsurj(F,A,B) :- functie(F,A,B), surj(F,B).

functiisurj(A,B,LF) :- setof(F, fctsurj(F,A,B), LF), !.
functiisurj(_,_,[]).

/* Interogati:
?- bijectiile([1,2,3],[a,b,c],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiiinj([1,2,3],[a,b,c],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiisurj([1,2,3],[a,b,c],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiiinj([1,2],[a,b,c],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiisurj([1,2,3],[a,b],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiisurj([1,2,3,4],[a,b,c],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiiinj([1,2,3,4],[a,b,c],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiisurj([1,2,3],[a,b,c,d],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
?- functiiinj([1,2,3],[a,b,c,d],Care), afislista(Care), length(Care,Cate), nl, afislistafct(Care,[1,2,3]).
*/

% inversa unei relatii binare, calculata in doua moduri:

invrel(R,I) :- setof((Y,X), member((X,Y),R), I), !.
invrel(_,[]).

inversarel([],[]).
inversarel([(X,Y)|T],[(Y,X)|U]) :- inversarel(T,U).

% diagonala unei multimi:

diag(A,D) :- setof((X,X), member(X,A), D), !.
diag(_,[]).

% compunerea de relatii binare:

comp(S,R,SoR) :- setof((X,Z), 
	Y^(member((X,Y),R), member((Y,Z),S)), SoR), !.
comp(_,_,[]).

/* Interogati:
?- comp([(b,d),(c,d)],[(a,b),(a,c)],SoR).
?- comp([(a,b),(a,c)],[(b,d),(c,d)],RoS).
*/

% puterea a N-a a unei relatii binare R pe o multime A: R <= AxA:

putere(_,A,0,D) :- diag(A,D), !.
putere(R,_,N,RlaN) :- putere(R,N,RlaN).

putere(R,1,R).
putere(R,N,RlaN) :- N>1, K is N-1, putere(R,K,RlaK),
			comp(RlaK,R,RlaN).

/* Interogati:
?- putere([(a,b),(b,c),(c,d)],[a,b,c,d],0,Care).
?- putere([(a,b),(b,c),(c,d)],[a,b,c,d],2,Care).
?- putere([(a,b),(b,c),(c,d)],0,Care).
?- putere([(a,b),(b,c),(c,d)],1,Care).
?- putere([(a,b),(b,c),(c,d)],2,Care).
?- putere([(a,b),(b,c),(c,d)],3,Care).
?- putere([(a,b),(b,c),(c,d)],4,Care).
*/

% predicat care genereaza relatiile binare pe A:

relbinpe(R,A) :- relbin(R,A,A).

% Pentru relatii binare R pe o multime A:

% testarea reflexivitatii:

refl(R,A) :- not((member(X,A), not(member((X,X),R)))).

% testarea ireflexivitatii:

irefl(R) :- not(member((X,X),R)).

% testarea simetriei:

sim(R) :- not((member((X,Y),R), not(member((Y,X),R)))).

% testarea antisimetriei:

antisim(R) :- not((member((X,Y),R), member((Y,X),R), X\=Y)).

% testarea asimetriei:

asim(R) :- not((member((X,Y),R), member((Y,X),R))).

% testarea tranzitivitatii:

tranz(R) :- not((member((X,Y),R), member((Y,Z),R),
	not(member((X,Z),R)))).

% testarea totalitatii in sensul de la relatii binare pe o multime:

tot(R,A) :- not((member(X,A), member(Y,A), X\=Y,
	not(member((X,Y),R);member((Y,X),R)))).

% testarea completitudinii:

completa(R,A) :- not((member(X,A), member(Y,A),
	not(member((X,Y),R);member((Y,X),R)))).

% testarea proprietatii de a fi (relatie de) preordine:

preord(R,A) :- refl(R,A), tranz(R).

% generarea preordinilor pe multimea A:

relpreord(R,A) :- relbinpe(R,A), preord(R,A).

relatiipreord(A,LR) :- setof(R, relpreord(R,A), LR).

% testarea proprietatii de a fi (relatie de) echivalenta:

eq(R,A) :- preord(R,A), sim(R).

% generarea echivalentelor pe multimea A:

releq(R,A) :- relpreord(R,A), sim(R).

relatiieq(A,LR) :- setof(R, releq(R,A), LR).

% testarea proprietatii de a fi (relatie de) ordine:

ord(R,A) :- preord(R,A), antisim(R).

% generarea ordinilor pe multimea A:

relord(R,A) :- relpreord(R,A), antisim(R).

relatiiord(A,LR) :- setof(R, relord(R,A), LR).

% testarea proprietatii de a fi (relatie de) ordine stricta:

ordstr(R) :- tranz(R), asim(R).

% generarea ordinilor stricte pe multimea A:

relordstr(R,A) :- relbinpe(R,A), ordstr(R).

relatiiordstr(A,LR) :- setof(R, relordstr(R,A), LR).

% tot testarea proprietatii de a fi (relatie de) ordine stricta:

ordstricta(R) :- tranz(R), irefl(R).

% tot generarea ordinilor stricte pe multimea A:

relordstricta(R,A) :- relbinpe(R,A), ordstricta(R).

relatiiordstricta(A,LR) :- setof(R, relordstricta(R,A), LR).

/* Interogati:
?- relatiipreord([a,b,c],Care), afislista(Care), length(Care,Cate).
?- relatiieq([a,b,c],Care), afislista(Care), length(Care,Cate).
?- relatiieq([a,b,c,d],Care), afislista(Care), length(Care,Cate).
?- relatiiord([a,b,c],Care), afislista(Care), length(Care,Cate).
?- relatiiordstr([a,b,c],Care), afislista(Care), length(Care,Cate).
?- relatiiordstricta([a,b,c],Care), afislista(Care), length(Care,Cate).
*/

% partitia P asociata unei relatii de echivalenta R pe multimea A:

clasa(X,R,C) :- setof(Y, member((X,Y),R), C).

parteq(R,A,P) :- setof(C, X^(member(X,A), clasa(X,R,C)), P).

% partitiile multimii A, generate folosind echivalentele pe A:

partitii(A,PartA) :- setof(P, R^(releq(R,A), parteq(R,A,P)), PartA).

/* Interogati:
?- partitii([a,b,c,d],Care), afislista(Care), length(Care,Cate).

Part({X}) = {{{X}}}.
Part({H} U T) = {{{H}} U P | P in Part(T)} U 
	{{C U {H}} U (P\{C}) | P in Part(T), C in P}
*/

% diferenta A\B a doua multimi A si B (n-am mai folosit-o mai jos):

dif(A,B,AminusB) :- setof(X,
	(member(X,A), not(member(X,B))), AminusB), !.
dif(_,_,[]).

/* generarea (directa, folosind recurenta de mai sus, a) partitiilor multimii A: */

partitie([[X]],[X]) :- !.
partitie(P,[H|T]) :- partitie(Q,T), (P = [[H] | Q] ;
	member(C,Q), sterge(C,Q,R), P = [[H|C] | R]).

partitiile(A,PartA) :- setof(P, partitie(P,A), PartA).

/* Interogati:
?- partitiile([a,b,c,d],Care), afislista(Care), length(Care,Cate).
*/

% relatia de echivalenta asociata unei partitii:

eqpart([],[]).
eqpart([C|LC],R) :- prodcart(C,C,Cpatrat), eqpart(LC,S),
	reun(Cpatrat,S,R).

% echivalentele pe A, generate folosind partitiile lui A:

relatiileeq(A,LR) :- setof(R, P^(partitie(P,A), eqpart(P,R)), LR).

/* Interogati:
?- relatiileeq([a,b,c,d],Care), afislista(Care), length(Care,Cate).
*/


