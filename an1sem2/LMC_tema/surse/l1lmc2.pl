% comentariu pe un rand

/* comentariu pe
mai multe randuri
*/

/* Toate clauzele din baza de cunostinte si din interogari sunt predicate, adica termeni cu operatorul dominant de tip boolean: intorcand false/true (pentru diferite valori ale argumentelor sale, daca are argumente, i.e. daca nu e zeroar). Aritatea unui operator = numarul de argumente ale acelui operator.
A se vedea in suportul teoretic pentru laborator tipurile de clauze ("instructiuni" in Prolog): fapte, reguli si clauze scop. Bazele de cunostinte sunt formate din fapte si reguli, iar interogarile constau din clauze scop. Observati ca toate clauzele se incheie cu "." (punct).

Interogare eronata:
?- 2**10.
Operatorul ** de ridicare la putere este aritmetic, nu boolean.

Variabilele (numele de variabile) in Prolog incep cu litera mare sau _ (underscore).
Constantele (numele de constante) incep cu litera mica sau cifra sau sunt incadrate intre apostrofurile '...' din dreapta tastaturii etc.. Si lista vida [] este constanta; vedem mai jos sintaxa pentru liste in Prolog.
?- X=2**10.
Raspuns la interogarea de mai sus:
     **
X = /  \
   2   10
Predicatul = este egalul de unificare; vom vedea ce inseamna unificare. Interogarea de mai sus produce instantierea variabilei X cu termenul 2**10, dupa care predicatul = intoarce true. Daca nu s-ar fi putut realiza unificarea, acest predicat ar fi intors false; vom vedea.

?- X is 2**10.
Predicatul "is" are ca efect calculul valorii expresiei aritmetice 2**10 din operandul sau drept, urmata de unificarea operandului stang X cu aceasta valoare, asadar, la interogarea anterioara, Prologul raspunde:
X=1024.

A se vedea definitia arborelui asociat unui termen in suportul teoretic pentru laborator:
	variabilele si constantele au asociati arbori frunza cu unicul nod etichetat cu numele lor;
	arborele asociat unui termen compus f(arg1,arg2,...,argN) se defineste recursiv astfel:
      f
   /  |....\
 arb. arb.  arb.
arg1  arg2  argN

?- X = f(a,1,g(V,W)).
Raspunsul la aceasta interogare:
        f
X =   / | \
     a  1  g
          / \
         V   W
Arborele asociat predicatului din interogarea anterioara:
      =
     / \
    X   f
      / | \
     a  1  g
          / \
         V   W

?- X is 2**10.
Raspunsul la aceasta interogare: X=1024.
Arborele asociat predicatului din interogarea anterioara:
    is
   /  \
  X   **
     /  \
    2   10

Scrieri echivalente pentru (termeni cu) operatori (dominanti) n-ari:
	clasica: numeop(arg1,arg2,...,argn)
	prefixata: numeop arg1 arg2...argn
	postfixata: arg1 arg2...argn numeop
Scrieri echivalente pentru (termeni cu) operatori (dominanti) binari:
	clasica: opbin(argStg,argDr)
	prefixata: opbin argStg argDr
	infixata: argStg opbin argDr
	postfixata: argStg argDr opbin
Desigur, scrierea infixata nu poate fi folosita decat pentru operatori binari.

Operatorii scrisi infixat (precum =, is, ** sau alti operatori aritmetici: +, -, * etc.), prefixat sau postfixat admit si scrierea obisnuita:
	operator(argument1,argument2,...,argumentN)
De exemplu, predicatele din urmatoarele interogari:
?- =(X,**(2,10)).
?- is(X,**(2,10)).
coincid cu: X=2**10, respectiv: X is 2**10.

Prologul calculeaza foarte rapid cu numere extrem de mari. In cazul in care rezultatul unui astfel de calcul nu incape in fereastra interpretorului de Prolog, putem folosi un fisier de output, creandu-l si deschizandu-l pentru scriere cu predicatul tell, scriind in fisier rezultatul calculului cu predicatul write (in urmatoarele interogari folosesc si predicatul nl, pentru trecere la linie noua), apoi inchizand fisierul cu predicatul told. Nu e nevoie sa fac deschiderea fisierului, scrierea in fisier si inchiderea fisierului pe aceeasi linie, adica in aceeasi clauza.
?- tell('d:/tempwork/calcul2la100000.txt'), X is 2**100000, write('Hello, world!'), nl, write('2 la puterea 100000 este = '), write(X), nl, write('calcul efectuat'), told.
?- tell('d:/tempwork/calcul2la10000000.rtf'), X is 2**10000000, write('2 la puterea 10000000 este = '), write(X), nl, write('calcul efectuat'), told.

Predicatul "," este conjunctia logica ("si" logic).
Scopurile compuse de mai sus (aceste conjunctii din interogarile anterioare) se evalueaza de la stanga la dreapta. In momentul intalnirii unui predicat care se evalueaza la false in cadrul acestora, nu se mai evalueaza si restul conjunctiei, ci este intors rezultatul false.
Alti conectori logici predefiniti:
";" este disjunctia logica ("sau" logic);
"not" sau "\+" este negatia logica.

Si calculele cu numere de tip float sunt foarte rapide in Prolog:
?- X is 2.7**100.

Toate predicatele folosite pana acum sunt predefinite in Prolog.
Sa definim propriul nostru predicat pentru calculul factorialului, care sa functioneze astfel:
	factorial(+N,-F)=true <=> F=N!
Conform conventiei din documentatia Prolog-ului, argumentele precedate de "+" vor fi furnizate Prolog-ului in interogari, iar cele precedate de "-" vor fi calculate de Prolog in interogari. Mai exista un tip de argumente: cele precedate de "?", care pot avea ambele roluri: predicatele in care apar astfel de argumente functioneaza cu argumentele respective furnizate in interogari, dar le pot si calcula in interogari. A nu se conchide ca orice combinatie +/- functioneaza pentru multiple argumente precedate de "?" in interogari cu un anumit predicat; a se vedea mai jos predicatul predefinit =.. , care e prezentat in documentatia Prolog-ului sub forma:
	Termen? =.. Lista? ,
dar nu functioneaza cu ambele argumente neinstantiate, i.e. cu Termen si Lista date ambele ca variabile in interogari.

Sa vedem doua variante de definitie pentru predicatul factorial; in prima varianta sa-l denumim fact; sa functioneze tot sub forma:
	fact(+N,-F)=true <=> F=N! ,
adica, pentru N instantiat cu un numar natural intr-o interogare, sa calculeze in F valoarea lui N! (N factorial), apoi sa intoarca true.

In Prolog, valoarea curenta pentru o variabila este valabila doar in clauza curenta, in iteratia curenta din aplicarea clauzei respective pentru satisfacerea scopului curent; vom vedea cum raspunde Prolog-ul la interogari si vom clarifica aceste lucruri.
Pentru a transmite valoarea unei variabile unui alt predicat sau intr-o recursie, trebuie sa retinem acea valoare in unul dintre argumentele predicatului.
Nu avem "instructiuni ciclice" in Prolog, ci doar mecanismul recursiei. */

