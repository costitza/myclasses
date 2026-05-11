:- [l4lmc1].

% inchiderea reflexiva a unei relatii binare R pe o multime A:

inchrefl(R,A,InchReflR) :- diag(A,D), reun(D,R,InchReflR).

% inchiderea simetrica a unei relatii binare R pe o multime:

inchsim(R,InchSimR) :- invrel(R,RlaMinus1),
	reun(R,RlaMinus1,InchSimR).

% inchiderea tranzitiva a unei relatii binare R pe o multime:

inchtranz(R,InchTranzR) :- auxinchtranz(R,R,InchTranzR).

/* La fiecare pas, urmatorul predicat are argumentele:
	auxinchtranz(R,Tk(R),T(R))
unde:
-> R este o relatie binara pe o multime;
-> {Tk(R) | k in N*}, unde N este multimea numerelor naturale, este sirul de relatii binare definit recursiv astfel:
	T1(R) = R,
	pentru fiecare k in N*, T(k+1)R = R U (R o Tk(R)),
astfel ca (a se vedea tabla Laboratorului 5 sau Exercitiul 4 din Partea a II-a a Seminarului 3), pentru orice n in N*:
	Tn(R) = R U R^2 U R^3 U ... U R^n,
unde R^n = R o R o ... o R, unde R apare de n ori in aceasta compunere;
-> T(R) este inchiderea tranzitiva a lui R, care va fi calculata la ultimul pas, astfel:
	cand Tk(R) devine tranzitiva, T(R) := Tk(R), adica:
variabila care tine locul lui T(R) este instantiata cu valoarea curenta a lui Tk(R). */

auxinchtranz(_,T,T) :- tranz(T), !.
auxinchtranz(R,T,InchTranzR) :- comp(R,T,RoT), reun(R,RoT,U),
	auxinchtranz(R,U,InchTranzR).

% varianta cu calcul redundant de puteri pentru inchiderea tranzitiva:

inchidtranz(R,Inch) :- auxinchidtranz(R,R,1,Inch).

/* auxinchidtranz(R,TK(R),K,T(R)) are argumentul K in plus fata de auxinchtranz: */

auxinchidtranz(_,T,_,T) :- tranz(T), !.
auxinchidtranz(R,T,N,Inch) :- SN is N+1, putere(R,SN,P), reun(T,P,U),
	auxinchidtranz(R,U,SN,Inch).

% preordinea generata de o relatie binara R pe o multime A:

preordgen(R,A,Preord) :- inchtranz(R,InchTranzR),
	inchrefl(InchTranzR,A,Preord).

% echivalenta generata de o relatie binara R pe o multime A:

eqgen(R,A,Eq) :- inchsim(R,InchSimR), inchrefl(InchSimR,A,Q),
	inchtranz(Q,Eq).

/* Interogati:
?- inchrefl([(a,b),(b,c),(c,d)],[a,b,c,d],Inch).
?- inchsim([(a,b),(b,c),(c,d)],Inch).
?- inchtranz([(a,b),(b,c),(c,d)],Inch).
?- preordgen([(a,b),(b,c),(c,d)],[a,b,c,d],Inch), write(Inch).
?- eqgen([(a,b),(b,c),(c,d)],[a,b,c,d],Eq), write(Eq), parteq(Eq,[a,b,c,d],Part).
?- eqgen([(a,b),(c,d)],[a,b,c,d],Eq), write(Eq), parteq(Eq,[a,b,c,d],Part).
?- eqgen([(a,b),(c,d)],[a,b,c,d,e],Eq), write(Eq), parteq(Eq,[a,b,c,d],Part).
?- eqgen([(a,b),(b,c),(c,d)],[a,b,c,d,e],Eq), write(Eq), parteq(Eq,[a,b,c,d,e],Part).
*/

% ordinea stricta OrdStr asociata unei ordini Ord:

ordstrdinord(Ord,OrdStr) :-
	setof((X,Y), (member((X,Y),Ord), X\=Y), OrdStr), !.
ordstrdinord(_,[]).

% ordinea Ord asociata unei ordini stricte OrdStr pe o multime A:

orddinordstr(OrdStr,A,Ord) :- inchrefl(OrdStr,A,Ord).

% relatia de succesiune Succ asociata unei ordini stricte OrdStr:

