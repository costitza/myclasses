
# 1
# vectorii in R sunt atomici (toate elem trebuie sa aiba aceelasi tip de date)
# de aceea in primul caz rezultatul este o suma vectorizata de limbaj cu scalar
# in timp ce in al doilea caz se face conversie la character, lucru ce va determina o eroare 
# daca incercam sa adunam cu scalar (nu este definit "+" pentru tipul de date character)

c(1, 2, 3) + 10
# [1] 11 12 13

c(1, 2, 3, "4")
# [1] "1" "2" "3" "4"



# 2
# in R indexarea negativa reprezinta excluderea elementelor de pe pozitia respectiva

x <- c(10, 20, 30)
x[-1]
# [1] 20 30



# 3
# o matrice definita astfel va arata asa:
# 1 3 5
# 2 4 6
# accesarea [3] reprezinta selectarea celui de-al treilea element din vectorul unidimensional intern
# adica va accesa elementul de pe coloana 2, randul 1 -> 3

matrix(1:6, nrow = 2)[3]
# [1] 3



# 4
# logical(0) -> este un vector logic vid 
# all(logical(0)) -> va return TRUE intrucat nu se poate gasi niciun element in vector care sa fie contraexemplu 
# any(logical(0)) -> ca returna FALSE intrucat any se refera la conditia "exista cel putin un elem adevarat"
# lucru ce este fals din moment ce in vector nu exista elemente

all(logical(0))
# [1] TRUE

any(logical(0))
# [1] FALSE



# 5
# in primul caz se reda elementul a (care este o lista), deci [] accceseaza primul elem al listei
# in al doilea caz [[]] acceseaza continutul elementului, adica lista din "a" in cazul nostru

list(a=1:3)[1]
# $a
# [1] 1 2 3

list(a=1:3)[[1]]
# [1] 1 2 3



# 6
# na.rm = TRUE elimina elementele nule -> ramanem cu c(TRUE, FALSE)
# TRUE -> 1
# FALSE -> 0
# deci mean va fi 0.5


mean(c(TRUE, FALSE, NA), na.rm = TRUE)
# [1] 0.5



# 7
# operatiile pe vectori se fac strict pe baza pozitiilor elementelor

a <- c(rosu = 1, albastru = 10)
b <- c(albastru = 100, rosu = 1000)

a + b
# rosu  albastru 
# 101      1010 

# pentru a formula contraexemplu trebuie sa spunem explicit
#  ca b sa fie aliniat dupa etichetele din a
a + b[names(a)]
# rosu  albastru 
# 1001       110



# 8
# un apel global sample pentru intreaga matrice cu replace = FALSE
# face ca reutilizarea elementului selectat o data, sa fie imposibila 
# pentru urmatoarele extrageri (aparitia pe urmatoarele coloane ale matricei)
# astfel comportamentul probabilistic este stricat -> fiecare incercare trebuie sa fie independenta
# de urmatoarea

# exemplu cu replace = TRUE
set.seed(2026)
B <- 10000L

extrageri <- matrix(sample.int(5L, size = 2L * B, replace = TRUE),
                nrow = 2L,
                ncol = B)

# presupunem ca 1,2,3 sunt bile rosii
# verificam daca ambele bile sunt rosii
ambele_rosii <- colSums(extrageri <= 3) == 2L

print(mean(ambele_rosii))


# implementare corecta cu replace = FALSE
set.seed(2026)
B <- 10000L

experiment_fara_repunere <- function() {
    bile <- sample.int(5L, size = 2L, replace = FALSE)

    # ambele bile rosii
    all(bile <= 3L)
}

# rulam de B ori aceelasi experiment
rezultate <- replicate(B, experiment_fara_repunere())

print(mean(rezultate))