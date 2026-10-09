/* Ex. 2
   Se cer:
   
fctN5laL4(-ListaFct): functii strict crescatoare N5->L4;
niciunamorflat: verifica daca nicio functie nu este morfism
 de latici.

   Avem predicate generice:
   n5/2, l4/2, functiistrcresc/5, morflat/5.

   N5 este pentagonul: 0<x<1 si 0<y<z<1 (doua lanturi).
*/

:- ['surse/l7lmc3.pl'].

n5(N5,OrdN5) :- N5=[0,x,y,z,1],
	orddinsucc([(0,x),(0,y),(y,z),(x,1),(z,1)],N5,OrdN5).

/* fctN5laL4(-ListaFct) */

fctN5laL4(ListaFct) :-
    n5(N5,OrdN5),
    l4(L4,OrdL4),
    functiistrcresc(N5,OrdN5,L4,OrdL4,
                    ListaFct).

/* niciunulmorflat(+ListaFct,+L,+OrdL,+M,+OrdM) */

niciunulmorflat(ListaFct,L,OrdL,M,OrdM) :-
    not((member(F,ListaFct),
         morflat(F,L,OrdL,M,OrdM))).

/* niciunamorflat = nicio functie nu este morfism */

niciunamorflat :-
    n5(N5,OrdN5),
    l4(L4,OrdL4),
    fctN5laL4(ListaFct),
    niciunulmorflat(ListaFct,N5,OrdN5,L4,OrdL4).