succdinordstr(OrdStr,Succ) :- setof((X,Y), (member((X,Y),OrdStr), 		not((member((X,Z),OrdStr), member((Z,Y),OrdStr)))), Succ), !.
succdinordstr(_,[]).

% relatia de succesiune Succ asociata unei ordini Ord:

succdinord(Ord,Succ) :- ordstrdinord(Ord,OrdStr),
	succdinordstr(OrdStr,Succ).

/* afisarea unei liste de ordini impreuna cu cardinalele lor si relatiile de succesiune asociate lor: */

afisListaOrd([]).
afisListaOrd([H|T]) :- succdinord(H,Succ), write(H),
	length(H,CardH), write(' de cardinal '), write(CardH), 
	write(', cu succesiunea '), write(Succ), nl, afisListaOrd(T).

/* determinarea multimii OrdA a ordinilor pe multimea A, urmata de afisarea acesteia cu predicatul anterior, alaturi de cardinalul ei:*/

ordinisisucc(A,OrdA) :- relatiiord(A,OrdA), afisListaOrd(OrdA),
	length(OrdA,NrOrdA), write(NrOrdA),
	write(' ordini pe multimea '), write(A).

/* afisarea unei liste de ordini alaturi de mentiunea daca sunt ordini totale, cardinalele lor si relatiile de succesiune asociate lor: */

afisListaRelord([],_).
afisListaRelord([H|T],A) :- succdinord(H,Succ), write(H),
	(not(tot(H,A)), ! ; write(' ordine totala')),
	length(H,CardH), write(' de cardinal '), write(CardH), 
   write(', cu succesiunea '), write(Succ), nl, afisListaRelord(T,A).

/* determinarea multimii OrdA a ordinilor pe multimea A, urmata de afisarea acesteia cu predicatul anterior, alaturi de cardinalul ei:*/

ordinicusucc(A,OrdA) :- relatiiord(A,OrdA), afisListaRelord(OrdA,A),
	length(OrdA,NrOrdA), write(NrOrdA),
	write(' ordini pe multimea '), write(A).

/* Interogati:
?- ordinisisucc([a,b,c],OrdA).
?- ordinicusucc([a,b,c],OrdA).
*/

/* ordinea stricta OrdStr asociata unei relatii de succesiune Succ pe o multime finita sau, mai general, unei relatii de succesiune finite: */

ordstrdinsucc(Succ,OrdStr) :- inchtranz(Succ,OrdStr).

/* ordinea Ord asociata unei relatii de succesiune Succ pe o multime finita A: */ 

orddinsucc(Succ,A,Ord) :- ordstrdinsucc(Succ,OrdStr), 
	inchrefl(OrdStr,A,Ord).

/* Interogati:
?- ordstrdinsucc([(a,b),(a,c)],OrdStr).
?- ordstrdinsucc([(a,b),(b,c)],OrdStr).
?- orddinsucc([(a,b),(a,c)],[a,b,c],Ord).
?- orddinsucc([(a,b),(b,c)],[a,b,c],Ord).
?- ordstrdinsucc([(a,b),(a,c)],OrdStr), succdinordstr(OrdStr,Succ), egaldemult([(a,b),(a,c)],Succ).
?- ordstrdinsucc([(a,b),(b,c)],OrdStr), succdinordstr(OrdStr,Succ), egaldemult([(a,b),(b,c)],Succ).
?- orddinsucc([(a,b),(a,c)],[a,b,c],Ord), succdinord(Ord,Succ), egaldemult([(a,b),(a,c)],Succ).
?- orddinsucc([(a,b),(b,c)],[a,b,c],Ord), succdinord(Ord,Succ), egaldemult([(a,b),(b,c)],Succ).
Sa construim poseturi cu predicate de forma:
	numePoset(-MultimeElemente,-Ordine)
din multimile lor subiacente MultimeElemente si relatiile lor de succesiune, folosind predicatul orddinsucc de mai sus, cu cate o singura regula, in membrul drept al careia, in varianta folosita mai jos, MultimeElemente se va instantia printr-o simpla unificare. O alta varianta este sa instantiem MultimeElemente chiar in membrul stang al regulii; de exemplu, pentru definirea lantului cu (exact) 2 elemente, putem proceda astfel:
l2([0,1],OrdL2) :- orddinsucc([(0,1)],[0,1],OrdL2).
*/

% lantul cu 2 elemente:

l2(L2,OrdL2) :- L2=[0,1], orddinsucc([(0,1)],L2,OrdL2).

