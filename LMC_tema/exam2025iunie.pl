
:- ['surse/l7lmc3.pl'].

n5(N5,OrdN5) :- N5=[0,a,b,c,1],
	orddinsucc([(0,a),(0,c),(c,b),(a,1),(b,1)],N5,OrdN5).

l3(L3, OrdL3) :- L3 = [0, x, 1],
                 orddinsucc([(0, x), (x, 1)], L3, OrdL3).



morfN5laL3(ListaMorf) :- n5(N5, OrdN5), l3(L3, OrdL3), morfismelaticimarg(N5, OrdN5, L3, OrdL3, ListaMorf).

toate_nesurj([], _).
toate_nesurj([F | Rest], L3) :-
    not(surj(F, L3)),
    toate_nesurj(Rest, L3).


niciunasurj :- n5(N5, OrdN5), l3(L3, OrdL3),
                morfN5laL3(LF),
                toate_nesurj(LF, L3).



% ex 2

ipoteza1(Alfa, Beta, Gama) :- implica(not(Alfa), echiv(Beta, not(Gama))).

ipoteza2(Alfa, Beta, Gama) :- echiv((Alfa, Beta), (Beta, Gama)).

concluzia(Alfa, Beta, Gama) :- implica((Beta, Gama), Alfa).


deductia :- not((
    listaValBool([Alfa, Beta, Gama]),
            ipoteza1(Alfa, Beta, Gama),
            ipoteza2(Alfa, Beta, Gama),
            not(concluzia(Alfa, Beta, Gama))
)).



algBooleA(MultElemA, OrdA) :- MultElemA = [a, b, c, d],
                            orddinsucc([(a, b), (a, c), (b, d), (c, d)], MultElemA, OrdA).


detR(RelR) :- algBooleA(MultElemA, OrdA), ordstrdinord(OrdA, RelR).

detF(FctF) :- algBooleA(MultElemA, OrdA), izomorfismeposeturi(MultElemA, OrdA, MultElemA, OrdA, LF),
                member(FctF, LF),
                not(FctF = [(a, a), (b, b), (c, c), (d, d)]).


verifAsatepsilon :- algBooleA(MultElemA, OrdA),
                    detR(RelR),
                    detF(FctF),
                    not((
                        member(Y, MultElemA),
                        not((
                            member(X, MultElemA),
                            
                            member((X, FX), FctF),
                            member((Y, FY), FctF),
                            member((FY, FFY), FctF),

                            FX = FFY,
                            member((X, Y), RelR)
                        ))
                    )).



