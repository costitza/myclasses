

% helpers
xor(P,Q) :- P, not(Q) ; Q, not(P).
dif(A, B) :- A, not(B).
inclnuegal(A, B) :- implica(A, B), not(implica(B, A)).

implica(P,Q) :- not(P), ! ; Q.
echiv(P,Q) :- implica(P,Q), implica(Q,P).


listaValBool(L) :- listaBool(L), write(L), nl.

listaBool([]).
listaBool([H|T]) :- member(H,[false,true]), listaBool(T).


% ex 1
% ex 1_1
% A U A = A
stg1_1(_a) :- _a; _a.
dre1_1(_a) :- _a.
ex1_1 :- not((listaValBool([_a]), not(echiv(stg1_1(_a), dre1_1(_a))))).

% ex 1_2
% A U B = B U A
stg1_2(_a, _b) :- _a; _b.
dre1_2(_a, _b) :- _b; _a.
ex1_2 :- not((listaValBool([_a, _b]), not(echiv(stg1_2(_a, _b), dre1_2(_a, _b))))).

% ex 1_3
% (A U B) U C = A U (B U C)
stg1_3(_a, _b, _c) :- (_a; _b); _c.
dre1_3(_a, _b, _c) :- _a; (_b; _c).
ex1_3 :- not((listaValBool([_a, _b, _c]), not(echiv(stg1_3(_a, _b, _c), dre1_3(_a, _b, _c))))).


% ex 2
% ex 2_1
% A \ A = False
stg2_1(_a) :- dif(_a, _a).
dre2_1(_a) :- false.
echivstgcudr2_1(_a) :- echiv(stg2_1(_a), dre2_1(_a)).

suntechiv2_1stgcudr :- not((listaValBool([_a]), 
                           not(echivstgcudr2_1(_a)))).
ex2_1 :- suntechiv2_1stgcudr.

% ex 2_2
% A ∆ A = False
stg2_2(_a) :- xor(_a, _a).
dre2_2(_a) :- false.
echivstgcudr2_2(_a) :- echiv(stg2_2(_a), dre2_2(_a)).

suntechiv2_2stgcudr :- not((listaValBool([_a]), 
                           not(echivstgcudr2_2(_a)))).
ex2_2 :- suntechiv2_2stgcudr.

% ex 2_3
% A ∆ B = B ∆ A
stg2_3(_a, _b) :- xor(_a, _b).
dre2_3(_a, _b) :- xor(_b, _a).
echivstgcudr2_3(_a, _b) :- echiv(stg2_3(_a, _b), dre2_3(_a, _b)).

suntechiv2_3stgcudr :- not((listaValBool([_a, _b]), 
                           not(echivstgcudr2_3(_a, _b)))).
ex2_3 :- suntechiv2_3stgcudr.

% ex 2_4
% (A ∆ B) ∆ C = A ∆ (B ∆ C)
stg2_4(_a, _b, _c) :- xor(xor(_a, _b), _c).
dre2_4(_a, _b, _c) :- xor(_a, xor(_b, _c)).
echivstgcudr2_4(_a, _b, _c) :- echiv(stg2_4(_a, _b, _c), dre2_4(_a, _b, _c)).

suntechiv2_4stgcudr :- not((listaValBool([_a, _b, _c]), 
                           not(echivstgcudr2_4(_a, _b, _c)))).
ex2_4 :- suntechiv2_4stgcudr.



% ex 3
% ex 3_1
% A ⊆ A U B
prop3_1(_a, _b) :- implica(_a, (_a; _b)).

ex3_1 :- not((listaValBool([_a, _b]), 
                      not(prop3_1(_a, _b)))).

% ex 3_2
% A U B = B <=> A ⊆ B
% A U B = B
stg3_2(_a, _b) :- echiv((_a; _b), _b).

% A ⊆ B
dre3_2(_a, _b) :- implica(_a, _b).

echivstgcudr3_2(_a, _b) :- echiv(stg3_2(_a, _b), dre3_2(_a, _b)).

suntechiv3_2stgcudr :- not((listaValBool([_a, _b]), 
                           not(echivstgcudr3_2(_a, _b)))).
ex3_2 :- suntechiv3_2stgcudr.



% ex 4
% ex 4_1
% False ⊆ A
prop4_1(_a) :- implica(false, _a).
ex4_1 :- not((listaValBool([_a]), not(prop4_1(_a)))).

