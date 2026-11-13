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