fact(0,1).
fact(N,F) :- N>0, K is N-1, fact(K,G), F is G*N.

/* Interogati:
?- fact(5,CatFace).
Dupa afisarea solutiei CatFace=120, puteti pune "." in Prolog-ul desktop, respectiv apasa butonul "Stop" in Prolog-ul online, sau mai puteti cere solutii, cu ";" in Prolog-ul desktop, respectiv apasand butonul "Next" in Prolog-ul online, unde aveti si optiunea de a cere urmatoarele 10, 100, 1000 de solutii, cu butoane marcate cu aceste numere.
Nu exista alte solutii, asadar, daca mai cereti solutii, atunci Prolog-ul afiseaza: false.
Varianta: folosim predicatul "!" (denumit "cut"), care "taie backtracking-ul", adica, in momentul in care este intalnit, Prolog-ul intrerupe cautarea solutiilor si incheie evaluarea scopului curent: */

factorial(0,1) :- !.
factorial(N,F) :- K is N-1, factorial(K,G), F is G*N.

/* Interogati:
?- factorial(5,CatFace).
Dupa afisarea solutiei CatFace=120, Prolog-ul incheie evaluarea scopului din aceasta interogare, adica nu ne mai permite sa cerem alte solutii.

Simbolul ":-" (denumit "neck" si avand semnificatia: "daca") din constructia regulilor este tot un predicat binar infixat, si admite si scrierea uzuala pentru termeni cu operatorul dominant binar, adica regulile de mai sus din definitia predicatului factorial se pot scrie, echivalent, astfel:

:-(factorial(0,1),!).
:-(factorial(N,F), (K is N-1, factorial(K,G), F is G*N)).

Putem testa corectitudinea input-ului pentru predicatul factorial: */