% ex 4_2
% A ⊆ A
prop4_2(_a) :- implica(_a, _a).
ex4_2 :- not((listaValBool([_a]), not(prop4_2(_a)))).

% ex 4_3
% non(A inclus dar nu egal A)
prop4_3(_a) :- not(inclnuegal(_a, _a)).
ex4_3 :- not((listaValBool([_a]), not(prop4_3(_a)))).

% ex 4_4
% A \ False = A
stg4_4(_a) :- dif(_a, false).
dre4_4(_a) :- _a.
echiv4_4(_a) :- echiv(stg4_4(_a), dre4_4(_a)).
ex4_4 :- not((listaValBool([_a]), not(echiv4_4(_a)))).

% ex 4_5
% False \ A = False
stg4_5(_a) :- dif(false, _a).
dre4_5(_) :- false.
echiv4_5(_a) :- echiv(stg4_5(_a), dre4_5(_a)).
ex4_5 :- not((listaValBool([_a]), not(echiv4_5(_a)))).

% ex 4_6
% A ∆ False = A
stg4_6(_a) :- xor(_a, false).
dre4_6(_a) :- _a.
echiv4_6(_a) :- echiv(stg4_6(_a), dre4_6(_a)).
ex4_6 :- not((listaValBool([_a]), not(echiv4_6(_a)))).


% ex 5
% ex 5_1
% A U B = False <=> (A = False si B = False)
stg5_1(_a, _b) :- echiv((_a; _b), false).
dre5_1(_a, _b) :- echiv(_a, false), echiv(_b, false).

echivstgcudr5_1(_a, _b) :- echiv(stg5_1(_a, _b), dre5_1(_a, _b)).

suntechiv5_1stgcudr :- not((listaValBool([_a, _b]), 
                           not(echivstgcudr5_1(_a, _b)))).
ex5_1 :- suntechiv5_1stgcudr.

% ex 5_2
% A \ B = False <=> A ⊆ B
stg5_2(_a, _b) :- echiv(dif(_a, _b), false).
dre5_2(_a, _b) :- implica(_a, _b).

echivstgcudr5_2(_a, _b) :- echiv(stg5_2(_a, _b), dre5_2(_a, _b)).

suntechiv5_2stgcudr :- not((listaValBool([_a, _b]), 
                           not(echivstgcudr5_2(_a, _b)))).
ex5_2 :- suntechiv5_2stgcudr.

% ex 5_3
% A ∆ B = False <=> A = B
stg5_3(_a, _b) :- echiv(xor(_a, _b), false).
dre5_3(_a, _b) :- echiv(_a, _b).

echivstgcudr5_3(_a, _b) :- echiv(stg5_3(_a, _b), dre5_3(_a, _b)).

suntechiv5_3stgcudr :- not((listaValBool([_a, _b]), 
                           not(echivstgcudr5_3(_a, _b)))).
ex5_3 :- suntechiv5_3stgcudr.


% ex 6
% ex 6_1
% A inclus dar nu egal B <=> (A inclus in B SI B nu e inclus in A)
stg6_1(_a, _b) :- inclnuegal(_a, _b).
dre6_1(_a, _b) :- implica(_a, _b), not(implica(_b, _a)).

echivstgcudr6_1(_a, _b) :- echiv(stg6_1(_a, _b), dre6_1(_a, _b)).

suntechiv6_1stgcudr :- not((listaValBool([_a, _b]), 
                           not(echivstgcudr6_1(_a, _b)))).
ex6_1 :- suntechiv6_1stgcudr.

% ex 6_2
% A inclus in B <=> (A inclus dar nu egal B SAU A egal cu B)
stg6_2(_a, _b) :- implica(_a, _b).
dre6_2(_a, _b) :- (inclnuegal(_a, _b); echiv(_a, _b)).

echivstgcudr6_2(_a, _b) :- echiv(stg6_2(_a, _b), dre6_2(_a, _b)).

suntechiv6_2stgcudr :- not((listaValBool([_a, _b]), 
                           not(echivstgcudr6_2(_a, _b)))).
ex6_2 :- suntechiv6_2stgcudr.

% ex 7
% ex 7_1
% (A inclus dar nu egal B SI B inclus in C) => (A inclus dar nu egal C)
stg7_1(_a, _b, _c) :- inclnuegal(_a, _b), implica(_b, _c).
dre7_1(_a, _b, _c) :- inclnuegal(_a, _c).

