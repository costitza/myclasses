# 1
# 1. P(T > 3)
pexp(3, rate = 1/3, lower.tail = FALSE)
# [1] 0.3678794

# 2. P(T > 12 | T > 9)
pexp(12, rate = 1/3, lower.tail = FALSE) / pexp(9, rate = 1/3, lower.tail = FALSE)
# [1] 0.3678794



# 2
p_efic <- 0.75
p_inefic <- 0.25

prob_2_efic <- dpois(2, lambda = 3)
prob_2_inefic <- dpois(2, lambda = 5)

p_efic * prob_2_efic / (p_efic * prob_2_efic + p_inefic * prob_2_inefic)
# Rezultat: 0.8886416


# 3
# lot acceptat: 0 defecte din 5 extrase (5 defecte, 95 bune)
p_acceptat <- dhyper(0, m = 5, n = 95, k = 5)
p_acceptat
# [1] 0.7695911

p_respins <- 1 - p_acceptat
p_respins
# [1] 0.2304089

p_pas3 <- (95/100) * (94/99) * (5/98)
p_pas3
# [1] 0.04602144

# 4
# Calcul direct pentru coada superioară P(X > 176)  
pnorm(176, mean = 173, sd = 4, lower.tail = FALSE)
# [1] 0.2266274

# Sau prin standardizare Z = (176 - 173) / 4 = 0.75:
pnorm(0.75, lower.tail = FALSE)
# [1] 0.2266274



# 5
n <- 5
p <- 150 / 250 

dbinom(4, size = n, prob = p)                        
# P(X = 4) -> 0.2592
pbinom(0, size = n, prob = p, lower.tail = FALSE)    
# P(X >= 1/2) = P(X > 0) -> 0.98976
pbinom(floor(pi/3), size = n, prob = p)              
# P(X < pi/3) = P(X <= 1) -> 0.08704

# P(X <= 2 | X > 0.2) = P(1 <= X <= 2) / P(X >= 1)
(pbinom(2, n, p) - pbinom(0, n, p)) / pbinom(0, n, p, lower.tail = FALSE)
# [1] 0.3103783

# 3. F_X(7/2)
pbinom(7/2, size = n, prob = p)                      
# 0.66304

# 4. Media si varianta
c(media = n * p, varianta = n * p * (1 - p))         
# 3.0 si 1.2


# 6
k <- 8
dnbinom(k, size = 10, prob = 0.5)
# [1] 0.09273529

choose(8 + 9, 8) * (0.5)^(8 + 10)
# [1] 0.09273529



# 7
c_val <- qnorm(0.85, mean = 3, sd = 7)
c_val
# [1] 10.25503

pnorm(c_val, mean = 3, sd = 7, lower.tail = FALSE)
# [1] 0.15


# Verificare T8 în R
a <- 6
b <- 8

# 1. Constanta k = 1 / B(6, 8)
k <- 1 / beta(a, b)
k
# [1] 10296

# Verificarea integralei densității
integrate(function(x) k * x^5 * (1 - x)^7, lower = 0, upper = 1)$value
# [1] 1

# 2. Media și varianța
c(media = a / (a + b), varianta = (a * b) / ((a + b)^2 * (a + b + 1)))
#     media  varianta 
# 0.4285714 0.0163265



# Verificare T9 în R
lambda <- (1 / 10) * 30  # 3 sosiri în 30 de minute

# 1. P(X = 0)
dpois(0, lambda = lambda)
# [1] 0.04978707

# 2. P(X >= 4) = P(X > 3)
ppois(3, lambda = lambda, lower.tail = FALSE)
# [1] 0.3527681


m <- 50
n <- 200
k <- 5

dhyper(1, m, n, k)
# [1] 0.4127978

phyper(2, m, n, k, lower.tail = FALSE)
# [1] 0.05605949

phyper(floor(pi / 3), m, n, k)
# [1] 0.7371729

(phyper(2, m, n, k) - phyper(0, m, n, k)) / phyper(0, m, n, k, lower.tail = FALSE)
# [1] 0.9156262