factorialul(N,F) :- integer(N), N>=0, factorial(N,F).

/* Interogati:
?- factorialul(5,CatFace).
?- factorialul(5.0,CatFace).
?- factorialul(-5,CatFace).
5.0 este vazut de Prolog ca fiind de tip float, nu integer.
*/

/* Listele in Prolog sunt formate cu operatorul binar [|], avand ca argumente capul listei si coada listei, si constanta lista vida: [].
O lista nevida este de forma: [Head|Tail], unde:
	Head este capul listei, adica primul element al listei;
	Tail este coada listei, adica lista formata din restul elementelor listei: toate in afara de capul listei.
Arborele corespunzator termenului Prolog [Head|Tail] este:
     [|]
     / \
  Head Tail

Sa retinem:
	[] = lista vida
	[Head|Tail] = lista nevida cu capul Head si coada Tail

Listele mai pot fi date prin enumerarea tuturor elementelor, separate prin virgula, sau enumerarea primelor elemente, urmate de coada listei. De exemplu, avem aceste scrieri echivalente:
[1,2,3,4] = [1|[2,3,4]] = [1|[2|[3,4]]] = [1|[2|[3|[4]]]] = [1|[2|[3|[4|[]]]]] = [1,2|[3,4]] = [1,2|[3|[4]]] = [1,2,3|[4]]
pentru lista data de acest termen Prolog:
  [|]
  / \
 1  [|]
    / \
   2  [|]
      / \
     3  [|]
        / \
       4  []
Si, de exemplu, aceste scrieri echivalente:
[1,2,3,4,5] = [1,2,3|[4,5]] = [1|[2,3,4,5]] = [1|[2|[3|[4|[5|[]]]]]
 = '[|]'(1,'[|]'(2,'[|]'(3,'[|]'(4,'[|]'(5,[])))))
(intrucat si operatorul binar '[|]' admite scrierea:
	numeOperator(operandStang,operandDrept))
pentru lista avand aceasta structura ca termen Prolog:
      [|]
      / \
     1  [|]
        / \
       2  [|]
          / \
         3  [|]
            / \
           4  [|]
              / \
             5  []
In scrierea sub forma opbin(argStg,argDr), operatorul binar '[|]' pentru construirea listelor nevide trebuie incadrat intre apostrofurile din dreapta tastaturii.
Pentru termenul f(10,5):
	scriere prefixata: f 10 5
	scriere infixata: 10 f 5
	scriere postfixata: 10 5 f
Cu f scris prefixat:
f 10 f 5 f 3 f 20 (6*5) = f(10,f(5,f(3,f(20,6*5))))
    f
   / \
  10  f
     / \
    5   f
       / \
      3   f
         / \
        20  *
           / \
          6   5
Cu f scris prefixat:
f 10 f f 3 5 f 3 f 20 (6*5) = f(10,f(f(3,5),f(3,f(20,6*5))))
    f
   / \
  10  f
     / \
    f   f
   / \  /\
  3  5 3  f
         / \
        20  *
           / \
          6   5
Cu ambii operatori (f si *) scrisi prefixat:
f 10 f f 3 5 f 3 f 20 * 6 5 = f(10,f(f(3,5),f(3,f(20,6*5))))

Termenul f(X,1,g(U,V,W),h(10,[1,2,3]),[]) are urmatorul arbore asociat:
      f
 / / /  \ \
X 1 g    h []
   /|\   /\
  U V W 10 [|]
           / \
          1  [|]
             / \
            2  [|]
               / \
              3  [|]

Sa calculam lungimea unei liste, cu un predicat binar definit ca mai jos, echivalent cu predicatul predefinit length:
	lungime(+L,-N)=true <=> N este lungimea listei L, adica
				numarul de elemente al listei L

[1,2,3,4,5] = [1|[2|[3|[4|[5|[]]]]]]
Ca si la factorial, vom folosi "is", nu "=" pentru calculul recursiv, pentru ca nu vrem sa primim lungimea listei anterioare sub forma termenului:
          +
         / \
        +   1
       / \
      +   1
     / \
    +   1
   / \
  +   1
 / \
0   1
*/

