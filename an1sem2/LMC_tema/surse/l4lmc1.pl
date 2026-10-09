:- [c7lmc3].

/* afisarea elementelor unei liste de liste fiecare pe cate un rand, impreuna cu lungimile lor: */

afisListaListeLung([]).
afisListaListeLung([H|T]) :- write(H), length(H,Nr),
	tab(1), write(Nr), nl, afisListaListeLung(T).

/* Interogati:
?- relatiieq([a,b,c],EqA), afislista(EqA), length(EqA,CateEq).
?- relatiieq([a,b,c,d],EqA), afislista(EqA), length(EqA,CateEq).
?- afisListaListeLung([[],[1,2],[],[a,b,c]]).
?- relatiieq([a,b,c],EqA), afisListaListeLung(EqA), length(EqA,CateEq). 
?- relatiieq([a,b,c,d],EqA), afisListaListeLung(EqA), length(EqA,CateEq). 
*/

/* Notatiile pentru apartenenta, operatii cu multimi si relatii intre multimi vor fi mereu aceleasi din bazele de cunostinte anterioare.
   Pentru orice multime A, folosesc notatiile din curs:
	Eq(A) = multimea relatiilor de echivalenta pe A;
	Part(A) = multimea partitiilor lui A.
   parteq(+R,+A,-P) = true <=> P = partitia asociata lui R,
unde R in Eq(A) la inceputul recursiei: P = A/R = {a/R | a in A};
   clseq(+H,+R,+A,-C) = true <=> C = H/R = {X in A | (H,X) in R} = clasa de echivalenta a lui H raportat la R, unde H in A si R in Eq(A)
*/

clseq(H,R,A,C) :- setof(X, (member(X,A), member((H,X),R)), C).

% observati ca: H in C => ({H}UT)\C = T\C

parteq(_,[],[]).
parteq(R,[H|T],[C|LC]) :- clseq(H,R,[H|T],C), dif(T,C,D),
	parteq(R,D,LC).

/* partitiieq(+A,+LR,-LP) = true <=> LP este lista de partitii ale multimii A asociate echivalentelor din lista de echivalente LR: */

partitiieq(_,[],[]).
partitiieq(A,[R|LR],[P|LP]) :- parteq(R,A,P), partitiieq(A,LR,LP).

/* partitiile(+A,-PartA) = true <=> partitii(+A,-PartA) = true <=> PartA este multimea partitiilor multimii A: */

partitiile(A,PartA) :- relatiieq(A,EqA), partitiieq(A,EqA,PartA).

partitii(A,PartA) :- relatiieq(A,EqA),
	setof(P, R^(member(R,EqA), parteq(R,A,P)), PartA).

/* afisEqPart(+A,+LR) afiseaza echivalentele pe multimea A din lista LR fiecare pe cate un rand, insotita de cardinalul sau si partitia asociata ei: */

afisEqPart(_,[]).
afisEqPart(A,[H|T]) :- write(H), length(H,Nr),
	tab(1), write(Nr), tab(1), parteq(H,A,P), write(P), nl,
	afisEqPart(A,T).

/* Interogati:
?- parteq([(a,a),(b,b),(c,c),(a,b),(b,a)],[a,b,c],P).
?- relatiieq([a,b,c],EqA), afisEqPart([a,b,c],EqA), length(EqA,CateEq).
?- relatiieq([a,b,c,d],EqA), afisEqPart([a,b,c,d],EqA), length(EqA,CateEq).
   Vedeti, in baza de cunostinte de la Cursul 2 al seriei ID:
variantele cu setof in loc de recursii pentru predicatele de mai sus;
generarea partitiilor unei multimi A folosind urmatoarea recurenta:
   unica partitie a unui singleton {a} are o singura clasa, egala cu {a}:
	Part({a}) = {{{a}}};
   pentru orice multime nevida A si orice element a care nu apartine lui A:
	Part(A U {a}) = {{{a}} U P | P in Part(A)}
	 U {{CU{a}} U (P\{C}) | P in Part(A), C in P}:
 {{{a}}UP | P in Part(A)} este multimea partitiilor lui AU{a} in care a este unicul element din clasa sa; acestea se obtin adaugand clasa singleton {a} la cate o partitie P a lui A;
 {{CU{a}}U(P\{C}) | P in Part(A)} este multimea partitiilor lui AU{a} in care clasa lui a contine si alte elemente in afara de a; acestea se obtin din cate o partitie P a lui A adaugand elementul a la o clasa C a lui P (si lasand celelalte clase, adica pe cele din P\{C}, ca atare). */

% eqpart(+P,-R)=true <=> R = echivalenta corespunzatoare partitiei P

eqpart([],[]).
eqpart([C|LC],R) :- prodcart(C,C,CxC), eqpart(LC,Q), reun(CxC,Q,R).

/* Interogati:
?- eqpart([[a,b],[c]],R).
?- eqpart([[a,b],[c,d]],R).
?- partitiile([a,b,c],Part), afislista(Part), length(Part,Cate).
?- partitii([a,b,c,d],Part), afislista(Part), length(Part,Cate).
*/



