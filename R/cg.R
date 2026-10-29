#' Gradient conjugue
#'
#' Resout le systeme A x = b quand A est symetrique definie positive.
#'
#' @param A matrice du systeme (ordinaire ou creuse).
#' @param b second membre (un vecteur).
#' @param x0 point de depart (par defaut : que des zeros).
#' @param tol on s'arrete quand la force restante est plus petite que
#'   tol fois la taille de b.
#' @param maxit nombre maximal d'iterations (securite).
#' @param garder_points si TRUE, on garde chaque approximation (pour les graphiques).
#' @return Une liste : x (la solution), iterations, residu, historique, points.
#' @export
cg <- function(A, b, x0 = rep(0, length(b)), tol = 1e-8,
               maxit = 10 * length(b), garder_points = FALSE) {
  x  <- x0                              # approximation de depart
  r  <- b - as.vector(A %*% x)          # r = force non equilibree
  p  <- r                               # premiere direction : la force
  rs <- sum(r * r)                      # r^T r (taille de la force au carre)
  nb <- sqrt(sum(b * b))                # taille de b, sert pour l'arret
  historique <- sqrt(rs)
  points <- list(x)
  k  <- 0
  while (sqrt(rs) > tol * nb && k < maxit) {
    Ap     <- as.vector(A %*% p)        # le seul produit matrice-vecteur
    alpha  <- rs / sum(p * Ap)          # longueur du pas
    x      <- x + alpha * p             # on avance
    r      <- r - alpha * Ap            # nouvelle force restante
    rs_new <- sum(r * r)
    p      <- r + (rs_new / rs) * p     # nouvelle direction (conjuguee)
    rs     <- rs_new
    k      <- k + 1
    historique <- c(historique, sqrt(rs))
    if (garder_points) points[[k + 1]] <- x
  }
  list(x = x, iterations = k, residu = sqrt(rs), historique = historique,
       points = if (garder_points) points)
}
