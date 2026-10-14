

f <- function(x){
    x ^ 2
}


f1 <- function(x){
    (y <- x ^ 2)
}


f2 <- function(x){
    y <- x ^ 2
    return(y)
}