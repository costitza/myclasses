:- [l3lmc1,l6lmc1].

/* Notez cu:
	|- teoremele formale si deductia sintactica;
	|= deductia semantica si satisfacerea;
	-| conectorul logic de negatie.
Fie f:L2={0,1}->{false,true} izomorfismul boolean:
	f(0)=false, f(1)=true.
Pentru orice h:V->L2={0,1} si orice enunt sigma:
h~:E->L2 transforma conectorii logici in operatii booleene in L2={0,1} => foh~:E->{false,true} transforma conectorii logici in operatii booleene in {false,true} si avem:
	h|=sigma <=> h~(sigma)=1 <=> (foh~)(sigma)=true.
Fie h:V->L2 arbitrara pentru cele ce urmeaza. */

/* Exercitiul/pg.6/Partea a II-a/Seminar VI:
Notam cu urmatoarele variabile Prolog valorile lui foh:V->{false,true} in aceste variabile propozitionale:
	P := f(h(p))
	Q := f(h(q))
	R := f(h(r))
Avem enunturile:
	alfa = -|p -> (q -> -|r)
	beta = -|p -> q
Avem de demonstrat ca: {alfa,beta,r} |= p, asadar ca are loc implicatia:
	h |= {alfa,beta,r} => h |= p,
indiferent cine este h, adica indiferent de valorile booleene pentru P,Q,R.
Calculam in predicatele alfa(P,Q,R) si beta(P,Q) valorile lui foh~:E->{false,true} in enunturile alfa, respectiv beta: */

alfa(P,Q,R) :- implica(not(P), implica(Q,not(R))).

beta(P,Q) :- implica(not(P),Q).

dedem(P,Q,R) :- implica((alfa(P,Q,R), beta(P,Q), R), P).

demonstratiadeductiei :- not((listaValBool([P,Q,R]), not(dedem(P,Q,R)))).

/* Exercitiul/pg.1/Partea a III-a/Seminar VI:
Notam cu urmatoarele variabile Prolog valorile lui foh:V->{false,true} in aceste variabile propozitionale:
	P := f(h(p))
	Q := f(h(q))
	R := f(h(r))
	S := f(h(s))
alfa = (-|q ^ p) -> -| r
beta = q -> -|p
gama = s -> r
delta = -|r -> s
Avem de demonstrat ca multimea de enunturi {alfa,beta,gama,delta,p} este inconsistenta, adica nesatisfiabila, i.e. nu exista interpretare care s-o satisfaca, adica, oricare ar fi interpretarea h:
	h |=/= {alfa,beta,gama,delta,p},
adica, indiferent de valorile h(p),h(q),h(r),h(s) in L={0,1}, nu au loc simultan: h~(alfa)=h~(beta)=h~(gama)=h~(delta)=h(p)=1,
i.e., indiferent de valorile booleene ale variabilelor P,Q,R,S, nu pot fi satisfacute simultan urmatoarele predicate (in care vom calcula, ca mai sus, valorile lui foh~ in enunturile alfa, beta, gama, respectiv delta) si P: */

alfa1(P,Q,R) :- implica((not(Q),P), not(R)).

beta1(P,Q) :- implica(Q,not(P)).

gama1(R,S) :- implica(S,R).

delta1(R,S) :- implica(not(R),S).

deminconsistenta :- not((listaValBool([P,Q,R,S]), alfa1(P,Q,R),
	beta1(P,Q), gama1(R,S), delta1(R,S), P)).

/* Exercitiul/pg.1,verso/Partea a IV-a/Seminar VI:
Avem de demonstrat, pentru orice enunturi fi,psi,hi, deductia sintactica:
	{fi, fi->(psi->hi), -|hi} |- -|psi
Conform (TCT), aceasta este echivalenta cu deductia semantica:
	{fi, fi->(psi->hi), -|hi} |= -|psi
i.e. cu proprietatea urmatoare pentru orice interpretare h:
	h |= {fi, fi->(psi->hi), -|hi} => h |= -|psi
Notam cu urmatoarele variabile Prolog valorile lui foh~:E->{false,true} in aceste enunturi:
	Fi = f(h~(fi))
	Psi = f(h~(psi))
	Hi = f(h~(hi))
Calculam in urmatorul predicat valoarea lui foh~ in enuntul:
	fi->(psi->hi)
*/

