% Jocul de x si 0 din acea baza de cunostinte separata e facultativ.

/* Simbolul neck, semnificand "daca": :- 
devine "daca si numai daca" (ddaca) pentru urmatoarele doua reguli, intrucat:
	prima dintre ele este singura clauza de definitie a predicatului binar implica, asadar implica(P,Q) e satisfacut daca e satisfacut scopul compus "not(P), ! ; Q" (dat de disjunctia dintre conjunctia negatiei lui P cu predicatul predefinit cut (!, care taie backtracking-ul, spunandu-i Prolog-ului sa nu mai dea alte solutii dupa prima solutie) si Q) si numai daca e satisfacut acest membru drept al acestei reguli, pentru ca nu are alte clauze care sa-l defineasca, adica sa-i dea alte cazuri de satisfacere;
	a doua dintre ele este singura clauza de definitie a predicatului binar echiv, asadar echiv(P,Q) e satisfacut daca e satisfacut scopul compus dat de conjunctia "implica(P,Q), implica(Q,P)" si numai daca e satisfacut acest membru drept al acestei reguli, pentru ca nu are alte clauze care sa-l defineasca, adica sa-i dea alte cazuri de satisfacere. */

implica(P,Q) :- not(P), ! ; Q.
echiv(P,Q) :- implica(P,Q), implica(Q,P).

/* Fie A,B,C,D multimi arbitrare si x element arbitrar.
Pentru orice multime M, notam cu:
	x in M <=> x apartine lui M
Notam cu U reuniunea, cu ^ intersectia, cu \ diferenta, cu <= incluziunea nestricta, iar cu < incluziunea stricta intre multimi. Notam cu 0 multimea vida.
Notam cu urmatoarele variabile urmatoarele enunturi:
	_a : x in A
	_b : x in B
	_c : x in C
	_d : x in D
Sa demonstram ca prin intersectia a doua incluziuni nestricte de multimi membru cu membru se pastreaza incluziunea:
	(A<=B si C<=D) => A^C <= B^D
Avem de aratat ca:
[(x in A => x in B) si (x in C => x in D)] => (x in A^C => x in B^D),
adica:
	[(x in A => x in B) si (x in C => x in D)]
	 => [(x in A si x in C) => (x in B si x in D)]
Procedam la fel ca pana acum, cerandu-i Prolog-ului sa faca un tabel de adevar: */

compinclinters(_a,_b,_c,_d) :-
	implica((implica(_a,_b),implica(_c,_d)),
		implica((_a,_c),(_b,_d))).

demcompinclinters :- not((member(_a,[false,true]),
	member(_b,[false,true]), member(_c,[false,true]),
	member(_d,[false,true]), write((_a,_b,_c,_d)), nl,
	not(compinclinters(_a,_b,_c,_d)))).

/* Desigur, daca efectuam aceasta demonstratie pe hartie, suntem liberi sa consideram doar liniile de tabel de adevar pe care implicatiile (_a=>_b) si (_c=>_d) sunt adevarate:
_a | _b | _c | _d| (_a si _c) => (_b si _d)
____________________________________________
 F |  F | F  | F | A
 F |  F | F  | A | A
 F |  F | A  | A | A
 F |  A | F  | F | A
 F |  A | F  | A | A
 F |  A | A  | A | A
 A |  A | F  | F | A
 A |  A | F  | A | A
 A |  A | A  | A | A
Sau sa procedam prin rationament cu proprietati ale conectorilor logici:
daca (_a si _c) e falsa => [(_a si _c) => (_b si _d)] e adevarata;
daca (_a si _c) e adevarata => _a si _c sunt adevarate;
	prin ipoteza, _a=>_b si _c=>_d sunt adevarate;
	rezulta ca _b si _d sunt adevarate;
	asadar (_b si _d) e adevarata;
	=> [(_a si _c) => (_b si _d)] e adevarata.
In Prolog, aplicarea repetata a lui member devine incomoda cand lucram cu atatea variabile, asadar putem defini un predicat pentru a instantia simultan cu constante booleene toate elementele unei liste de variabile Prolog: */

listaBool([]).
listaBool([H|T]) :- member(H,[false,true]), listaBool(T).

