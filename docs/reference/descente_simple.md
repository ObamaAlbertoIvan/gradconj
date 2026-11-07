# Descente de gradient (pour comparer)

Meme chose que cg(), mais on suit seulement la plus forte pente.

## Usage

``` r
descente_simple(
  A,
  b,
  x0 = rep(0, length(b)),
  tol = 1e-08,
  maxit = 1e+05,
  garder_points = FALSE
)
```

## Arguments

- A:

  matrice du systeme (ordinaire ou creuse).

- b:

  second membre (un vecteur).

- x0:

  point de depart (par defaut : que des zeros).

- tol:

  on s'arrete quand la force restante est plus petite que tol fois la
  taille de b.

- maxit:

  nombre maximal d'iterations (securite).

- garder_points:

  si TRUE, on garde chaque approximation (pour les graphiques).

## Value

Une liste : x, iterations, residu, historique, points.