phyper(11 / 5, m, n, k)
# [1] 0.9429947

c(media = k * m / (m + n), varianta = k * (m / (m + n)) * (n / (m + n)) * ((m + n - k) / (m + n - 1)))
#     media  varianta 
# 1.0000000 0.7871486


# 11
p_B <- 0.01
p_Bc <- 1 - p_B
p_poz_dat_B <- 0.9
p_neg_dat_Bc <- 0.9
p_poz_dat_Bc <- 1 - p_neg_dat_Bc
p_neg_dat_B <- 1 - p_poz_dat_B

p_poz <- p_B * p_poz_dat_B + p_Bc * p_poz_dat_Bc
p_B_dat_poz <- (p_B * p_poz_dat_B) / p_poz
p_B_dat_poz
# [1] 0.08333333

p_neg <- 1 - p_poz
p_Bc_dat_neg <- (p_Bc * p_neg_dat_Bc) / p_neg
p_Bc_dat_neg
# [1] 0.9988789


# 12
a <- 11
b <- 1 / 30
k <- 1 / (factorial(10) * 30^12)
k
# [1] 5.182071e-25

integrate(function(x) 30 * k * x^10 * exp(-x / 30), lower = 0, upper = Inf)$value
# [1] 1

c(media = a / b, varianta = a / b^2)
#    media varianta 
#      330     9900


# 13
p_B <- 1 / 100000
p_Bc <- 1 - p_B
p_poz_dat_B <- 0.95
p_poz_dat_Bc <- 0.005

p_B_dat_poz <- (p_B * p_poz_dat_B) / (p_B * p_poz_dat_B + p_Bc * p_poz_dat_Bc)
p_B_dat_poz
# [1] 0.001896416



# 14
b <- 4
c <- 6
d <- 2
n <- 5
k <- 3

p_A2 <- (c / (b + c)) * ((c + d) / (b + c + d)) + (b / (b + c)) * (c / (b + c + d))
c(calculat = p_A2, teoretic = c / (b + c))
# calculat teoretic 
#      0.6      0.6

p_A1_dat_A2 <- ((c / (b + c)) * ((c + d) / (b + c + d))) / p_A2
c(calculat = p_A1_dat_A2, teoretic = (c + d) / (b + c + d))
# calculat teoretic 
# 0.6666667 0.6666667


# 15
lambda <- 1 / 20

pexp(20, rate = lambda, lower.tail = FALSE)
# [1] 0.3678794

pexp(40, rate = lambda) - pexp(20, rate = lambda)
# [1] 0.2325442

pexp(35, rate = lambda, lower.tail = FALSE) / pexp(15, rate = lambda, lower.tail = FALSE)
# [1] 0.3678794


# 17
punif(10, min = 0, max = 30, lower.tail = FALSE)
# [1] 0.6666667

punif(20, min = 0, max = 30) - punif(10, min = 0, max = 30)
# [1] 0.3333333

punif(25, min = 0, max = 30, lower.tail = FALSE)
# [1] 0.1666667


# 18
p <- 0.05

dgeom(9, prob = p)
# [1] 0.03151247

pgeom(5, prob = p)
# [1] 0.2649081

pgeom(3, prob = p, lower.tail = FALSE)
# [1] 0.8145063

# 19
a <- 4
b <- 2

c(media = a / b, varianta = a / b^2)
#    media varianta 
#        2        1

c(gamma = pgamma(3, shape = a, rate = b), poisson = ppois(3, lambda = 6, lower.tail = FALSE))
#     gamma   poisson 
# 0.8487961 0.8487961

t95 <- qgamma(0.95, shape = a, rate = b)
t95
# [1] 3.876822

set.seed(2419)
T_sim <- rowSums(matrix(rexp(100000 * 4, rate = b), ncol = 4))
c(media_sim = mean(T_sim), var_sim = var(T_sim), acoperire_t95 = mean(T_sim <= t95))
#     media_sim       var_sim acoperire_t95 
#     2.0011484     1.0029758     0.9502300