enunt(Fi,Psi,Hi) :- implica(Fi, implica(Psi,Hi)).

deductia :- not((listaValBool([Fi,Psi,Hi]),
	Fi, enunt(Fi,Psi,Hi), not(Hi), not(not(Psi)))).

/* Exercitiul/pg.8/Partea a V-a/Seminar VI:
alfa = [fi -> -|(-|psi -> hi)] <-> [(psi -> -|fi) ^ (hi -> -|fi)]
Avem de demonstrat ca:
	|- alfa,
ceea ce, conform (TC), este echivalent cu:
	|= alfa,
i.e., oricare ar fi interpretarea h, h|=alfa.
Notam cu urmatoarele variabile Prolog valorile lui foh~:E->{false,true} in aceste enunturi:
	Fi = f(h~(fi))
	Psi = f(h~(psi))
	Hi = f(h~(hi))
In urmatorul predicat calculam valoarea f(h~(alfa)) a lui foh~ in enuntul compus alfa de mai sus: */

alfa2(Fi,Psi,Hi) :- echiv(implica(Fi,not(implica(not(Psi),Hi))),
	(implica(Psi,not(Fi)), implica(Hi,not(Fi)))).

demalfa :- not((listaValBool([Fi,Psi,Hi]), not(alfa2(Fi,Psi,Hi)))).

/* Exercitiul/pg.14/Partea a V-a/Seminar VI:
Conform (TD) si (TCT):
	Sigma1 U {fi} |- psi <=> Sigma1 |- fi->psi <=> Sigma1 |= fi->psi,
	Sigma2 U {psi^hi} |- fi <=> Sigma2 |- (psi^hi)->fi
	 <=> Sigma2 |= (psi^hi)->fi,
	Sigma3 U {psi} |- hi <=> Sigma3 |- psi->hi <=> Sigma3 |= psi->hi.
Presupunem ca h |= Sigma1 U Sigma2 U Sigma3,
	<=> h |= Sigma1, h |= Sigma2 si h |= Sigma3, asadar:
h |= fi->psi, h |= (psi^hi)->fi si h |= psi->hi.
avem de demonstrat ca, in ipoteza ca au loc cele trei satisfaceri anterioare, rezulta ca:
	h |= fi <-> (psi ^ hi).
Cu aceleasi notatii Fi,Psi,Hi ca mai sus: */

demregded :- not((listaValBool([Fi,Psi,Hi]), implica(Fi,Psi),
	implica((Psi,Hi),Fi), implica(Psi,Hi), not(echiv(Fi,(Psi,Hi))))).

/* Exercitiul/pg.5/Partea a IV-a/Seminar VI:
Notam cu urmatoarele variabile Prolog valorile lui foh:V->{false,true} in aceste variabile propozitionale:
	P := f(h(p))
	Q := f(h(q))
	R := f(h(r))
	S := f(h(s))
Dintre predicatele de mai jos:
	enunt1(P,Q), enunt2(Q,R), enunt3(R,S), enunt4(P,S), enunt5(P,Q,S) calculeaza valorile lui foh~:E->{false,true} in enunturile care compun multimea Sigma, iar:
	enunt6(P,R) calculeaza valoarea lui foh~:E->{false,true} in enuntul din Delta\Sigma;
	demSigmaConsist afiseaza cvadrupletele de valori booleene pentru variabilele P,Q,R,S care satisfac multimea Sigma; faptul ca exista macar unul arata ca multimea Sigma este consistenta, intrucat p,q,r,s sunt variabile propozitionale doua cate doua distincte, asadar pot lua orice cvadruplet de valori booleene din L2={0,1} intr-o interpretare h, asadar foh le poate atribui orice cvadruplet de valori booleene din {false,true}; daca am fi avut enunturi arbitrare in loc de variabile propozitionale sau chiar variabile propozitionale despre care nu stim ca sunt doua cate doua distincte, atunci aceasta demonstratie de satisfiabilitate nu ar fi fost valabila;
	demDeltaInconsist demonstreaza ca multimea Delta este nesatisfiabila, aratand ca nu exista cvadruplet de valori booleene pentru variabilele P,Q,R,S care sa satisfaca multimea Delta; aceasta demonstratie ramane valabila chiar daca inlocuim variabilele propozitionale p,q,r,s cu enunturi arbitrare: */