% rombul, i.e. patratul lantului cu 2 elemente:

romb(R,OrdR) :- R=[0,a,b,1],
	orddinsucc([(0,a),(0,b),(a,1),(b,1)],R,OrdR). 

/* verificarea pastrarii ordinii de catre functia F, mai precis a faptului ca F duce ordinea OrdP (de pe domeniul sau) in ordinea OrdQ (de pe codomeniul sau): */

cresc(F,OrdP,OrdQ) :- not((member((X,Y),OrdP),
	member((X,FX),F),member((Y,FY),F), not(member((FX,FY),OrdQ)))).

/* generarea functiilor izotone (i.e. crescatoare) F de la posetul (P,OrdP) la posetul (Q,OrdQ), prin selectarea dintre functiile F:P->Q generate cu predicatul functie pe cele care satisfac predicatul anterior: */

fctcresc(F,P,OrdP,Q,OrdQ) :- functie(F,P,Q), cresc(F,OrdP,OrdQ).

/* lista LF a functiilor izotone de la posetul (P,OrdP) la posetul (Q,OrdQ): */

functiicresc(P,OrdP,Q,OrdQ,LF) :- 
	setof(F, fctcresc(F,P,OrdP,Q,OrdQ), LF), !.
functiicresc(_,_,_,_,[]).

% suma ordinala (L2xL2)+L2 din exercitiul/pg.8/Partea 1/Seminar 4:

posetA(A,OrdA) :- A=[0,a,b,c,1],
	orddinsucc([(0,a),(0,b),(a,c),(b,c),(c,1)],A,OrdA).

/* posetul de cardinal 3 cu maxim si doua elemente minimale distincte din exercitiul/pg.8/Partea 1/Seminar 4: */

posetB(B,OrdB) :- B=[x,y,1], orddinsucc([(x,1),(y,1)],B,OrdB).

/* lista LF a functiilor izotone injective de la posetul (P,OrdP) la posetul (Q,OrdQ): */

functiicrescinj(P,OrdP,Q,OrdQ,LF) :- 
	setof(F, (fctcresc(F,P,OrdP,Q,OrdQ), inj(F)), LF), !.
functiicrescinj(_,_,_,_,[]).

/* lista LF a functiilor izotone surjective de la posetul (P,OrdP) la posetul (Q,OrdQ): */

functiicrescsurj(P,OrdP,Q,OrdQ,LF) :- 
	setof(F, (fctcresc(F,P,OrdP,Q,OrdQ), surj(F,Q)), LF), !.
functiicrescsurj(_,_,_,_,[]).

/* Interogati:
?- romb(P,OrdP), l2(Q,OrdQ), functiicresc(P,OrdP,Q,OrdQ,LF), afislista(LF), length(LF,Cate).
?- romb(P,OrdP), l2(Q,OrdQ), functiicresc(P,OrdP,Q,OrdQ,LF), afislistafct(LF,P), length(LF,Cate).
?- posetA(P,OrdP), posetB(Q,OrdQ), functiiinj(P,Q,LF), functiicrescinj(P,OrdP,Q,OrdQ,LFinj), functiicrescsurj(P,OrdP,Q,OrdQ,LFsurj).
?- posetA(P,OrdP), posetB(Q,OrdQ), functiisurj(P,Q,LF), afislistafct(LF,P), length(LF,Cate).
*/

/* Ca explicatie pentru cazurile mai generale de functionare a predicatului urmator, mentionate de mai jos, interogati:
?- romb(P,OrdP), prodcart([a,b],[a,b],Spatrat), inters(OrdP,Spatrat,Ord), reun(Ord,[traznaie,altatraznaie],ORD), elemminimal(X,[a,b],ORD).
   Dar, in principiu, nu vom folosi predicatul urmator, precum si predicatele care il succeda, decat in primele doua forme mentionate mai jos, adica sub forma:
-> generarea elementelor minimale X ale posetului (S,Ord)
-> sau generarea elementelor minimale X ale submultimii S a multimii suport P a posetului (P,Ord),
adica pentru o multime S si o ordine Ord care include o ordine pe S.
   Generarea elementelor minimale X ale posetului (S,Ord)
   sau, mai general, ale multimii S intr-un poset (P,Ord) cu S<=P
   sau, si mai general, ale multimii S intr-un poset (P,OrdP) cu S<=P si OrdP^(SxS) <= Ord <= OrdP, adica a.i. ordinea OrdP^(SxS) indusa pe S de ordinea OrdP a posetului cu multimea suport P este inclusa in Ord, iar Ord este inclusa in OrdP
   sau, si mai general, ale multimii S intr-un poset (P,OrdP) cu S<=P si OrdP^(SxS) <= O <= OrdP, iar Ord = O U (o multime cu alte elemente decat perechi de elemente ale lui P): */