lungime([],0).
lungime([_|T],N) :- lungime(T,K), N is K+1.

/* Interogati:
?- lungime([1,2,3,4,5],CateElemente).
?- lungime([a,b,c],CateElemente).

Predicatul predefinit =.. functioneaza sub forma:
	Termen=..[OperatorDominant|ListaArgumente]
si poate "sparge" un termen in operatorul sau dominant si lista argumentelor acestui operator, dar si reconstitui un termen din lista avand un operator in capul listei si coada formata dintr-o lista de argumente.
Interogati:
?- [1,2,3,4]=..[OpDom|ListArg].
?- [2,3,4]=..[OpDom|ListArg].
?- [3,4]=..[OpDom|ListArg].
?- [4]=..[OpDom|ListArg].
?- []=..[OpDom|ListArg].
?- c=..[OpDom|ListArg].
?- 10=..[OpDom|ListArg].
?- f(X,1,g(U,V,W),h(10,[1,2,3]),[])=..[OpDom|ListArg].
?- f(X,1,g(U,V,W),h(10,[1,2,3]),[])=..Lista.
?- f(a,1,g(V,W))=..[Op|LA].
?- f(a,1,g(V,W))=..L.
?- T=..[h,X,10,a,[],[1,2]].
?- f(X,g(1,Y),[1,2,3])=..[Op,100,V,[A,B,C|L]].
Functioneaza astfel de interogari "mixte", dar nu si interogari de forma:
?- T=..L.
?- T=..[Op|LA].
cu ambii membri ai lui =.. neinstantiati.
*/

/* Exemplu (facultativ) de folosire a predicatului predefinit =.. : calculul inaltimii arborelui asociat unui termen, pentru care definim predicatul:
   h(+Termen,-Inaltime)=true <=> Inaltime = inaltimea arborelui asociat
				 termenului Termen
*/

h(T,0) :- var(T), !.
h(T,0) :- T=..[_|[]], !.
h(T,H) :- T=..[_|LT], auxh(LT,LH), maxlist(LH,M), H is M+1.

maxlist([X],X).
maxlist([H|T],X) :- T\=[], maxlist(T,M), maxim(H,M,X).

maxim(A,B,A) :- A>=B, !.
maxim(_,B,B).

auxh([],[]).
auxh([T|LT],[H|LH]) :- h(T,H), auxh(LT,LH).