prop7_1(_a, _b, _c) :- implica(stg7_1(_a, _b, _c), dre7_1(_a, _b, _c)).

ex7_1 :- not((listaValBool([_a, _b, _c]), 
                      not(prop7_1(_a, _b, _c)))).

% ex 7_2
% (A inclus dar nu egal B SI B inclus dar nu egal C) => (A inclus dar nu egal C)
stg7_2(_a, _b, _c) :- inclnuegal(_a, _b), inclnuegal(_b, _c).
dre7_2(_a, _b, _c) :- inclnuegal(_a, _c).

prop7_2(_a, _b, _c) :- implica(stg7_2(_a, _b, _c), dre7_2(_a, _b, _c)).

ex7_2 :- not((listaValBool([_a, _b, _c]), 
                      not(prop7_2(_a, _b, _c)))).



%ex 8
%ex 8_1
% A ⊆ B
stg8_1(_a, _b) :- implica(_a, _b).

% (A \ C ⊆ B \ C) SI (C \ B ⊆ C \ A)
dre8_1(_a, _b, _c) :- 
    implica(dif(_a, _c), dif(_b, _c)), 
    implica(dif(_c, _b), dif(_c, _a)).

prop8_1(_a, _b, _c) :- implica(stg8_1(_a, _b), dre8_1(_a, _b, _c)).

ex8_1 :- not((listaValBool([_a, _b, _c]), 
                      not(prop8_1(_a, _b, _c)))).

%ex 8_2 (posibil expresie gresita)
% (A ⊆ C SI B ⊆ C)
stg8_2(_a, _b, _c) :- implica(_a, _c), implica(_b, _c).

% A U B ⊆ C
dre8_2(_a, _b, _c) :- implica((_a; _b), _c).

echivstgcudr8_2(_a, _b, _c) :- echiv(stg8_2(_a, _b, _c), dre8_2(_a, _b, _c)).

% expresia care pare ca nu este adevarata
suntechiv8_2stgcudr :- not((listaValBool([_a, _b, _c]), 
                           not(echivstgcudr8_2(_a, _b, _c)))).
ex8_2 :- suntechiv8_2stgcudr.



% ex 9
% ex 9_1
% (A ⊆ B SI C ⊆ D)
stg9(_a, _b, _c, _d) :- implica(_a, _b), implica(_c, _d).

% (A U C ⊆ B U D) SI (A \ D ⊆ B \ C)
dre9(_a, _b, _c, _d) :- 
    implica((_a; _c), (_b; _d)), 
    implica(dif(_a, _d), dif(_b, _c)).
prop9(_a, _b, _c, _d) :- implica(stg9(_a, _b, _c, _d), dre9(_a, _b, _c, _d)).

suntechiv9stgcudr :- not((listaValBool([_a, _b, _c, _d]), 
                         not(prop9(_a, _b, _c, _d)))).
ex9_1 :- suntechiv9stgcudr.



% ex 10
% ex 10_1
% A \ B = A \ (A ∩ B)
stg10_1(_a, _b) :- dif(_a, _b).
dre10_1(_a, _b) :- dif(_a, (_a, _b)).

echivstgcudr10_1(_a, _b) :- echiv(stg10_1(_a, _b), dre10_1(_a, _b)).

suntechiv10_1stgcudr :- not((listaValBool([_a, _b]), 
                            not(echivstgcudr10_1(_a, _b)))).
ex10_1 :- suntechiv10_1stgcudr.

% ex 10_2
% A ∩ B = False <=> A \ B = A
stg10_2(_a, _b) :- echiv((_a, _b), false).
mid10_2(_a, _b) :- echiv(dif(_a, _b), _a).

echivstgcudr10_2(_a, _b) :- echiv(stg10_2(_a, _b), mid10_2(_a, _b)).

suntechiv10_2stgcudr :- not((listaValBool([_a, _b]), 
                            not(echivstgcudr10_2(_a, _b)))).
ex10_2_a :- suntechiv10_2stgcudr.

% A \ B = A <=> B \ A = B
dre10_2(_a, _b) :- echiv(dif(_b, _a), _b).

echivstgcudr10_3(_a, _b) :- echiv(mid10_2(_a, _b), dre10_2(_a, _b)).

suntechiv10_3stgcudr :- not((listaValBool([_a, _b]), 
                            not(echivstgcudr10_3(_a, _b)))).
ex10_2_b :- suntechiv10_3stgcudr.