elemminimal(X,S,Ord) :- member(X,S), not((member(Y,S),
	member((Y,X),Ord), X\=Y)).

/* lista L a elementelor minimale ale multimii S raportat la Ord, unde Ord este o multime ca mai sus: */

elementeminimale(S,Ord,L) :- setof(X, elemminimal(X,S,Ord), L), !.
elementeminimale(_,_,[]).

/* generarea elementelor maximale X ale multimii S raportat la Ord, unde Ord este o multime ca mai sus: */

elemmaximal(X,S,Ord) :- member(X,S), not((member(Y,S),
	member((X,Y),Ord), X\=Y)).

/* lista L a elementelor maximale ale multimii S raportat la Ord, unde Ord este o multime ca mai sus: */

elementemaximale(S,Ord,L) :- setof(X, elemmaximal(X,S,Ord), L), !.
elementemaximale(_,_,[]).

/* conditia ca X sa minoreze multimea S raportat la Ord, unde Ord este o multime ca mai sus: */

minoreaza(X,S,Ord) :- not((member(Y,S), not(member((X,Y),Ord)))).

/* generarea minorantilor M ai submultimii S a multimii suport P a posetului (P,Ord)
   sau, mai general, ai submultimii S a multimii suport P a unui poset (P,Ord)
   sau, mai general, ai submultimii S a multimii suport P a unui poset (P,OrdP), unde Ord = OrdP U (o multime cu alte elemente decat perechi de elemente ale lui P): */

minorant(M,S,P,Ord) :- member(M,P), minoreaza(M,S,Ord).

/* lista LM a minorantilor submultimii S a multimii suport P a unui poset raportat la Ord, unde Ord este o multime ca mai sus: */

minoranti(S,P,Ord,LM) :- setof(M, minorant(M,S,P,Ord), LM), !.
minoranti(_,_,_,[]).

/* conditia ca X sa majoreze pe S raportat la Ord, unde Ord este o multime ca mai sus: */

majoreaza(X,S,Ord) :- not((member(Y,S), not(member((Y,X),Ord)))).

/* generarea majorantilor M ai submultimii S a multimii suport P a unui poset raportat la Ord, unde Ord este o multime ca mai sus: */

majorant(M,S,P,Ord) :- member(M,P), majoreaza(M,S,Ord).

/* lista LM a majorantilor submultimii S a multimii suport P a unui poset raportat la Ord, unde Ord este o multime ca mai sus: */

majoranti(S,P,Ord,LM) :- setof(M, majorant(M,S,P,Ord), LM), !.
majoranti(_,_,_,[]).

/* determinarea minimului M al unui poset (P,Ord)
   sau, mai general, al unei multimi P raportat la o ordine Ord (eventual a unui poset a carui multime suport include pe P)
   sau, mai general, al unei multimi P raportat la ordinea unui poset a carui multime suport include pe P, unde Ord include ordinea acelui poset si poate contine, pe langa elementele acesteia, elemente care nu sunt perechi de elemente ale multimii suport a posetului: */

minim(M,P,Ord) :- member(M,P), minoreaza(M,P,Ord).

/* determinarea maximului M al unui poset (P,Ord), sau, mai general, al multimii P raportat la Ord, unde Ord este o multime ca mai sus: */

maxim(M,P,Ord) :- member(M,P), majoreaza(M,P,Ord).

/* determinarea infimumului Inf al submultimii S a multimii suport P a posetului (P,Ord), cu aceleasi functionari mai generale posibile ca la predicatul care genereaza minorantii sau cel care genereaza majorantii: */

inf(Inf,S,P,Ord) :- minoranti(S,P,Ord,LM), maxim(Inf,LM,Ord).

/* determinarea supremumului Sup al submultimii S a multimii suport P a posetului (P,Ord), cu aceleasi functionari mai generale posibile ca la predicatul care genereaza minorantii sau cel care genereaza majorantii: */

