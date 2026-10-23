
set.seed(2026)



B <- 10000L
zar <- sample.int(6L, size = B, replace = TRUE)

rezultat <- table(zar)

# Afisarea rezultatelor in consola
print(rezultat)

# Calcul vectorial: proportia aruncarilor cu fete mai mari sau egale cu 5
proportie_mari <- mean(zar >= 5)
print(paste("Proportia zarurilor >= 5 este:", proportie_mari))

# Generarea unui grafic de bare cu frecventele obtinute
barplot(rezultat, col = "#A62976")