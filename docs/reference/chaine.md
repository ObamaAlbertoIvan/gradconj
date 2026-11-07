# Matrice d'une chaine de noeuds

Construit la matrice K d'une chaine : des noeuds alignes, relies entre
eux (et aux deux bouts) par des liens de conductance g. La meme matrice
sert pour un circuit (resistances), un mur (couches) ou un immeuble
(etages) : seule l'interpretation change.

## Usage

``` r
chaine(g)
```

## Arguments

- g:

  vecteur des conductances des liens, dans l'ordre. Une chaine de n
  noeuds a n + 1 liens : un avant le premier noeud, un entre chaque
  paire de noeuds, un apres le dernier. Un lien egal a 0 laisse le bout
  libre (le toit d'un immeuble, par exemple).

## Value

Une matrice symetrique de taille n x n, avec n = length(g) - 1.

## Examples

``` r
chaine(c(1, 10, 1))  # circuit a deux noeuds : 11, -10, -10, 11
#>      [,1] [,2]
#> [1,]   11  -10
#> [2,]  -10   11
```