enunt1(P,Q) :- P;Q.

enunt2(Q,R) :- implica(Q,not(R)).

enunt3(R,S) :- echiv(R,S).

enunt4(P,S) :- implica(S,P).

enunt5(P,Q,S) :- implica(P,implica(Q,S)).

enunt6(P,R) :- not(P),R.

demSigmaConsist :- listaBool([P,Q,R,S]), enunt1(P,Q), enunt2(Q,R),
 	enunt3(R,S), enunt4(P,S), enunt5(P,Q,S), write([P,Q,R,S]).

demDeltaInconsist :- not((listaValBool([P,Q,R,S]),
	enunt1(P,Q), enunt2(Q,R), enunt3(R,S), enunt4(P,S),
	enunt5(P,Q,S), enunt6(P,R))).

/* Exercitiul 1/Partea a VI-a/Seminarul VI:
Am notat cu variabilele propozitionale a,b,c urmatoarele propozitii:
a: ”A spune adevarul”
b: ”B spune adevarul”
c: ”C spune adevarul”
Notam cu alfa, beta, gama enunturile rostite de cei trei bastinasi:
alfa = (b^c)<->c)
beta = (a^c) -> -|[(b^c)->a]
gama = -|b<->(avb)
Intrucat valorile de adevar ale lui a si alfa, b si beta, respectiv c si gama sunt aceleasi in orice interpretare:
	h(a)=h~(alfa),
	h(b)=h~(beta),
	h(c)=h~(gama),
avem:
	1 = h(a)<->h~(alfa) = h~(a)<->h~(alfa) = h~(a<->alfa),
	1 = h(b)<->h~(beta) = h~(b)<->h~(beta) = h~(b<->beta),
	1 = h(c)<->h~(gama) = h~(c)<->h~(gama) = h~(c<->gama),
oricare ar fi interpretarea h, adica urmatoarele enunturi sunt adevaruri semantice, deci sunt adevaruri sintactice conform (TC), asadar urmatoarele perechi de enunturi sunt echivalente semantic:
|= a<->alfa <=> |- a<->alfa <=> a ~ alfa,
|= b<->beta <=> |- b<->beta <=> b ~ beta,
|= c<->gama <=> |- c<->gama <=> c ~ gama.
Doar am amintit notiunea de echivalenta semantica; nu avem nevoie de aceasta notiune pentru rezolvarea exercitiului.
Notam cu urmatoarele variabile Prolog valorile lui foh:V->{false,true} in aceste variabile propozitionale:
	A=f(h(a))
	B=f(h(b))
	C=f(h(c))
Avem de determinat valorile booleene A,B,C:
A=true <=> f(h(a))=true <=> h(a)=1 <=> h|=a <=>A face parte din tribul Tu 
A=false<=> f(h(a))=false<=> h(a)=0 <=>h|=/=a<=>A face parte din tribul Fa
si la fel pentru B,C. 
Valorile lui foh~:E->{false,true} in enunturile rostite de cei trei bastinasi sunt, respectiv: */

enuntA(B,C) :- echiv((B,C),C). % f(h~(alfa))
enuntB(A,B,C) :- implica((A,C), not(implica((B,C),A))). % f(h~(beta))
enuntC(A,B) :- echiv(not(B), A;B). % f(h~(gama))