/* Interogati:
?- listaBool([]).
?- listaBool([V]).
?- listaBool([U,V,W]).
?- listaBool([V,true,W]).
?- listaBool([V,altcevaDecatVariabilaSauConstantaBooleana,W]).
si dati ;/Next pentru a obtine toate solutiile.
Pentru a obtine si afisarile listelor de variabile cu fiecare element instantiat cu o constanta booleana, urmate de cate o trecere la linie noua, putem scrie urmatorul predicat, cu ajutorul caruia putem efectua astfel demonstratia prin tabel de adevar de mai sus: */

listaValBool(L) :- listaBool(L), write(L), nl.

demonstramcompinclinters :- not((listaValBool([_a,_b,_c,_d]),
	not(compinclinters(_a,_b,_c,_d)))).

/* Desigur, daca dorim neaparat afisarea efectuata de predicatul demcompinclinters, putem proceda astfel: */

afisarelista([]).
afisarelista([H|T]) :- write(H), (T=[], ! ; write(',')),
			afisarelista(T).

listaValoriBool(L) :- listaBool(L), afisarelista(L), nl.

demonstrezcompinclinters :- not((listaValoriBool([_a,_b,_c,_d]),
	not(compinclinters(_a,_b,_c,_d)))).

/* Sa demonstram acum, prin tabele de adevar efectuate in Prolog, proprietatile de calcul cu multimi folosite in rezolvarea Exercitiului 4 din prima parte a Seminarului 1 pe care o gasiti in acest material de seminar.
Sa incepem cu cele mai simple proprietati: idempotenta, comutativitatea si asociativitatea intersectiei.
Idempotenta intersectiei: A^A=A.
Avem de aratat ca: x in A^A <=> x in A,
adica: (x in A si x in A) <=> x in A.
*/

idempinters(_a) :- echiv((_a,_a),_a).

demidempinters :- not((listaValBool([_a]), not(idempinters(_a)))).

/* Comutativitatea intersectiei: A^B=B^A.
Avem de aratat ca: x in A^B <=> x in B^A,
adica: (x in A si x in B) <=> (x in B si x in A).
*/

comutinters(_a,_b) :- echiv((_a,_b),(_b,_a)).

demcomutinters :- not((listaValBool([_a,_b]),
	not(comutinters(_a,_b)))).

/* Asociativitatea intersectiei: (A^B)^C = A^(B^C),
astfel ca putem scrie fara paranteze: A^B^C = (A^B)^C = A^(B^C).
Avem de aratat ca: x in (A^B)^C <=> x in A^(B^C),
adica:
[(x in A si x in B) si x in C] <=> [x in A si (x in B si x in C)].
*/

asocinters(_a,_b,_c) :- echiv(((_a,_b),_c) , (_a,(_b,_c))).

demasocinters :- not((listaValBool([_a,_b,_c]),
	not(asocinters(_a,_b,_c)))).

/* Continuam cu proprietatile folosite in rezolvarea primei cerinte.
Intersectia a doua multimi este inclusa in prima multime (deci si in a doua, conform comutativitatii intersectiei, asadar: intersectia este inclusa in termenii sai): A^B<=A.
Avem de aratat ca: x in A^B => x in A,
adica: (x in A si x in B) => x in A.
*/

intersinclm(_a,_b) :- implica((_a,_b),_a).

demintersinclm :- not((listaValBool([_a,_b]),
	not(intersinclm(_a,_b)))).

/* Tranzitivitatea incluziunii nestricte: A<=B<=C => A<=C.
Avem de aratat ca:
[((x in A => x in B) si (x in B => x in C)) => (x in A => x in C)].
*/

tranzincl(_a,_b,_c) :- implica((implica(_a,_b),implica(_b,_c)),
			implica(_a,_c)).

demtranzincl :- not((listaValBool([_a,_b,_c]),
	not(tranzincl(_a,_b,_c)))).

/* Acum sa demonstram restul proprietatilor folosite in rezolvarea celei de-a doua cerinte.
Prin intersectia cu o multime in ambii membri ai unei incluziuni nestricte se pastreaza incluziunea: A<=B => A^C<=B^C.
Avem de aratat ca: (x in A => x in B) => (x in A^C => x in B^C),
adica:
(x in A => x in B) => [(x in A si x in C) => (x in B si x in C)].
*/

intersambiimincl(_a,_b,_c) :- implica(implica(_a,_b),
		implica((_a,_c),(_b,_c))).

demintersambiimincl :- not((listaValBool([_a,_b,_c]),
	not(intersambiimincl(_a,_b,_c)))).