sup(Sup,S,P,Ord) :- majoranti(S,P,Ord,LM), minim(Sup,LM,Ord).

/* Predicatele de mai sus pentru generarea (in cazul in care pot fi mai multe) / determinarea (in cazul in care poate fi cel mult unul) elementelor distinse intr-un poset intorc false daca nu exista astfel de elemente, iar cele pentru colectarea de astfel de elemente intorc [] in acest caz. La fel mai jos.
   Interogati:
?- posetB(B,OrdB), elementeminimale(B,OrdB,Lmin), elementemaximale(B,OrdB,Lmax).
?- posetA(P,Ord), minoranti([a,b],P,Ord,LMin), majoranti([a,b],P,Ord,LMaj).
?- posetA(P,Ord), minim(Min,P,Ord), maxim(Max,P,Ord).
?- posetB(P,Ord), maxim(M,P,Ord).
?- posetB(P,Ord), minim(M,P,Ord).
?- posetA(P,Ord), inf(Inf,[a,b],P,Ord), sup(Sup,[a,b],P,Ord).
?- posetB(P,Ord), sup(Sup,[x,y],P,Ord).
?- posetB(P,Ord), inf(Inf,[x,y],P,Ord).
*/

% testarea daca un poset (L,OrdL) este latice Ore:

latice(L,OrdL) :- not((member(X,L), member(Y,L),
	not((inf(_,[X,Y],L,OrdL), sup(_,[X,Y],L,OrdL))))).

% testarea daca un poset (L,OrdL) este latice (Ore) marginita:

laticemarg(L,OrdL) :- latice(L,OrdL), minim(_,L,OrdL), maxim(_,L,OrdL).

/* testarea daca un poset (L,OrdL) este latice (Ore) marginita, cu determinarea minimului sau Min si a maximului sau Max (sau cu un anumit minim Min si/sau un anumit maxim Max, adica acest predicat poate fi folosit sub forma:
	laticemarg(+L,+OrdL,?Min,?Max)
*/

laticemarg(L,OrdL,Min,Max) :- latice(L,OrdL),
	minim(Min,L,OrdL), maxim(Max,L,OrdL).

/* Interogati:
?- posetA(L,OrdL), latice(L,OrdL).
?- posetB(L,OrdL), latice(L,OrdL).
?- posetA(L,OrdL), laticemarg(L,OrdL).
?- posetA(L,OrdL), laticemarg(L,OrdL,Min,Max).
*/

/* listaNrNatNenule(+N,-L)=true <=> L=[N,N-1,...,3,2,1], i.e. L este lista numerelor naturale nenule mai mici sau egale decat numarul natural N ordonate descrescator (pentru ca nu am nevoie de o anumita ordonare a acestora si mi-e mai usor sa scriu astfel recursia): */

listaNrNatNenule(0,[]) :- !.
listaNrNatNenule(N,[N|T]) :- PN is N-1, listaNrNatNenule(PN,T).

% posetul (P,<=) din exercitiul/pg.16/Partea 1/Seminar 4:

posetP(P,OrdP) :- listaNrNatNenule(14,P),
	orddinsucc([(1,2), (1,3), (1,4), (1,5), (2,6), (2,9), (3,6), (3,7), (4,7), (4,8), (5,8), (5,9), (6,10), (6,13), (7,10), (7,11), (8,11), (8,12), (9,12), (9,13),(10,14), (11,14), (12,14), (13,14)],P,OrdP).

% posetul (Q,<=) din exercitiul/pg.16/Partea 1/Seminar 4:

posetQ(Q,OrdQ) :- listaNrNatNenule(11,Q),
	orddinsucc([(1,2), (1,3), (1,4), (1,5), (2,7), (2,6), (3,7), (3,8), (4,6), (4,9), (5,9), (5,10), (6,8), (6,10), (7,11), (8,11), (9,11), (10,11)],Q,OrdQ).

/* generarea perechilor (X,Y) din PxP care nu au infimum in posetul (P,OrdP): */

perfarainf(X,Y,P,OrdP) :- member(X,P), member(Y,P),
	not(inf(_,[X,Y],P,OrdP)).

/* lista L a perechilor de elemente ale multimii P care nu au infimum in posetul (P,OrdP): */

perechifarainf(P,OrdP,L) :- setof((X,Y), perfarainf(X,Y,P,OrdP), L), !.
perechifarainf(_,_,[]).