% Valorile lui foh~ in adevarurile semantice a<->alfa,b<->beta,c<->gama: 

enuntAdevA(A,B,C) :- echiv(A, enuntA(B,C)). % f(h~(a<->alfa))
enuntAdevB(A,B,C) :- echiv(B, enuntB(A,B,C)). % f(h~(b<->beta))
enuntAdevC(A,B,C) :- echiv(C, enuntC(A,B)). % f(h~(c<->gama))

% Avem de determinat valorile booleene A,B,C care satisfac:

conditia(A,B,C) :- enuntAdevA(A,B,C), enuntAdevB(A,B,C),
	enuntAdevC(A,B,C).

solutia(A,B,C) :- listaBool([A,B,C]), conditia(A,B,C).

scriesolutia :- solutia(A,B,C),
   write('A '), scrie(A),
   write('B '), scrie(B),
   write('C '), scrie(C), nl.

scrie(false) :- write('face parte din tribul Fa'), nl.
scrie(true) :- write('face parte din tribul Tu'), nl. 

/* Interogati:
?- scriesolutia.
*/

%%%%%%%%%%%%%%% MEMO:
/* Sa numesc a,b,c enunturi, ca sa pot afirma ca au loc echivalentele semantice:
	a~alfa, b~beta, c~gama,
adica enunturile a<->alfa, b<->beta, c<->gama sunt satisfacute de orice interpretare h, si cautam valorile h~(a), h~(b), h~(c) ale unei interpretari arbitrare h in aceste enunturi?
Alternativa: a,b,c raman variabile propozitionale, dar nu au loc echivalentele semantice a~alfa, b~beta, c~gama, ci cautam interpretarea h:V->L2={0,1} care satisface egalitatile:
	h(a)=h~(alfa),
	h(b)=h~(beta),
	h(c)=h~(gama),
adica: 
	h~(a)=h~(alfa),
	h~(b)=h~(beta),
	h~(c)=h~(gama),
adica:
	h~(a)<->h~(alfa)=h~(b)<->h~(beta)=h~(c)<->h~(gama)=1,
adica:
	h~(a<->alfa)=h~(b<->beta)=h~(c<->gama)=1.
Cred ca voi pune ambele formulari in rezolvarea Exercitiului 1/Partea a VI-a/Seminarul VI. Voi actualiza si comentariul anterior. */
%%%%%%%%%%%%%%%

/* Exercitiul 2/Partea a VI-a/Seminarul VI:
Notam cu urmatoarele variabile Prolog valorile lui foh~:E->{false,true} in aceste enunturi:
	Alfa = f(h~(alfa))
	Beta = f(h~(beta))
	Gama = f(h~(gama))
	Delta = f(h~(delta))
Calculam valorile lui foh~:E->{false,true} in urmatoarele enunturi: */

enuntul1(Alfa,Beta) :- implica(Alfa,Beta). % f(h~(alfa->beta))

enuntul2(Beta,Gama,Delta) :- implica(Beta,(Gama,Delta)).
	% f(h~(beta->(gama^delta)))

enuntul3(Beta,Gama) :- implica(not(Beta),Gama).  % f(h~(-|beta->gama))

enuntul4(Alfa,Gama) :- implica(Gama,Alfa). % f(h~(gama->alfa))

enuntul5(Alfa,Delta) :- implica(Delta,not(Alfa)). % f(h~(delta->-|alfa))

multimea1nesatisf :- not((listaValBool([Alfa,Beta,Gama,Delta]),
	enuntul1(Alfa,Beta), enuntul2(Beta,Gama,Delta),
	enuntul3(Beta,Gama), enuntul4(Alfa,Gama), enuntul5(Alfa,Delta))).

candMultimea2nesatisf :- not((listaValBool([Alfa,Beta,Gama,Delta]),
	(Alfa ; Beta ; Gama),
	enuntul1(Alfa,Beta), enuntul2(Beta,Gama,Delta),
	enuntul4(Alfa,Gama), enuntul5(Alfa,Delta))).