/* Sa definim cu predicat pentru calculul factorialului cu argumentele de tip (-,+) in loc de (+,-), adica un predicat care determina pe N cu proprietatea ca N!=F, unde F este furnizat predicatului in interogari:
	factorialDeCat(-N,+F)=true <=> F=N!
*/

factorialDeCat(N,F) :- auxfactorial(N,0,1,F).

% auxfactorial(N,Ntemporar,Ntemporar!,F)

auxfactorial(_,_,G,F) :- G>F, write('Nu exista N cu N!='), write(F), !.
auxfactorial(N,N,F,F) :- !.
auxfactorial(N,K,G,F) :- M is K+1, H is G*M, auxfactorial(N,M,H,F).

/* Interogati:
?- factorialDeCat(N,120).
?- factorialDeCat(N,720).
?- factorialDeCat(N,700).
?- factorialDeCat(N,500).

In cazul in care nu specificam folderul, ci doar denumirea unui fisier de intrare sau iesire, locatia implicita pentru acesta este subfolderul Prolog al folderului Documents: */

testoutput :- tell('testloc.txt'), write('locatie default pentru output predicat din baza de cunostinte'), told.

testinput :- see('testinput.txt'), read(T), write(T), T=..[Op|L], nl, write(Op), nl, write(L), nl, seen.

/* Predicatul see creeaza si deschide un fisier pentru citire, iar seen il inchide. Se poate lucra simultan cu fisiere de intrare si iesire: */

testinputoutput :- see('testinput.txt'), tell('testoutput.txt'), read(T), write(T), T=..[Op|L], nl, write(Op), nl, write(L), nl, told, seen.

/* Puneti fisierul testinput.txt in subfolderul Prolog al folderului Documents, apoi interogati:
?- testoutput.
?- testinput.
?- testinputoutput.
si verificati output-ul din fisierele testloc.txt si testoutput.txt din acelasi folder. */

/* Interogati:
?- X is 10 div 3.
?- X is 10 mod 3.
?- X is 10 rem 3.
?- X is -10 div 3.
?- X is -10 mod 3.
?- X is -10 rem 3.
   Operatorii aritmetici div, respectiv mod calculeaza catul, respectiv restul impartirii intregi:
X div Y = catul impartirii lui X la Y = [X/Y]
	unde, pentru orice numar real Z, [Z] = partea intreaga a lui Z:
	[Z] = max{N in multimea nr. intregi | N<=Z}
X mod Y = restul impartirii lui X la Y = [X/Y] = X-Y*[X/Y]: amintesc ca X mod Y este numar natural pentru orice numere intregi X si Y.
   Sa calculam numarul de cifre al unui numar intreg:
nrcifre(+N,-NrCf)=true <=> NrCf = numarul de cifre al numarului natural N
numarcifre(+N,-NrCf)=true <=> numar_cifre(+N,-NrCf)=true <=> 
numarCifre(+N,-NrCf)=true <=> numarDeCifre(+N,-NrCf)=true <=> 
numardecifre(+N,-NrCf)=true <=> NrCf = numarul de cifre al numarului intreg N
*/

nrcifre(N,1) :- N<10, !.
nrcifre(N,NrCf) :- M is N div 10, nrcifre(M,NrCifre), NrCf is NrCifre+1.

numarcifre(N,NrCf) :- integer(N), N>=0, nrcifre(N,NrCf).
numarcifre(N,NrCf) :- integer(N), N<0, M is -N, nrcifre(M,NrCf).

numar_cifre(N,NrCf) :- integer(N), N>=0, !, nrcifre(N,NrCf).
numar_cifre(N,NrCf) :- integer(N), M is -N, nrcifre(M,NrCf).

numarCifre(N,NrCf) :- integer(N),
	(N>=0, nrcifre(N,NrCf) ; N<0, M is -N, nrcifre(M,NrCf)).