/* generarea perechilor (X,Y) din PxP care nu au supremum in posetul (P,OrdP): */

perfarasup(X,Y,P,OrdP) :- member(X,P), member(Y,P),
	not(sup(_,[X,Y],P,OrdP)).

/* lista L a perechilor de elemente ale multimii P care nu au supremum in posetul (P,OrdP): */

perechifarasup(P,OrdP,L) :- setof((X,Y), perfarasup(X,Y,P,OrdP), L), !.
perechifarasup(_,_,[]).

/* Interogati:
?- posetP(P,OrdP), latice(P,OrdP).
?- posetQ(Q,OrdQ), latice(Q,OrdQ).
?- posetP(P,OrdP), perechifarainf(P,OrdP,LI), perechifarasup(P,OrdP,LS).
?- posetQ(Q,OrdQ), perechifarainf(Q,OrdQ,LI), perechifarasup(Q,OrdQ,LS).
Pentru generarea acestora ca perechi neordonate, putem proceda astfel:
*/

perechilefarainf(P,OrdP,M) :- findall([X,Y], perfarainf(X,Y,P,OrdP), L),
	elimDuplMult(L,M).

perechilefarasup(P,OrdP,M) :- findall([X,Y], perfarasup(X,Y,P,OrdP), L),
	elimDuplMult(L,M).

% eliminarea duplicatelor dintr-o lista de multimi:

elimDuplMult([],[]).
elimDuplMult([H|T],[H|L]) :- not((member(M,T), egaldemult(H,M))),
	!, elimDuplMult(T,L).
elimDuplMult([_|T],L) :- elimDuplMult(T,L).

/* Interogati:
?- posetP(P,OrdP), perechilefarainf(P,OrdP,LI), perechilefarasup(P,OrdP,LS).
?- posetQ(Q,OrdQ), perechilefarainf(Q,OrdQ,LI), perechilefarasup(Q,OrdQ,LS).
*/

/* generarea izomorfismelor F de la posetul (P,OrdP) la posetul (Q,OrdQ) prin selectarea dintre bijectiile F:P->Q a celor izotone si cu inversa izotona: */

izomposeturi(F,P,OrdP,Q,OrdQ) :- bijectie(F,P,Q), cresc(F,OrdP,OrdQ),
	invrel(F,FlaMinus1), cresc(FlaMinus1,OrdQ,OrdP).

% determinarea daca poseturile (P,OrdP) si (Q,OrdQ) sunt izomorfe:

poseturiizomorfe(P,OrdP,Q,OrdQ) :- izomposeturi(_,P,OrdP,Q,OrdQ), !.

% lista LF a izomorfismelor de la posetul (P,OrdP) la posetul (Q,OrdQ):

izomorfismeposeturi(P,OrdP,Q,OrdQ,LF) :- setof(F,
	izomposeturi(F,P,OrdP,Q,OrdQ), LF), !.
izomorfismeposeturi(_,_,_,_,[]).

% produsul direct de poseturi: (Prod,OrdProd)=(P,OrdP)x(Q,OrdQ)

prodposeturi(P,OrdP,Q,OrdQ,Prod,OrdProd) :- prodcart(P,Q,Prod),
	prodrel(OrdP,OrdQ,OrdProd).

/* Interogati:
?- l2(L2,OrdL2), prodposeturi(L2,OrdL2,L2,OrdL2,Prod,OrdProd).
?- romb(R,OrdR), izomposeturi(F,R,OrdR,R,OrdR).
?- l2(L2,OrdL2), prodposeturi(L2,OrdL2,L2,OrdL2,Prod,OrdProd), romb(R,OrdR), poseturiizomorfe(Prod,OrdProd,R,OrdR).
?- l2(L2,OrdL2), prodposeturi(L2,OrdL2,L2,OrdL2,Prod,OrdProd), romb(R,OrdR), izomposeturi(F,Prod,OrdProd,R,OrdR).
?- l2(L2,OrdL2), prodposeturi(L2,OrdL2,L2,OrdL2,Prod,OrdProd), romb(R,OrdR), izomposeturi(F,Prod,OrdProd,R,OrdR).
?- l2(L2,OrdL2), prodposeturi(L2,OrdL2,L2,OrdL2,Prod,OrdProd), romb(R,OrdR), izomorfismeposeturi(Prod,OrdProd,R,OrdR,LF), afislistafct(LF,Prod).
*/