multimea2satisf(Alfa,Beta,Gama,Delta) :-
	listaBool([Alfa,Beta,Gama,Delta]),
	enuntul1(Alfa,Beta), enuntul2(Beta,Gama,Delta),
	enuntul4(Alfa,Gama), enuntul5(Alfa,Delta).

multimeaIIsatisf(Alfa) :- listaBool([Alfa]),
	enuntul1(Alfa,Alfa), enuntul2(Alfa,Alfa,Alfa),
	enuntul4(Alfa,Alfa), enuntul5(Alfa,Alfa).

/* Interogati:
?- multimea1nesatisf.
?- candMultimea2nesatisf.
?- multimea2satisf(Alfa,Beta,Gama,Delta).
?- multimeaIIsatisf(Alfa).
*/

/* Exercitiul/pg.48/Cursurile XIII-XIV:
Notez cu:
	\/ cuantificatorul universal;
	E cuantificatorul existential.
Ca mai sus, notez cu -| negatia logica, iar cu |= satisfacerea.
Introducem algebra A prin urmatoarele trei predicate unare, care memoreaza, respectiv:
   multimea sa suport A,
   operatia sa unara, ca functie de la A la A, data prin graficul ei (alta varianta: cu un predicat binar f, definit prin faptele: f(a,b). f(b,c). f(c,d). f(d,a).),
   relatia sa binara.
Vom testa daca algebra A satisface enunturile de mai jos. */

multimeaA([a,b,c,d]).

functiaF([(a,b),(b,c),(c,d),(d,a)]).

relatiaR([(a,b),(b,c),(c,b),(c,d)]).

% predicate care testeaza daca A |= Ex (R(x,f(x)) ^ R(f(x),x)):

algAsatEnunt1 :- multimeaA(A), functiaF(F), relatiaR(R), member(X,A), 	   member((X,FX),F), member((X,FX),R), member((FX,X),R), write(X), nl.

algAsatEnunt1(X) :- multimeaA(A), functiaF(F), relatiaR(R), member(X,A), 		member((X,FX),F), member((X,FX),R), member((FX,X),R).

% predicate care testeaza daca A |= Ex \/y (R(y,f(f(x))) v R(f(x),y)):

algAsatEnunt2 :- multimeaA(A), functiaF(F), relatiaR(R), member(X,A),
	not((member(Y,A), member((X,FX),F), member((FX,FFX),F), 
	not(member((Y,FFX),R) ; member((FX,Y),R)))), write(X), nl.

algAsatEnunt2(X) :- multimeaA(A), functiaF(F), relatiaR(R), member(X,A),
	not((member(Y,A), member((X,FX),F), member((FX,FFX),F), 
	not(member((Y,FFX),R) ; member((FX,Y),R)))).

% predicat care testeaza daca A |= \/x\/y[x=f(y) -> (-|R(x,y) v f(x)=y)]:

algAsatEnunt3 :- multimeaA(A), functiaF(F), relatiaR(R),
	not((member(X,A), member(Y,A), write((X,Y)), nl,
	member((X,FX),F), member((Y,FY),F),
	not(implica(X=FY,not(member((X,Y),R));FX=Y)),
	write((X,Y)), write(' nu satisface implicatia'))).

/* Interogati:
?- algAsatEnunt1.
?- algAsatEnunt1(X).
?- algAsatEnunt2.
?- algAsatEnunt2(X).
?- algAsatEnunt3.
Afisarile din cadrul predicatelor zeroare nu sunt obligatorii; doar ajuta la urmarirea rezolvarii. Un simplu raspuns false/true e suficient.
Predicatele unare returneaza valorile variabilei X pentru care e satisfacuta formula de sub cuantificatorul existential Ex; si aceasta varianta de implementare faciliteaza urmarirea rezolvarii.
*/