numarDeCifre(N,NrCf) :- integer(N),
	(N>=0, !, nrcifre(N,NrCf) ; M is -N, nrcifre(M,NrCf)).

:-(numardecifre(N,NrCf), (integer(N),
	(>=(N,0), !, nrcifre(N,NrCf) ; M is -N, nrcifre(M,NrCf)))).

/* Observati ca numarDeCifre si numardecifre au aceeasi definitie, dar cea pentru numardecifre este scrisa cu toti operatorii binari sub forma:
	opbin(argStg,argDr)
Interogati:
?- numarcifre(100,NrCf).
?- numarcifre(-100,NrCf).
?- numar_cifre(100,NrCf).
?- numar_cifre(-100,NrCf).
?- numarCifre(100,NrCf).
?- numarCifre(-100,NrCf).
?- numarDeCifre(100,NrCf).
?- numarDeCifre(-100,NrCf).
?- numardecifre(100,NrCf).
?- numardecifre(-100,NrCf).
?- X is 2**1000, nrcifre(X,Nr).
?- X is 2**1000000, nrcifre(X,Nr).

Amintesc predicatul binar = de unificare si varianta sa unify_with_occurs_check:
?- X=Y.
?- X=f(Y).
?- X=f(1,[a],g(U,v)).
?- X=[1,2,3].
?- c=d.
?- c=10.
?- c=[].
?- c=f(Y).
?- c=c(Y).
?- c=c.
?- X=f(X).
    f
X = |
    f
    |
    f
    |
   ...
?- unify_with_occurs_check(X,f(X)).
Negatia lui = : predicatul binar \= de nonunificare:
?- c\=c.
?- c\=c(Y).
Interogarea anterioara este echivalenta cu:
?- not(c=c(Y)).
?- X\=Y.
Predicatul binar == de literal identitate:
?- X==Y.
?- X==X.
Negatia lui == : predicatul binar \== de non-literal identitate:
?- X\==Y.
?- X\==X.
Predicatele binare pentru testarea inegalitatilor aritmetice:
?- 10<15.
?- 10=<15.
?- 10>=15.
?- 10>15.
Aplicate la expresii aritmetice, aceste predicate pentru testarea inegalitatilor produc calculul aritmetic in ambii membri, urmat de compararea valorilor rezultate in urma calculului:
?- 10*7=<15+70.
Inegalitati pe termeni:
?- f(X)@<f(Y).
?- f(X)@=<f(A,Y).
Interogati:
?- 10*7=15+70.
  *      +
 / \ \= / \
10  7  15 70
?- 10+5=5+10.
  *      +
 / \ \= / \
10  5  5  10
Predicatul binar =:= produce calculul aritmetic in ambii membri, apoi unificarea constantelor numerice rezultate din acest calcul. Negatia lui =:= este =\= : nonegalitatea ca valori aritmetice:
?- 10+5=:=5+10.
?- 10*7=:=15+70.
?- 10*7=\=15+70.
?- 10*7=:=15+55.
?- 10*7=\=15+55.

Predicat echivalent cu predicatul predefinit member: */

membru(_,[]) :- fail. % cu sau fara aceasta clauza obtinem acelasi predicat
membru(H,[H|_]).
membru(X,[_|T]) :- membru(X,T).

/* Predicate pentru testarea apartenentei unui element la o lista, nu si pentru generarea elementelor listei: */

apartine(_,[]) :- fail. % cu sau fara aceasta clauza obtinem acelasi predicat
apartine(H,[H|_]).
apartine(X,[H|T]) :- X\=H, apartine(X,T).

element(_,[]) :- fail. % cu sau fara aceasta clauza obtinem acelasi predicat
element(H,[H|_]) :- !.
element(X,[_|T]) :- element(X,T).

