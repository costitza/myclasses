:- [l5lmc4].

/* Laticea/pg.2/Partea a II-a/Seminarul IV: suma ordinala a lantului cu doua elemente cu rombul cu inca o copie a lantului cu doua elemente: */

l2plusL2xL2plusL2(L,OrdL) :- L=[0,a,b,x,y,1],
	orddinsucc([(0,x),(x,a),(x,b),(a,y),(b,y),(y,1)],L,OrdL).

/* conditia ca elementele X si Y sa fie incomparabile raportat la ordinea Ord: */

incompar(X,Y,Ord) :- not(member((X,Y),Ord)), not(member((Y,X),Ord)).

/* generarea perechilor ordonate (X,Y) de elemente incomparabile ale posetului (P,OrdP): */

elemincompar(X,Y,P,OrdP) :- member(X,P), member(Y,P), incompar(X,Y,OrdP).

/* multimea M a perechilor neordonate {X,Y} de elemente incomparabile ale posetului (P,OrdP): */

perechielemincompar(P,OrdP,M) :-
	findall([X,Y], elemincompar(X,Y,P,OrdP), L), 
	elimDuplMult(L,M).

% generarea submultimilor total ordonate S ale posetului (P,OrdP):

submulttotord(S,P,OrdP) :- sublista(S,P), not(elemincompar(_,_,S,OrdP)).

% multimea LS a submultimilor total ordonate S ale posetului (P,OrdP):

submultimitotord(P,OrdP,LS) :- setof(S, submulttotord(S,P,OrdP), LS), !.
submultimitotord(_,_,[]).

% generarea sublaticilor S ale laticii Ore (L,OrdL):

sublat(S,L,OrdL) :- sublista(S,L), not((member(X,S), member(Y,S),
	inf(XsiY,[X,Y],L,OrdL), sup(XsauY,[X,Y],L,OrdL),
	not((member(XsiY,S), member(XsauY,S))))).

% multimea LS a sublaticilor S ale laticii Ore (L,OrdL):

sublatici(P,OrdP,LS) :- setof(S, sublat(S,P,OrdP), LS), !.
sublatici(_,_,[]).

% multimea LS a sublaticilor laticii Ore (L,OrdL) care nu sunt lanturi:

sublaticinelinord(L,OrdL,LS) :- 
   setof(S, (sublat(S,L,OrdL), elemincompar(_,_,S,OrdL)), LS), !.
sublaticinelinord(_,_,[]).

% generarea sublaticilor marginite S ale laticii Ore marginite (L,OrdL):

sublatmarg(S,L,OrdL) :- sublat(S,L,OrdL), minim(Zero,L,OrdL),
	maxim(Unu,L,OrdL), member(Zero,S), member(Unu,S).

/* multimea LS a sublaticilor marginite ale laticii Ore marginite (L,OrdL): */

sublaticimarg(L,OrdL,LS) :- setof(S, sublatmarg(S,L,OrdL), LS), !.
sublaticimarg(_,_,[]).

/* multimea LS a sublaticilor marginite ale laticii Ore marginite (L,OrdL) care nu sunt lanturi: */

sublaticimargnelinord(L,OrdL,LS) :- 
   setof(S, (sublatmarg(S,L,OrdL), elemincompar(_,_,S,OrdL)), LS), !.
sublaticimargnelinord(_,_,[]).

/* Desigur, toate laticile pe care le introducem in Prolog sunt finite, deci marginite.
   Interogati:
?- l2plusL2xL2plusL2(P,OrdP), perechielemincompar(P,OrdP,M).
?- l2plusL2xL2plusL2(P,OrdP), submultimitotord(P,OrdP,LS), afislista(LS), length(LS,CateLanturi).
?- l2plusL2xL2plusL2(L,OrdL), sublatici(L,OrdL,LS), afislista(LS), length(LS,CateSublatici).
?- l2plusL2xL2plusL2(L,OrdL), sublaticinelinord(L,OrdL,LS), afislista(LS), length(LS,CateSublaticiNuSuntLanturi).
?- l2plusL2xL2plusL2(L,OrdL), sublaticimarg(L,OrdL,LS), afislista(LS), length(LS,CateSublaticiMarginite).
?- l2plusL2xL2plusL2(L,OrdL), sublaticimargnelinord(L,OrdL,LS), afislista(LS), length(LS,CateSublaticiMarginiteNuSuntLanturi).
*/

/* generarea morfismelor F de latici de la laticea Ore (L,OrdL) la laticea Ore (M,OrdM): */

morflat(F,L,OrdL,M,OrdM) :- functie(F,L,M), 
	not((member(X,L), member(Y,L),
	inf(XsiY,[X,Y],L,OrdL), sup(XsauY,[X,Y],L,OrdL),
	member((X,FX),F), member((Y,FY),F),
	inf(FXsiFY,[FX,FY],M,OrdM), sup(FXsauFY,[FX,FY],M,OrdM),
	not((member((XsiY,FXsiFY),F), member((XsauY,FXsauFY),F))))).

/* multimea LF a morfismelor de latici de la laticea Ore (L,OrdL) la laticea Ore (M,OrdM): */