/* Am mai demonstrat distributivitatea intersectiei fata de reuniune, dar o repet aici; desigur, cum intersectia e comutativa, distributivitatea la stanga a intersectiei fata de reuniune:
	A ^ (B U C) = (A ^ B) U (A ^ C)
este echivalenta cu distributivitatea la dreapta a intersectiei fata de reuniune:
	(B U C) ^ A = (B ^ A) U (C ^ A).
Sa o demonstram pe prima dintre acestea: A^(B U C) = (A^B) U (A^C).
Avem de aratat ca: x in A^(B U C) <=> x in (A^B) U (A^C),
adica:
	[x in A si (x in B sau x in C)] <=> 
	   [(x in A si x in B) sau (x in A si x in C)].
*/

distribintersfdreun(_a,_b,_c) :- echiv((_a,(_b;_c)), (_a,_b;_a,_c)).

demdistribintersfdreun :- not((listaValBool([_a,_b,_c]),
	not(distribintersfdreun(_a,_b,_c)))).

/* Diferenta de multimi e inclusa in primul sau termen: A\B <= A.
Avem de aratat ca: x in A\B => x in A,
adica: [x in A si non(x in B)] => x in A.
*/

difinclIterm(_a,_b) :- implica((_a,not(_b)), _a).

demdifinclIterm :- not((listaValBool([_a,_b]),
	not(difinclIterm(_a,_b)))).

/* Am folosit si proprietatea ca intersectia a doua multimi dintre care una e inclusa in cealalta e multimea mai mica dintre cele doua:
	A<=B => A^B=A
Este valabila chiar echivalenta: intersectia a doua multimi este una dintre ele ddaca acea multime este inclusa in cealalta:
	A<=B <=> A^B=A
Avem de aratat ca:
	(x in A => x in B) <=> (x in A^B <=> x in A),
adica:
(x in A => x in B) <=> [(x in A si x in B) <=> x in A].
*/

intersecmmica(_a,_b) :- echiv(implica(_a,_b), echiv((_a,_b),_a)).

demintersecmmica :- not((listaValBool([_a,_b]),
	not(intersecmmica(_a,_b)))).

/* Diferenta a doua multimi e disjuncta de al doilea termen al diferentei: (A\B)^B = 0.
In cazul particular in care B<=A, A\B e complementara lui B fata de A, asadar aceasta proprietate devine: orice multime e disjuncta de complementara ei fata de o multime care o include.
Avem de demonstrat ca: x in (A\B)^B <=> x in 0,
adica: [(x in A si not(x in B)) si x in B] <=> false.
*/

difdisjIIterm(_a,_b) :- echiv(((_a,not(_b)),_b), false).

demdifdisjIIterm :-  not((listaValBool([_a,_b]),
	not(difdisjIIterm(_a,_b)))).

/* Reuniunea cu multimea vida este celalalt termen al reuniunii:
	A U 0 = A
Avem de aratat ca: x in A U 0 <=> x in A,
adica: (x in A sau x in 0) <=> x in A,
adica: (x in A sau false) <=> x in A.
*/

reuncu0(_a) :- echiv(_a;false, _a).

demreuncu0 :- not((listaValBool([_a]), not(reuncu0(_a)))).

/* Intersectia cu multimea vida este vida: A ^ 0 = 0.
Avem de aratat ca: x in A ^ 0 <=> x in 0,
adica: (x in A si x in 0) <=> x in 0,
adica: (x in A si false) <=> false.
*/

interscu0(_a) :- echiv((false,_a), false).

deminterscu0 :- not((listaValBool([_a]), not(interscu0(_a)))).

/* O multime inclusa in doua multimi e inclusa in intersectia lor:
	(A<=B si A<=C) => A<=B^C
Avand in vedere idempotenta intersectiei, acesta este cazul particular A=C pentru prima proprietate demonstrata in acest laborator: intersectia a doua incluziuni nestricte membru cu membru pastreaza sensul incluziunii.
In cazul acesta, avem chiar echivalenta: o multime e inclusa in doua multimi ddaca e inclusa in intersectia lor:
	(A<=B si A<=C) <=> A<=B^C
Avem de aratat ca:
[(x in A => x in B) si (x in A => x in C]) <=> (x in A => x in B^C),
adica:
	[(x in A => x in B) si (x in A => x in C])
	 <=> [x in A => (x in B si x in C)].
*/