/* Interogati:
?- member(X,[a,b,c,d]).
?- member(b,[a,b,c,d]).
?- member(e,[a,b,c,d]).
?- member(b,[a,b,c,b,d]).
?- member(b,[a,b,c,b,d,b]).
?- membru(X,[a,b,c,d]).
?- membru(b,[a,b,c,d]).
?- membru(e,[a,b,c,d]).
?- membru(b,[a,b,c,b,d]).
?- membru(b,[a,b,c,b,d,b]).
?- apartine(X,[a,b,c,d]).
?- apartine(b,[a,b,c,d]).
?- apartine(e,[a,b,c,d]).
?- apartine(b,[a,b,c,b,d]).
?- apartine(b,[a,b,c,b,d,b]).
?- element(X,[a,b,c,d]).
?- element(b,[a,b,c,d]).
?- element(e,[a,b,c,d]).
?- element(b,[a,b,c,b,d]).
?- element(b,[a,b,c,b,d,b]).
si dati ;/Next pentru a obtine toate solutiile fiecarei interogari.

Apelati predicatele pentru testarea tipurilor de termeni din suportul teoretic pentru laborator.
Sa scriem un predicat variabila echivalent cu predicatul predefinit var si un predicat islist echivalent cu predicatul predefinit is_list:
	variabila(-X)=true <=> X este variabila
	islist(-L)=true <=> L este lista
O variabila este singurul tip de termen care unifica, cu doua constante diferite, dar o scriere de forma:
	variabila(X) :- X=c, X=d.
ar produce un predicat unar variabila care intoarce false indiferent de input, pentru ca, din conjunctia X=c, X=d, primul termen, anume X=c, intoarce:
	true daca apelam variabila(c), caz in care al doilea termen al conjunctiei, c=d, intoarce false;
	false daca apelam variabila(T), unde T nu este nici constanta c, nici variabila;
	true, cu instantierea X=c, daca apelam variabila(X), unde X este variabila, asadar si in acest caz al doilea termen al conjunctiei devine c=d dupa instantierea variabilei X cu constanta c, deci intoarce false;
   asadar conjunctia X=c, X=d se evalueaza la false intotdeauna.
O solutie este implementarea de mai jos, in cazul careia variabila(X) intoarce false, din motivele de mai sus, daca inputul X este orice altceva decat variabila, iar un apel de forma variabila(X) cu X variabila intoarce true fara instantierea variabilei X, intrucat se executa astfel:
	Prolog-ul incearca sa satisfaca mai intai subscopul X=c, care intoarce true, cu instantierea X=c;
	apoi Prolog-ul incearca sa satisfaca subscopul not(X=c), adica not(true), care intoarce false, asadar acum se pierde instantierea X=c, pentru ca X=c nu mai este solutie pentru acest subscop;
	apoi Prolog-ul satisface membrul stang, not(not(X=c)), al conjunctiei de mai jos, care devine not(false), deci e evaluat la true, cu variabila X ramasa neinstantiata;
	in acelasi mod, Prolog-ul satisface membrul drept al acestei conjunctii, not(not(X=d)), fara a instantia variabila X: */

variabila(X) :- not(not(X=c)), not(not(X=d)).

islist(L) :- nonvar(L), isalist(L).

isalist([]).
isalist([_|T]) :- isalist(T).

% elistadeliste(-L)=true <=> listadeliste(-L)=true <=> L = lista de liste

listadeliste(L) :- is_list(L), auxlistadeliste(L).

auxlistadeliste([]).
auxlistadeliste([H|T]) :- is_list(H), auxlistadeliste(T).

elistadeliste(L) :- is_list(L), not((membru(X,L), not(is_list(X)))).

/* O modalitate de a transforma numerele intregi in format float:
?- X is 10+0.0.
?- X is 2**1000, Y is X+0.0.
Alta modalitate de a transforma numerele intregi in format float:
?- format(atom(X),'~e',2**1000), atom_number(X,N).
Cu alti parametri, putem folosi predicatul de mai sus pentru alinierea elementelor in tabele; vom vedea. */
