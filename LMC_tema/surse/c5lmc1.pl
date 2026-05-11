:- [c3lmc].

% afisarea elementelor unei liste cu fiecare element pe cate un rand:

afislista([]).
afislista([H|T]) :- write(H), nl, afislista(T).

/* f:A->B <=> f=(A,G,B), cu G = {(a,f(a)) | a in A} <= AxB
Facem identificarea: f=G, asadar: f = {(a,f(a)) | a in A} <= AxB.
Daca A si B sunt finite:
   A = {a1,a2,...,an}, cu n=|A| (i.e. a1,a2,...,an 2x2 distincte)
   B = {b1,b2,...,bk}, cu k=|B| (i.e. b1,b2,...,bk 2x2 distincte)
atunci:
   f = {(a1,f(a1)), (a2,f(a2)), ..., (an,f(an))},
cu f(a1),f(a2),...,f(an) in B = {b1,b2,...,bk}.
Asadar:
   f = {(a1,f(a1)), (a2,f(a2)), ..., (an,f(an))}
     = {(a1,f(a1))} U {(a2,f(a2)), ..., (an,f(an))},
unde {(a2,f(a2)), ..., (an,f(an))} este functie
de la A\{a1} = {a2,...,an} la B.
Daca n=k, atunci: f este bijectie de la A la B <=>
lista [f(a1),f(a2),...,f(ak)] este permutare a listei [b1,b2,...,bk],
care da multimea B.
Sa definim un predicat pentru generarea functiilor intre doua multimi finite si unul pentru generarea bijectiilor intre doua multimi finite:
	functie(-F,+A,+B)=true <=> F este functie de la A la B
	bijectie(-F,+A,+B)=true <=> F este bijectie de la A la B
apoi predicate pentru colectarea acestora, precum si un predicat care afiseaza fiecare element al unei liste pe cate o linie: */

/* Notam cu 0 multimea vida.
	functie(-F,+A,+B)=true <=> F este functie de la A la B,
	   data prin graficul ei: F = {(X,F(X)) | X in A},
i.e. ca relatie binara functionala totala de la A la B.
De la 0 la o multime B avem unica functie (0,0,B), avand graficul 0.
O functie F : {H}UT -> B, cu H neapartinand lui T, este de forma:
	{(H,F(H))} U {(X,F(X)) | X in T},
unde {(X,F(X)) | X in T} : T -> B: */

functie([],[],_).
functie([(H,FH)|L],[H|T],B) :- member(FH,B), functie(L,T,B).

% multimea (i.e. lista fara duplicate) LF a functiilor F:A->B:

functiile(A,B,LF) :- setof(F, functie(F,A,B), LF), !.
functiile(_,_,[]).

/* le pot colecta si cu findall, pentru ca predicatul functie nu duplica solutiile: */

functii(A,B,LF) :- findall(F, functie(F,A,B), LF).

/* produsul scalar a doua liste de aceeasi lungime:
prodscal(+L,+M,-P)=true <=> fie L=M=P=[], fie, pentru un N natural nenul: L=[X1,X2,...,XN], M=[Y1,Y2,...,YN], iar lista P obtinuta de acest predicat este:
	P=[(X1,Y1),(X2,Y2),...,(XN,YN)].
*/

prodscal([],[],[]).
prodscal([H|T],[K|U],[(H,K)|L]) :- prodscal(T,U,L).

/* o bijectie F:A->B, data prin graficul ei, este produsul scalar al domeniului sau A cu o permutare a codomeniului sau B: */

bijectie(F,A,B) :- permutare(B,P), prodscal(A,P,F).

% multimea (i.e. lista fara duplicate) LF a bijectiilor F:A->B:

bijectiile(A,B,LF) :- setof(F, bijectie(F,A,B), LF), !.
bijectiile(_,_,[]).

/* le pot colecta si cu findall, pentru ca predicatul permutare, si implicit predicatul bijectie nu duplica solutiile: */

bijectii(A,B,LF) :- findall(F, bijectie(F,A,B), LF).

/* Interogati:
?- functiile([1,2,3],[a,b],L), afislista(L), length(L,CateFunctii).
?- functii([1,2,3],[a,b],L), afislista(L), length(L,CateFunctii).
?- functiile([1,2],[a,b,c],L), afislista(L), length(L,CateFunctii).
?- functiile([1,2,3],[a,b,c],L), afislista(L), length(L,CateFunctii).
?- functiile([],[a,b,c],L), afislista(L), length(L,CateFunctii).
?- functii([],[a,b,c],L), afislista(L), length(L,CateFunctii).
?- functiile([1,2,3],[],L), afislista(L), length(L,CateFunctii).
?- functii([1,2,3],[],L), afislista(L), length(L,CateFunctii).
?- functiile([],[],L), afislista(L), length(L,CateFunctii).
?- functii([],[],L), afislista(L), length(L,CateFunctii).
?- functiile([],[],L), afislista(L), length(L,CateFunctii).
?- bijectiile([1,2,3],[a,b],L), afislista(L), length(L,CateBijectii).
?- bijectiile([1,2],[a,b,c],L), afislista(L), length(L,CateBijectii).
?- bijectii([1,2],[a,b,c],L), afislista(L), length(L,CateBijectii).
?- bijectiile([1,2,3],[a,b,c],L), afislista(L), length(L,CateBijectii).
?- bijectiile([],[],L), afislista(L), length(L,CateBijectii).
?- bijectii([],[],L), afislista(L), length(L,CateBijectii).
?- bijectiile([],[a,b,c],L), afislista(L), length(L,CateBijectii).
?- bijectii([],[a,b,c],L), afislista(L), length(L,CateBijectii).
?- bijectiile([1,2],[],L), afislista(L), length(L,CateBijectii).
?- bijectii([1,2],[],L), afislista(L), length(L,CateBijectii).
?- bijectii([1,2,3],[a,b,c],L), afislista(L), length(L,CateBijectii).
?- bijectiile([],[a,b,c],L), afislista(L), length(L,CateBijectii).
?- bijectiile([1,2,3],[],L), afislista(L), length(L,CateBijectii).
?- bijectiile([],[],L), afislista(L), length(L,CateBijectii).
*/

