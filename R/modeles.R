#' Matrice d'une chaine de noeuds
#'
#' Construit la matrice K d'une chaine : des noeuds alignes, relies entre eux
#' (et aux deux bouts) par des liens de conductance g.
#' La meme matrice sert pour un circuit (resistances), un mur (couches)
#' ou un immeuble (etages) : seule l'interpretation change.
#'
#' @param g vecteur des conductances des liens, dans l'ordre. Une chaine de
#'   n noeuds a n + 1 liens : un avant le premier noeud, un entre chaque
#'   paire de noeuds, un apres le dernier. Un lien egal a 0 laisse le bout
#'   libre (le toit d'un immeuble, par exemple).
#' @return Une matrice symetrique de taille n x n, avec n = length(g) - 1.
#' @examples
#' chaine(c(1, 10, 1))  # circuit a deux noeuds : 11, -10, -10, 11
#' @export
chaine <- function(g) {
  n <- length(g) - 1                          # nombre de noeuds
  if (n < 1) stop("g doit contenir au moins 2 valeurs")
  A <- diag(g[1:n] + g[2:(n + 1)], nrow = n)  # diagonale : somme des 2 liens du noeud
  if (n > 1) {
    for (i in 1:(n - 1)) {
      A[i, i + 1] <- -g[i + 1]                # le lien entre les noeuds i et i+1
      A[i + 1, i] <- -g[i + 1]
    }
  }
  A
}

#' Matrice d'un reseau en grille
#'
#' Matrice d'un reseau de N x N noeuds (les intersections d'un quartier,
#' les noeuds d'un circuit...). Chaque noeud est relie a ses 4 voisins par
#' un lien de conductance 1 ; les liens qui sortent de la grille vont vers
#' une reference fixe (la pression du reseau d'alimentation, la masse...).
#' D'ou 4 sur la diagonale et -1 vers chaque voisin.
#'
#' @param N nombre de noeuds sur un cote.
#' @return Une matrice creuse de taille (N*N) x (N*N).
#' @examples
#' as.matrix(reseau_grille(3))
#' @export
reseau_grille <- function(N) {
  n   <- N * N
  g   <- expand.grid(i = 1:N, j = 1:N)  # tous les couples (colonne i, ligne j)
  id  <- (g$j - 1) * N + g$i            # numero de chaque noeud : 1, 2, ..., N*N
  d1  <- id[g$i < N]                    # noeuds qui ont un voisin a droite
  d2  <- id[g$j < N]                    # noeuds qui ont un voisin au-dessus
  Matrix::sparseMatrix(
    i = c(id, d1, d1 + 1, d2, d2 + N),  # numeros de lignes
    j = c(id, d1 + 1, d1, d2 + N, d2),  # numeros de colonnes
    x = c(rep(4, n), rep(-1, 2 * length(d1) + 2 * length(d2))),
    dims = c(n, n))
}
