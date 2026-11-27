# 1
k <- 1:5
c_val <- 1 / sum(6 - k)
p <- c_val * (6 - k)

F_salt <- cumsum(p)
names(F_salt) <- k
F_salt
#         1         2         3         4         5 
# 0.3333333 0.6000000 0.8000000 0.9333333 1.0000000 

# P(X > 2)
sum(p[k > 2])
# [1] 0.4

# P(1 < X <= 4)
sum(p[k > 1 & k <= 4])
# [1] 0.6


# 2
x <- -2:2
p <- rep(1/5, 5)

rep_functie <- function(x, p, g) tapply(p, g(x), sum)

rep_functie(x, p, function(t) t^2 - 1)
#  -1   0   3 
# 0.2 0.4 0.4 

rep_functie(x, p, function(t) abs(t) - t)
#   0   2   4 
# 0.6 0.2 0.2


# 3
pbinom(1, size = 12, prob = 0.05)
# [1] 0.88164

n <- 1:15
max(n[pbinom(1, size = n, prob = 0.05) >= 0.9])
# [1] 10


# 4
dhyper(0, m = 4, n = 48, k = 5)
# [1] 0.658842

phyper(1, m = 4, n = 48, k = 5, lower.tail = FALSE)
# [1] 0.04168437



# 5
p <- 0.15

dgeom(4 - 1, prob = p)
# [1] 0.09211875

pgeom(10 - 1, prob = p)
# [1] 0.8031256

qgeom(0.99, prob = p) + 1
# [1] 29



# 6
dnbinom(3, size = 5, prob = 0.7)
# [1] 0.1588261


# 7
dpois(0, lambda = 0.5)
# [1] 0.6065307

ppois(1, lambda = 0.5, lower.tail = FALSE)
# [1] 0.09020401

dpois(0, lambda = 10 * 0.5)
# [1] 0.006737947



# 8
n <- 2000
p <- 0.001
lambda <- n * p

c(exact_P0 = dbinom(0, n, p), pois_P0 = dpois(0, lambda))
#  exact_P0   pois_P0 
# 0.1351999 0.1353353 

c(exact_P_ge4 = pbinom(3, n, p, lower.tail = FALSE),
  pois_P_ge4  = ppois(3, lambda, lower.tail = FALSE))
# exact_P_ge4  pois_P_ge4 
#   0.1427862   0.1428765 

err_pois <- function(n, p) {
  k <- 0:n
  max(abs(dbinom(k, n, p) - dpois(k, n * p)))
}

err_pois(2000, 0.001)
# [1] 0.0001354256