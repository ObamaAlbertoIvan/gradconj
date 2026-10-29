#' Descente de gradient (pour comparer)
#'
#' Meme chose que cg(), mais on suit seulement la plus forte pente.
#'
#' @inheritParams cg
#' @return Une liste : x, iterations, residu, historique, points.
#' @export
descente_simple <- function(A, b, x0 = rep(0, length(b)), tol = 1e-8,
                            maxit = 100000, garder_points = FALSE) {
  x  <- x0
  r  <- b - as.vector(A %*% x)          # force non equilibree
  nb <- sqrt(sum(b * b))
  historique <- sqrt(sum(r * r))
  points <- list(x)
  k  <- 0
  while (historique[length(historique)] > tol * nb && k < maxit) {
    Ar    <- as.vector(A %*% r)
    alpha <- sum(r * r) / sum(r * Ar)   # pas optimal le long de la pente
    x     <- x + alpha * r              # on suit la pente (la force r)
    r     <- r - alpha * Ar
    k     <- k + 1
    historique <- c(historique, sqrt(sum(r * r)))
    if (garder_points) points[[k + 1]] <- x
  }
  list(x = x, iterations = k, residu = historique[length(historique)],
       historique = historique, points = if (garder_points) points)
}
