#' Filet de masses reliees par des ressorts
#'
#' Matrice de raideur d'un filet de N x N masses (bords fixes, ressorts de raideur 1).
#'
#' @param N nombre de masses sur un cote.
#' @return Une matrice creuse de taille (N*N) x (N*N).
#' @export
filet_ressorts <- function(N) {
  n   <- N * N
  g   <- expand.grid(i = 1:N, j = 1:N)  # tous les couples (colonne i, ligne j)
  id  <- (g$j - 1) * N + g$i            # numero de chaque masse : 1, 2, ..., N*N
  d1  <- id[g$i < N]                    # masses qui ont un voisin a droite
  d2  <- id[g$j < N]                    # masses qui ont un voisin au-dessus
  Matrix::sparseMatrix(
    i = c(id, d1, d1 + 1, d2, d2 + N),  # numeros de lignes
    j = c(id, d1 + 1, d1, d2 + N, d2),  # numeros de colonnes
    x = c(rep(4, n), rep(-1, 2 * length(d1) + 2 * length(d2))),
    dims = c(n, n))
}
