:- [surse/l7lmc3.pl].

n5(N5,OrdN5) :- N5=[0,a,b,c,1],
	orddinsucc([(0,a),(0,c),(c,b),(a,1),(b,1)],N5,OrdN5).

l4(L4, OrdL4) :- L4 = [0, x, y, 1],
                 orddinsucc([(0, x), (x, y), (y, 1)], L4, OrdL4).


generarefunct(N5, Ordn, L4, Ordl, ListaFct) :- setof(F, fctstrcresc(F, N5, Ordn, L4, Ordl), ListaFct).

fctN5laL4(ListaFct) :- n5(N5, Ordn), l4(L4, Ordl), generarefunct(N5, Ordn, L4, Ordl, ListaFct).


niciunamorflat :- l4(L4, OrdL4), n5(N5,OrdN5), fctN5laL4(ListaFct), 
                    not((
                        member(F, ListaFct),
                        morflat(F, N5, OrdN5, L4, OrdL4)
                    )).



% ex 2

ipoteza1(Alfa, Beta, Gama) :- implica(Alfa, (Beta; Gama)).

ipoteza2(Alfa, Beta, Gama) :- echiv((Alfa; Beta), implica(Gama, Alfa)).

concluzia(Alfa, Beta, Gama) :- (Alfa; Beta; Gama).


deductia :- not((
    listaValBool([Alfa, Beta, Gama]),
    ipoteza1(Alfa, Beta, Gama),
    ipoteza2(Alfa, Beta, Gama),
    not(
        concluzia(Alfa, Beta, Gama)
    )
)).


detR(RelR) :- ordstrdinsucc([(a , b), (b, c), (c, d)], RelR).

detK(Ctk) :- orddinsucc([(a , b), (b, c), (c, d)], [a, b, c, d], Ord), maxim(Ctk, [a, b, c, d], Ord).

detF(FctF) :- functiileinj([a, b, c, d], [a, b, c, d], LF), member(F, LF),
                setof(F, inclusain([(a , b), (b, c), (c, d)], F), FctF).

listaValMult(_, []).
listaValMult(M, [H|T]) :- member(H, M), listaValMult(M, T).

verifAsatepsilon :- detR(R), detK(Ctk), detF(FctF),
                not((
                    listaValMult([a, b, c, d], [X, Y]),

                    member((X, Y), FctF),
                    not(
                        member((X, Y), R);
                        X = Ctk
                    )
                )).


% $\forall x \exists y$
not((
        member(X, [a, b, c, d]), % Extragem un X
        not((                     % Verificăm dacă NU există niciun Y care să respecte regula
            member(Y, [a, b, c, d]),
            % Verificăm "Expresia Adevărată"
            ( not(member((X, Y), F)) ; member((X, Y), R) ; X = Ctk )
        ))
    )).


% $\exists x \exists y$
% Generăm o pereche oarecare (X, Y)
listaValMult([a, b, c, d], [X, Y]),

% Verificăm dacă acea pereche face expresia adevărată
(  not(member((X, Y), F)) ; member((X, Y), R) ; X = Ctk ).

