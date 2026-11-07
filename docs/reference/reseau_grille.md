# Matrice d'un reseau en grille

Matrice d'un reseau de N x N noeuds (les intersections d'un quartier,
les noeuds d'un circuit...). Chaque noeud est relie a ses 4 voisins par
un lien de conductance 1 ; les liens qui sortent de la grille vont vers
une reference fixe (la pression du reseau d'alimentation, la masse...).
D'ou 4 sur la diagonale et -1 vers chaque voisin.

## Usage

``` r
reseau_grille(N)
```

## Arguments

- N:

  nombre de noeuds sur un cote.

## Value

Une matrice creuse de taille (N*N) x (N*N).

## Examples

``` r
as.matrix(reseau_grille(3))
#>       [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9]
#>  [1,]    4   -1    0   -1    0    0    0    0    0
#>  [2,]   -1    4   -1    0   -1    0    0    0    0
#>  [3,]    0   -1    4    0    0   -1    0    0    0
#>  [4,]   -1    0    0    4   -1    0   -1    0    0
#>  [5,]    0   -1    0   -1    4   -1    0   -1    0
#>  [6,]    0    0   -1    0   -1    4    0    0   -1
#>  [7,]    0    0    0   -1    0    0    4   -1    0
#>  [8,]    0    0    0    0   -1    0   -1    4   -1
#>  [9,]    0    0    0    0    0   -1    0   -1    4
```
