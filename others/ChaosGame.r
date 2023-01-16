POINTS <- 5
DIST <- 0.5

ptsOnCircle <- function(zeta, r = 1) {
  x <- sin(zeta)
  y <- sqrt(r^2 - x^2)
  if((zeta > pi/2) & (zeta < 3*pi/2)) y <- -y
  
  return(c(x = x, y = y))
}

getPoints <- function(n, r = 1) {
  s <- seq_len(n) - 1
  zeta <- 2*pi*s/n
  #message(sprintf("angles: %s"zeta)
  pts <- sapply(zeta, ptsOnCircle)
  
  return(t(pts))
}

plotChaos <- function(pts, max = 1) {
  lims <- c(-max, max)
  cols <- ifelse(pts[[1]]^2 + pts[[2]]^2 == max^2, "red", "black")
  plot(pts, xlim = lims, ylim = lims, col = cols, pch = 16)
}

chaosPoint <- function(vertex, dist, start = NA) {
  if(is.na(start)) {
    cp <- runif(2, max = max(vertex), min = min(vertex))
    names(cp) <- c("x", "y")
    
    
  }
  
  n <- len(vertex)
  idx <- sample(n, 1)
  v <- vertex[idx, ]
  x <- (v$x - start$x) * dist + start$x
  y <- (v$y - start$y) * dist + start$y
  return(c(x = x, y = y))
}