incl2mult(_a,_b,_c) :- echiv((implica(_a,_b), implica(_a,_c)),
	implica(_a,(_b,_c))).

demincl2mult :- not((listaValBool([_a,_b,_c]),
	not(incl2mult(_a,_b,_c)))).

/* Singura parte a multimii vide e multimea vida:
	A<=0 <=> A=0
Avem de demonstrat ca:
	(x in A => x in 0) <=> (x in A <=> x in 0),
adica: (x in A => false) <=> (x in A <=> false).
*/

sgpartea0e0(_a) :- echiv(implica(_a,false), echiv(_a,false)).

demsgpartea0e0 :- not((listaValBool([_a]), not(sgpartea0e0(_a)))).

/* Interogati:
?- listaBool([P,Q]), echiv(P,Q).
Cum stim deja de la lectiile anterioare, pentru doua enunturi P si Q avand valorile de adevar fals sau adevarat, enuntul P<=>Q e adevarat ddaca P si Q au aceeasi valoare de adevar.
Asadar faptul ca egalitatea a doua multimi A si B (adica faptul ca A si B au aceleasi elemente) este echivalenta cu dubla incluziune intre A si B este imediata din definitia predicatului echiv:
	A=B <=> (A<=B si B<=A),
revine la:
(x in A <=> x in B) <=> [(x in A => x in B) si (x in B => x in A)].
*/

egaledublaincl(_a,_b) :- echiv(echiv(_a,_b),
	(implica(_a,_b), implica(_b,_a))).

demegaledublaincl :- not((listaValBool([_a,_b]),
	not(egaledublaincl(_a,_b)))).

/* Daca, in tranzitivitatea incluziunii nestricte, inlocuim (macar) una dintre incluziuni cu incluziune stricta, atunci obtinem incluziune stricta si intre multimea cea mai mica si multimea cea mai mare; dintre variantele acestei proprietati, cea pe care n-o aveti in prima tema colectiva este:
	A<=B<C => A<C
adica:
	(A<=B si B<C) => A<C
care revine la:
[(x in A => x in B) si ((x in B => x in C) si non(x in B <=> x in C))] => [(x in A => x in C) si non(x in A <=> x in C)]
   Am parantezat complet prima succesiune de conjunctii, pentru ca demonstram fiecare dintre aceste proprietati ca si cum nu am sti nimic apriori. Desigur, stim ca, conjunctia este asociativa:
	[p si (q si r)] <=> [(p si q) si r]
pentru ca aceasta este exact proprietatea prin care am demonstrat asociativitatea intersectiei: A^(B^C) = (A^B)^C, aplicand-o la enunturile x in A, x in B, x in C in locul enunturilor p, q, respectiv r.
   La fel, asociativitatea disjunctiei:
	[p sau (q sau r)] <=> [(p sau q) sau r]
aplicata enunturilor x in A, x in B, x in C in locul enunturilor p, q, respectiv r, devine asociativitatea reuniunii: AU(BUC) = (AUB)UC.
*/

inclnestrinclstr(_a,_b,_c) :- implica((implica(_a,_b),
	(implica(_b,_c),not(echiv(_b,_c)))),
	(implica(_a,_c),not(echiv(_a,_c)))).

deminclnestrinclstr :- not((listaValBool([_a,_b,_c]),
	not(inclnestrinclstr(_a,_b,_c)))).

/* Reuniunea cu o multime in ambii membri ai unei incluziuni nestricte pastreaza incluziunea:
	A<=B => AUC<=BUC
revine la:
   (x in A => x in B) => [(x in A sau x in C) => (x in B sau x in C)]
*/

reunambiimincl(_a,_b,_c) :- implica(implica(_a,_b),
	implica(_a;_c, _b;_c)).

demreunambiimincl :- not((listaValBool([_a,_b,_c]),
	not(reunambiimincl(_a,_b,_c)))).

/* (A\B)^A = A\B
revine la:
[(x in A si non(x in B)) si x in A] <=> [(x in A si non(x in B))]
*/

interscudif(_a,_b) :- echiv(((_a,not(_b)),_a), (_a,not(_b))).

deminterscudif :- not((listaValBool([_a,_b]),
	not(interscudif(_a,_b)))).