morfismelatici(L,OrdL,M,OrdM,LF) :- 
	setof(F, morflat(F,L,OrdL,M,OrdM), LF), !.
morfismelatici(_,_,_,_,[]).

/* generarea morfismelor F de latici marginite de la laticea Ore marginita (L,OrdL) la laticea Ore marginita (M,OrdM): */

morflatmarg(F,L,OrdL,M,OrdM) :- morflat(F,L,OrdL,M,OrdM),
	minim(ZeroL,L,OrdL), maxim(UnuL,L,OrdL),
	minim(ZeroM,M,OrdM), maxim(UnuM,M,OrdM),
	member((ZeroL,ZeroM),F), member((UnuL,UnuM),F).

/* lista LF morfismelor de latici marginite de la laticea Ore marginita (L,OrdL) la laticea Ore marginita (M,OrdM): */

morfismelaticimarg(L,OrdL,M,OrdM,LF) :- 
	setof(F, morflatmarg(F,L,OrdL,M,OrdM), LF), !.
morfismelaticimarg(_,_,_,_,[]).

% diamantul:

m3(M3,OrdM3) :- M3=[0,a,b,c,1],
	orddinsucc([(0,a),(0,b),(0,c),(a,1),(b,1),(c,1)],M3,OrdM3).

% pentagonul:

n5(N5,OrdN5) :- N5=[0,x,y,z,1],
	orddinsucc([(0,x),(0,y),(y,z),(x,1),(z,1)],N5,OrdN5).

/* Sa observam ca:
-> functiile cu imaginea singleton intre doua latici sunt morfisme de latici;
-> desigur, acestea nu sunt morfisme de latici marginite decat daca au drept codomeniu lantul cu un singur element: L1.
   Interogati:
?- romb(P,OrdP), l2(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
?- m3(P,OrdP), l2(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
?- n5(P,OrdP), l2(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
?- romb(P,OrdP), m3(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
?- m3(P,OrdP), romb(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
?- m3(P,OrdP), n5(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
?- n5(P,OrdP), m3(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
?- n5(P,OrdP), romb(Q,OrdQ), morfismelatici(P,OrdP,Q,OrdQ,MorfLat), morfismelaticimarg(P,OrdP,Q,OrdQ,MorfLatMarg), afislistafct(MorfLat,P), length(MorfLat,NrMorfLat), write(NrMorfLat), write(' morfisme de latici'), nl, afislistafct(MorfLatMarg,P), length(MorfLatMarg,NrMorfLatMarg), write(NrMorfLatMarg), write(' morfisme de latici marginite').
    Sa observam ca:
-> functiile cu imaginea singleton intre doua poseturi sunt crescatoare; -> exista functii strict crescatoare de la un poset (P,OrdP) la un poset (Q,OrdQ) ddaca lanturile maximale incluse in (P,OrdP) (i.e. submultimile total ordonate de cardinal maxim ale lui (P,OrdP)) au cardinalul mai mic sau egal decat al lanturilor maximale incluse in (Q,OrdQ).
   Sa interogam si cu predicatele pentru determinarea functiilor crescatoare si a functiilor strict crescatoare din baza de cunostinte de la Laboratorul 5:
?- romb(P,OrdP), l2(Q,OrdQ), functiicresc(P,OrdP,Q,OrdQ,LFcresc), functiistrcresc(P,OrdP,Q,OrdQ,LFstrcresc), afislistafct(LFcresc,P), length(LFcresc,NrFctCresc), write(NrFctCresc), write(' functii crescatoare'), nl, afislistafct(LFstrcresc,P), length(LFstrcresc,NrFctStrCresc), write(NrFctStrCresc), write(' functii strict crescatoare').
?- posetA(P,OrdP), posetB(Q,OrdQ), functiicresc(P,OrdP,Q,OrdQ,LFcresc), functiistrcresc(P,OrdP,Q,OrdQ,LFstrcresc), afislistafct(LFcresc,P), length(LFcresc,NrFctCresc), write(NrFctCresc), write(' functii crescatoare'), nl, afislistafct(LFstrcresc,P), length(LFstrcresc,NrFctStrCresc), write(NrFctStrCresc), write(' functii strict crescatoare').
?- romb(P,OrdP), m3(Q,OrdQ), functiicresc(P,OrdP,Q,OrdQ,LFcresc), functiistrcresc(P,OrdP,Q,OrdQ,LFstrcresc), afislistafct(LFcresc,P), length(LFcresc,NrFctCresc), write(NrFctCresc), write(' functii crescatoare'), nl, afislistafct(LFstrcresc,P), length(LFstrcresc,NrFctStrCresc), write(NrFctStrCresc), write(' functii strict crescatoare').
?- m3(P,OrdP), romb(Q,OrdQ), functiicresc(P,OrdP,Q,OrdQ,LFcresc), functiistrcresc(P,OrdP,Q,OrdQ,LFstrcresc), afislistafct(LFcresc,P), length(LFcresc,NrFctCresc), write(NrFctCresc), write(' functii crescatoare'), nl, afislistafct(LFstrcresc,P), length(LFstrcresc,NrFctStrCresc), write(NrFctStrCresc), write(' functii strict crescatoare').
?- posetA(P,OrdP), n5(Q,OrdQ), functiicresc(P,OrdP,Q,OrdQ,LFcresc), functiistrcresc(P,OrdP,Q,OrdQ,LFstrcresc), afislistafct(LFcresc,P), length(LFcresc,NrFctCresc), write(NrFctCresc), write(' functii crescatoare'), nl, afislistafct(LFstrcresc,P), length(LFstrcresc,NrFctStrCresc), write(NrFctStrCresc), write(' functii strict crescatoare').
*/

