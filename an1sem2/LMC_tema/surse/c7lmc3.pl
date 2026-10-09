:- [l4lmc0].

/* generarea relatiilor binare R pe multimea A, ca relatii binare de la A la A, folosind predicatul relbin(-R,+A,+B) din l4lmc.pl pentru generarea relatiilor binare R de la A la B: */

relbinpe(R,A) :- relbin(R,A,A).

% testarea reflexivitatii unei relatii binare R pe o multime A:

refl(R,A) :- not((member(X,A), not(member((X,X),R)))).

/* generarea relatiilor binare reflexive R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relrefl(R,A) :- relbinpe(R,A), refl(R,A).

/* obtinerea multimii (i.e. a listei fara duplicate; se poate obtine si cu findall in loc de setof, pentru ca relrefl(R,A) nu duplica solutiile, intrucat relbinpe(R,A) nu duplica solutiile) relatiilor binare reflexive pe A: */

relatiilerefl(A,LR) :- setof(R, relrefl(R,A), LR).

/* obtinerea multimii LR a relatiilor binare reflexive pe A si a numarului Nr al acestora, insotita de afisarea fiecarei relatii binare reflexive pe A pe cate un rand: */

relatiilereflcuafis(A,LR,Nr) :- relatiilerefl(A,LR), afislista(LR), 				length(LR,Nr).

/*
|P({a,b,c}x{a,b,c})| = 2**9 = 512 relatii binare pe multimea {a,b,c}.
|{R in P({a,b,c}x{a,b,c}) | {(a,a),(b,b),(c,c)} <= R}| =
|{{(a,a),(b,b),(c,c)} U S | S <= ({a,b,c}x{a,b,c})\{(a,a),(b,b),(c,c)}}| = |P(({a,b,c}x{a,b,c})\{(a,a),(b,b),(c,c)})| = 2**(9-3) = 2 ** 6 = 64 relatii binare reflexive pe multimea {a,b,c}.
Analog, |{R in P({a,b,c,d}x{a,b,c,d}) | {(a,a),(b,b),(c,c),(d,d)} <= R}| = |P(({a,b,c,d}x{a,b,c,d})\{(a,a),(b,b),(c,c),(d,d)})| = 2**(16-4) = 2**12 = 4096 relatii binare reflexive pe multimea {a,b,c,d}.
   Interogati:
?- relatiilereflcuafis([a,b,c],LR,Nr).
?- tell('d:/tempwork/relrefl.rtf'), relatiilereflcuafis([a,b,c,d],LR,Nr), nl, write(Nr), write(' relatii binare reflexive pe multimea {a,b,c}'), told.
In general, pe o multime finita A={a1,a2,...,an}, cu n=|A| numar natural nenul, avem acest numar de relatii binare reflexive:
|{R <= AxA | {(a1,a1),(a2,a2),...,(an,an)} <= R}| = 
|{{(a1,a1),(a2,a2),...,(an,an)} U S | S <= (AxA)\{(a1,a1),(a2,a2),...,(an,an)}|=
|P((AxA)\{(a1,a1),(a2,a2),...,(an,an)})|=
2**|(AxA)\{(a1,a1),(a2,a2),...,(an,an)}| = 2**(n**2-n) = 2**(n(n-1)),
intrucat functia h : P((AxA)\{(a1,a1),(a2,a2),...,(an,an)}) -> {R <= AxA | {(a1,a1),(a2,a2),...,(an,an)} <= R},
	pentru orice S <= (AxA)\{(a1,a1),(a2,a2),...,(an,an)},
	h(S) = {(a1,a1),(a2,a2),...,(an,an)} U S,
este o bijectie de la P((AxA)\{(a1,a1),(a2,a2),...,(an,an)}) la multimea relatiilor binare reflexive pe A. */

% testarea ireflexivitatii unei relatii binare R:

irefl(R) :- not(member((X,X),R)).

/* generarea relatiilor binare ireflexive R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relirefl(R,A) :- relbinpe(R,A), irefl(R).

% testarea simetriei unei relatii binare R:

sim(R) :- not((member((X,Y),R), not(member((Y,X),R)))).

/* generarea relatiilor binare simetrice R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relsim(R,A) :- relbinpe(R,A), sim(R).

% testarea antisimetriei unei relatii binare R:

antisim(R) :- not((member((X,Y),R), member((Y,X),R), X\=Y)).

/* generarea relatiilor binare antisimetrice R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relantisim(R,A) :- relbinpe(R,A), antisim(R).

% testarea asimetriei unei relatii binare R:

asim(R) :- not((member((X,Y),R), member((Y,X),R))).

/* generarea relatiilor binare asimetrice R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relasim(R,A) :- relbinpe(R,A), asim(R).

% testarea tranzitivitatii unei relatii binare R:

tranz(R) :- not((member((X,Y),R), member((Y,Z),R),
	not(member((X,Z),R)))).

/* generarea relatiilor binare tranzitive R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

reltranz(R,A) :- relbinpe(R,A), tranz(R).

% testarea totalitatii unei relatii binare R pe o multime:

tot(R,A) :- not((member(X,A), member(Y,A), X\=Y,
	not(member((X,Y),R); member((Y,X),R)))).

/* generarea relatiilor binare totale R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

reltot(R,A) :- relbinpe(R,A), tot(R,A).

% testarea completitudinii unei relatii binare R pe o multime:

completa(R,A) :- not((member(X,A), member(Y,A),
	not(member((X,Y),R); member((Y,X),R)))).

/* generarea relatiilor binare complete R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relcompleta(R,A) :- relbinpe(R,A), completa(R,A).

/* testarea proprietatii de a fi preordine, i.e. reflexiva si tranzitiva, pentru o relatie binara R pe o multime A: */