ex10_2 :- echiv(ex10_2_a, ex10_2_b).



% ex 11
% ex 11_1 
% non(A ∩ B) = non A U non B
stg11_1(_a, _b) :- not((_a, _b)).
dre11_1(_a, _b) :- (not(_a); not(_b)).

echivstgcudr11_1(_a, _b) :- echiv(stg11_1(_a, _b), dre11_1(_a, _b)).

suntechiv11_1stgcudr :- not((listaValBool([_a, _b]), 
                            not(echivstgcudr11_1(_a, _b)))).
ex11_1 :- suntechiv11_1stgcudr.

% ex 11_2 
% A ⊆ B <=> non B ⊆ non A
stg11_2(_a, _b) :- implica(_a, _b).
dre11_2(_a, _b) :- implica(not(_b), not(_a)).

echivstgcudr11_2(_a, _b) :- echiv(stg11_2(_a, _b), dre11_2(_a, _b)).

suntechiv11_2stgcudr :- not((listaValBool([_a, _b]), 
                            not(echivstgcudr11_2(_a, _b)))).
ex11_2 :- suntechiv11_2stgcudr.

% ex 11_3 
% A = B <=> non A = non B
stg11_3(_a, _b) :- echiv(_a, _b).
dre11_3(_a, _b) :- echiv(not(_a), not(_b)).

echivstgcudr11_3(_a, _b) :- echiv(stg11_3(_a, _b), dre11_3(_a, _b)).

suntechiv11_3stgcudr :- not((listaValBool([_a, _b]), 
                            not(echivstgcudr11_3(_a, _b)))).
ex11_3 :- suntechiv11_3stgcudr.

% ex 11_4
% A inclus dar nu egal B <=> non B inclus dar nu egal non A
stg11_4(_a, _b) :- inclnuegal(_a, _b).
dre11_4(_a, _b) :- inclnuegal(not(_b), not(_a)).

echivstgcudr11_4(_a, _b) :- echiv(stg11_4(_a, _b), dre11_4(_a, _b)).

suntechiv11_4stgcudr :- not((listaValBool([_a, _b]), 
                            not(echivstgcudr11_4(_a, _b)))).
ex11_4 :- suntechiv11_4stgcudr.



% ex 12 
% ex 12_1 
% A ∩ B = False <=> A ⊆ non B <=> B ⊆ non A
stg12_1(_a, _b) :- echiv((_a, _b), false).
mid12_1(_a, _b) :- implica(_a, not(_b)).
dre12_1(_a, _b) :- implica(_b, not(_a)).

echiv_12_1_a(_a, _b) :- echiv(stg12_1(_a, _b), mid12_1(_a, _b)).
ex12_1_a :- not((listaValBool([_a, _b]), not(echiv_12_1_a(_a, _b)))).

echiv_12_1_b(_a, _b) :- echiv(mid12_1(_a, _b), dre12_1(_a, _b)).
ex12_1_b :- not((listaValBool([_a, _b]), not(echiv_12_1_b(_a, _b)))).

ex12_1 :- echiv(ex12_1_a, ex12_1_b).

% ex 12_2 
% A U B = True <=> non B ⊆ A <=> non A ⊆ B
stg12_2(_a, _b) :- echiv((_a; _b), true).
mid12_2(_a, _b) :- implica(not(_b), _a).
dre12_2(_a, _b) :- implica(not(_a), _b).

echiv_12_2_a(_a, _b) :- echiv(stg12_2(_a, _b), mid12_2(_a, _b)).
ex12_2_a :- not((listaValBool([_a, _b]), not(echiv_12_2_a(_a, _b)))).

echiv_12_2_b(_a, _b) :- echiv(mid12_2(_a, _b), dre12_2(_a, _b)).
ex12_2_b :- not((listaValBool([_a, _b]), not(echiv_12_2_b(_a, _b)))).

ex12_2 :- echiv(ex12_2_a, ex12_2_b).



%ex 13 
%ex 13_1
% A ∆ B = (A U B) \ (A ∩ B)
stg13(_a, _b) :- xor(_a, _b).
dre13(_a, _b) :- dif((_a; _b), (_a, _b)).

echivstgcudr13(_a, _b) :- echiv(stg13(_a, _b), dre13(_a, _b)).

suntechiv13stgcudr :- not((listaValBool([_a, _b]), 
                          not(echivstgcudr13(_a, _b)))).
ex13_1 :- suntechiv13stgcudr.