/* conditia ca elementele X si Y sa fie complemente unul altuia in laticea Ore marginita (L,OrdL): */

complem(X,Y,L,OrdL) :- minim(ZeroL,L,OrdL), maxim(UnuL,L,OrdL),
	inf(ZeroL,[X,Y],L,OrdL), sup(UnuL,[X,Y],L,OrdL).

/* conditia ca elementul X sa fie complementat in laticea Ore marginita (L,OrdL): */

elemcomplem(X,L,OrdL) :- member(Y,L), complem(X,Y,L,OrdL).

/* multimea CL a elementelor complementate ale laticii Ore marginite (L,OrdL): */

elementecomplem(L,OrdL,CL) :- setof(X, elemcomplem(X,L,OrdL), CL), !.
elementecomplem(_,_,[]).

% generarea complementilor Y ai lui X in laticea Ore marginita (L,OrdL): 

complemlui(X,Y,L,OrdL) :- member(Y,L), complem(X,Y,L,OrdL).

% multimea M a complementilor lui X in laticea Ore marginita (L,OrdL):

complementi(X,L,OrdL,M) :- setof(Y, complemlui(X,Y,L,OrdL), M), !.
complementi(_,_,_,[]).

/* multimea MP a perechilor neordonate {X,Y} de elemente complementate ale laticii Ore marginite (L,OrdL): */

perechielemcomplem(L,OrdL,MP) :-
   findall([X,Y], (member(X,L), member(Y,L), complem(X,Y,L,OrdL)), LP),
   elimDuplMult(LP,MP).

/* Interogati:
?- romb(L,OrdL), elementecomplem(L,OrdL,CL), perechielemcomplem(L,OrdL,MP).
?- l2(L,OrdL), elementecomplem(L,OrdL,CL), perechielemcomplem(L,OrdL,MP).
?- m3(L,OrdL), elementecomplem(L,OrdL,CL), perechielemcomplem(L,OrdL,MP), complementi(a,L,OrdL,M).
?- n5(L,OrdL), elementecomplem(L,OrdL,CL), perechielemcomplem(L,OrdL,MP), complementi(x,L,OrdL,Cx), complementi(y,L,OrdL,Cy), complementi(z,L,OrdL,Cz).
*/

% rombul ca produs direct al lantului cu 2 elemente cu el insusi:

rombul(R,OrdR) :- l2(L2,OrdL2), prodposeturi(L2,OrdL2,L2,OrdL2,R,OrdR).

% cubul:

cub(C,OrdC) :- C=[0,a,b,c,x,y,z,1], orddinsucc([(0,a),(0,b),(0,c),(a,x),(b,x),(a,y),(c,y),(b,z),(c,z),(x,1),(y,1),(z,1)],C,OrdC).

/* generarea subalgebrelor booleene ale algebrei Boole (avand laticea Ore subiacenta) (B,OrdB): */

subalgbool(S,B,OrdB) :- sublatmarg(S,B,OrdB), not((member(X,S),
	complemlui(X,Y,B,OrdB), not(member(Y,S)))).

% lista LS a subalgebrelor Boole ale algebrei Boole (B,OrdB):

subalgebrebool(B,OrdB,LS) :- setof(S, subalgbool(S,B,OrdB), LS), !.
subalgebrebool(_,_,[]).

/* Amintesc denumirile alternative:
	(sub)algebra Boole = (sub)algebra booleana;
	morfism de algebre Boole = morfism boolean.
   Amintesc ca:
-> morfismele de latici marginite intre (laticile marginite subiacente a) doua algebre Boole sunt morfisme booleene;
-> morfismele de latici sunt functii crescatoare, deci pastreaza minimele si maximele arbitrare, asadar morfismele surjective de latici intre doua latici marginite sunt morfisme de latici marginite;
-> izomorfismele de poseturi intre doua latici (Ore) sunt izomorfisme de latici, asadar izomorfismele de poseturi intre doua latici marginite sunt izomorfisme de latici marginite, asadar izomorfismele de poseturi intre doua algebre Boole sunt izomorfisme booleene.
   Interogati:
?- cub(B,OrdB), subalgebrebool(B,OrdB,LS), afislista(LS), length(LS,CateSubalgBoole).
?- cub(L,OrdL), rombul(M,OrdM), morfismelaticimarg(L,OrdL,M,OrdM,LF), afislistafct(LF,L), length(LF,CateMorfBool).
?- cub(B,OrdB), izomorfismeposeturi(B,OrdB,B,OrdB,LF), afislistafct(LF,B), length(LF,CateAutomBool).
*/