/* Fie o multime T, arbitrara, a.i. A<=T si B<=T.
Notez cu \/ cuantificatorul universal.
Amintesc ca, in acest caz (in care A si B sunt parti ale lui T):
	A=B <=> (\/x in T)(x in A <=> x in B)
	A<=B <=> (\/x in T)(x in A => x in B)
Pentru orice M<=T, notam cu -M := T\M.
Are loc: -A <= T, pentru ca: -A = T\A <= T. <= A\B <= A indiferent daca una dintre multimile A si B este inclusa in cealalta sau nu (vedeti mai sus aceasta proprietate).
Pentru proprietatile urmatoare, consideram x in T, arbitrar, asadar:
	x in T e adevarat.
*/

/* Complementara multimii vide e multimea totala:
	-0=T
revine la:
	x in -0 <=> x in T
adica:
	non(x in 0) <=> x in T
adica:
	non(false) <=> true
*/

complem0 :- echiv(not(false), true).

/* Predicatul anterior nu are argumente (variabile), asadar e propozitie: predicat zeroar, are valoare de adevar ca atare, deci e echivalent cu urmatorul predicat.
   Deci o demonstratie semantica (adica prin calcul cu valori de adevar sau tabel de adevar) in Prolog pentru proprietatea: -0=T este:
?- complem0.
iar interogarea:
?- demcomplem0.
face acelasi lucru cu:
?- write([]), nl, complem0.
*/

demcomplem0 :- not((listaValBool([]), not(complem0))).

/* Complementara multimii totale e multimea vida:
	-T=0
revine la:
	x in -T <=> x in 0
adica:
	non(x in T) <=> x in 0
adica:
	non(true) <=> false
*/

complemMultTot :- echiv(not(true), false).

/* Complementara complementarei e identitatea:
	--A = A
revine la:
	x in --A <=> x in A
adica:
	non(x in -A) <=> x in A
adica:
	non non(x in A) <=> x in A
*/

complemcomplemid(_a) :- echiv(not(not(_a)), _a).

demcomplemcomplemid :- not((listaValBool([_a]), 
	not(complemcomplemid(_a)))).

% Diferenta e intersectia cu complementara: A\B=A^-B 

difeinterscucomplem(_a,_b) :- echiv((_a,not(_b)), (_a,not(_b))).

demdifeinterscucomplem :- not((listaValBool([_a,_b]),
	not(difeinterscucomplem(_a,_b)))).

% Prima lege a lui De Morgan: -(AUB)=-A^-B

legeaIDeMorgan(_a,_b) :- echiv(not(_a;_b), (not(_a),not(_b))).

demlegeaIDeMorgan :- not((listaValBool([_a,_b]),
	not(legeaIDeMorgan(_a,_b)))).

% Reuniunea cu complementara e multimea totala: AU-A=T

reuncucomplem(_a) :- echiv(_a;not(_a), true).

demreuncucomplem :- not((listaValBool([_a]),
	not(reuncucomplem(_a)))).

/* A si B formeaza o bipartitie (adica o partitie cu doua clase) a lui T ddaca A si B sunt parti complementare ale lui T, adica fiecare dintre ele este complementara celeilalte fata de T:
	(AUB=T si A^B=0) <=> A=-B <=> B=-A
Aceasta proprietate consta din doua echivalente:
	[(AUB=T si A^B=0) <=> A=-B] si [A=-B <=> B=-A]
asadar revine la:
[((x in AUB<=>x in T) si (x in A^B<=>x in 0))<=>(x in A <=> x in -B)]
 si [(x in A <=> x in -B) <=> (x in B <=> x in -A)]
adica:
[((x in AUB<=>true) si (x in A^B<=>false))<=>(x in A <=> non(x in B)]
 si [(x in A <=> non(x in B)) <=> (x in B <=> non(x in A))]
adica:
[(((x in A sau x in B)<=>true) si ((x in A si x in B)<=>false))
	<=>(x in A <=> non(x in B)]
 si [(x in A <=> non(x in B)) <=> (x in B <=> non(x in A))]
*/

bipartitie(_a,_b) :- echiv((echiv(_a;_b,true), echiv((_a,_b),false)),
	echiv(_a,not(_b))), 
	echiv(echiv(_a,not(_b)), echiv(_b,not(_a))).

dembipartitie :- not((listaValBool([_a,_b]),
	not(bipartitie(_a,_b)))).

