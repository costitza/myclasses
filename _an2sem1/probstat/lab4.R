


rbinom(5, 7, 0.2)


x <- rbinom(10^5, 7, 0.5)
hist(x, breaks = seq(-0.5, 7.5, 1))

# barplot(x)
p0 <- length(x[x == 0]) / 1e5
p1 <- length(x[x == 1]) / 1e5
p2 <- length(x[x == 2]) / 1e5
p3 <- length(x[x == 3]) / 1e5
p4 <- length(x[x == 4]) / 1e5
p5 <- length(x[x == 5]) / 1e5
p6 <- length(x[x == 6]) / 1e5
p7 <- length(x[x == 7]) / 1e5


d <- dbinom(0 : 7, 7, 0.5)
p <- c(p0, p1, p2, p3, p4, p5,p6, p7)
p


plot(0 : 7, d, type = "h", col = "magenta")



plot(0 : 7, dbinom(0 : 7, 7, 0.8), type = "h", col = "magenta")

plot(0 : 100, dbinom(0 : 100, 100, 0.5), type = "h", col = "magenta")

0.5 ^ 100


# dintro urna cu doua culori (10 magenta, 90 negre) se extrag 5 bile fara revenire
# calculati probabilitatea de a obtine 0, 1, 2, 3, 4, sau 5 bile magenta
x <- dhyper(0 : 5, 10, 90, 5)
hist(x)
plot(0 : 5, x, type = "h")