preord(R,A) :- refl(R,A), tranz(R).

/* generarea preordinilor R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relpreord(R,A) :- relbinpe(R,A), preord(R,A).

/* testarea proprietatii de a fi echivalenta, i.e. preordine simetrica, pentru o relatie binara R pe o multime A: */

eq(R,A) :- preord(R,A), sim(R).

/* generarea echivalentelor R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

releq(R,A) :- relbinpe(R,A), eq(R,A).

/* obtinerea multimii (i.e. a listei fara duplicate; se poate obtine si cu findall in loc de setof, pentru ca releq(R,A) nu duplica solutiile, intrucat relbinpe(R,A) nu duplica solutiile)  EqA a echivalentelor pe A: */

relatiieq(A,EqA) :- setof(R, releq(R,A), EqA).

/* testarea proprietatii de a fi ordine, i.e. preordine antisimetrica, pentru o relatie binara R pe o multime A: */

ord(R,A) :- preord(R,A), antisim(R).

/* generarea ordinilor R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relord(R,A) :- relbinpe(R,A), ord(R,A).

/* obtinerea multimii (i.e. a listei fara duplicate; se poate obtine si cu findall in loc de setof) OrdA a ordinilor pe A: */

relatiiord(A,OrdA) :- setof(R, relord(R,A), OrdA).

/* testarea proprietatii de a fi ordine totala, i.e. ordine si relatie totala, pentru o relatie binara R pe o multime A: */

ordtot(R,A) :- ord(R,A), tot(R,A).

/* generarea ordinilor totale R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relordtot(R,A) :- relbinpe(R,A), ordtot(R,A).

/* obtinerea multimii (i.e. a listei fara duplicate; se poate obtine si cu findall in loc de setof) ordinilor totale pe A: */

relatiiordtot(A,OrdLinA) :- setof(R, relordtot(R,A), OrdLinA).

/* testarea proprietatii de a fi ordine liniara, adica ordine totala, adica ordine completa (pentru ca ordinile sunt reflexive, deci cele totale sunt complete), i.e. ordine si relatie completa, pentru o relatie binara R pe o multime A: */

ordlin(R,A) :- ord(R,A), completa(R,A).

/* generarea ordinilor liniare, adica totale, i.e. complete R pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relordlin(R,A) :- relbinpe(R,A), ordlin(R,A).

/* obtinerea multimii (i.e. a listei fara duplicate; se poate obtine si cu findall in loc de setof) ordinilor liniare, adica totale, i.e. complete pe A: */

relatiiordlin(A,OrdLinA) :- setof(R, relordlin(R,A), OrdLinA).

/* testarea proprietatii de a fi ordine stricta, adica ireflexiva si tranzitiva, pentru o relatie binara R pe o multime A: */

ordstr(R) :- irefl(R), tranz(R).

/* generarea ordinilor stricte pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relordstr(R,A) :- relbinpe(R,A), ordstr(R).

/* obtinerea multimii (i.e. a listei fara duplicate; se poate obtine si cu findall in loc de setof) ordinilor stricte pe A: */

relatiiordstr(A,OrdStrA) :- setof(R, relordstr(R,A), OrdStrA).

/* testarea proprietatii de a fi ordine stricta, adica asimetrica si tranzitiva, pentru o relatie binara R pe o multime A: */

ordstricta(R) :- asim(R), tranz(R).

/* generarea ordinilor stricte pe A, prin selectarea dintre relatiile binare pe A a celor care satisfac predicatul anterior: */

relordstricta(R,A) :- relbinpe(R,A), ordstricta(R).

/* obtinerea multimii (i.e. a listei fara duplicate; se poate obtine si cu findall in loc de setof) ordinilor stricte pe A: */

relatiiordstricta(A,OrdStrA) :- setof(R, relordstricta(R,A),OrdStrA).

/* Interogati:
?- relatiieq([a,b,c],L), length(L,Cate), afislista(L).
?- relatiiord([a,b,c],L), length(L,Cate), afislista(L).
?- relatiiordstr([a,b,c],L), length(L,Cate), afislista(L).
?- relatiiordstricta([a,b,c],L), length(L,Cate), afislista(L).
?- relatiiordtot([a,b,c],L), length(L,Cate), afislista(L).
?- relatiiordlin([a,b,c],L), length(L,Cate), afislista(L).
?- relatiieq([a,b,c,d],L), length(L,Cate), afislista(L).
*/
