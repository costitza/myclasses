
medie <- function(f, lower = -Inf, upper = Inf) {
  de_integrat <- function(x) {
    x * f(x)
  }
  rezultat <- integrate(de_integrat, lower = lower, upper = upper)
  return(rezultat$value)
}


varianta_continua <- function(f, lower = -Inf, upper = Inf) {

  mu <- medie_continua(f, lower = lower, upper = upper)
  
  de_integrat <- function(x) {
    (x - mu)^2 * f(x)
  }
  rezultat <- integrate(de_integrat, lower = lower, upper = upper)
  return(rezultat$value)
}
