# gradconj
Le gradient conjugué en R : comprendre la méthode, la comparer à Cholesky
et l'appliquer à des systèmes de masses reliées par des ressorts.

## Installation
```r
install.packages("remotes")
remotes::install_github("ObamaAlbertIvan/gradconj")
```
## Exemple
```r
library(gradconj)
K <- matrix(c(11, -10, -10, 11), nrow = 2)   # deux masses, ressort central raide
cg(K, c(1, 0))$x                             # 0.5238095 0.4761905
```

