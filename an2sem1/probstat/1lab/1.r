set.seed(2026)
B <- 10000L

args(sample.int)

zar <- sample.int(6L, size = B, replace = TRUE)

head(zar)

sessionInfo()

rezultat <- table(zar)
print(rezultat)
barplot(rezultat, col = "#A62976")


c(TRUE, 2L, 3.5, "optas") 


1:5
5:1


seq(0, 1, length.out = 6)
rep(c("A", "B"), times = 3)
rep(c("A", "B"), each = 3)
numeric(4)
integer(0)
seq_len(10)



a <- c(rosu = 1, albastru = 10)
b <- c(albastru = 100, rosu = 1000)
a + b # rosu=101, albastru=1010
a + b[names(a)] 



x <- c(a = 10, b = 20, c = 30, d = 40)
x[c(4, 1, 1)] # 40 10 10
x[-c(2, 4)] # 10 30
x[c("d", "b")] # 40 20
x[x >= 20 & x < 40] # 20 30
which(x >= 30) # pozitiile 3 si 4
x[x >= 30] <- 0
x


x <- c(2, 5, 8, 11, 14)
par <- (x %% 2 == 0)
par
sum(par) # 3
mean(par) # 0.6
any(par) # cel putin unul
all(par) # toate



x <- c(1, 2, 3, 4)
ceva <- x > 1 & x < 4
ceva


valid <- length(x) > 0L && all(is.finite(x))
valid
if (valid) print(mean(x))



x <- c(2, NA, 8)
x > 3 # FALSE NA TRUE
mean(x > 3) # NA
mean(x > 3, na.rm = TRUE) # 1/2, din cele doua cunoscute
is.na(x)
x[!is.na(x) & x > 3] # 8
FALSE & NA # FALSE
TRUE & NA # NA
TRUE | NA


0.1 + 0.2 == 0.3
isTRUE(all.equal(0.1 + 0.2, 0.3))
identical(1, 1L)
1 == 1L



x <- seq_len(100000L)
y <- numeric(length(x))
str(x)
str(y)

t_bucla <- system.time({
for (i in seq_along(x)) y[i] <- sqrt(x[i])
})
t_vector <- system.time(z <- sqrt(x))
stopifnot(isTRUE(all.equal(y, z)))
rbind(bucla = t_bucla, vector = t_vector)



M <- matrix(1:6, nrow = 2)
M # coloane: (1,2), (3,4), (5,6)
as.vector(M) # 1 2 3 4 5 6
M[, 1] # vector
M[, 1, drop = FALSE] # matrice cu o coloana
rowSums(M)
colMeans(M)
M * M # produs pe elemente
M %*% t(M) # produs matricial
sweep(M, 1, c(10, 100), FUN = "+")
M + c(10, 100, 1000)
