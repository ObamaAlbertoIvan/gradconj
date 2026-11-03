test_that("chaine reproduit le circuit a deux noeuds", {
  K <- chaine(c(1, 10, 1))
  expect_equal(K, matrix(c(11, -10, -10, 11), nrow = 2))
})

test_that("chaine : un lien nul laisse le dernier noeud libre", {
  A <- chaine(c(5, 5, 5, 0))
  expect_equal(dim(A), c(3, 3))
  expect_equal(A[3, 3], 5)
  expect_equal(A, t(A))
})

test_that("reseau d'eau 3 x 3 : les pressions attendues", {
  A <- reseau_grille(3)
  f <- c(0, 0, 0, 0, 8, 0, 0, 0, 0)
  res <- cg(A, f)
  expect_equal(res$x, c(0.5, 1, 0.5, 1, 3, 1, 0.5, 1, 0.5), tolerance = 1e-6)
})

test_that("la grille 3 x 3 a la bonne forme", {
  A <- as.matrix(reseau_grille(3))
  expect_equal(dim(A), c(9, 9))
  expect_equal(A, t(A))
  expect_equal(diag(A), rep(4, 9))
  expect_equal(A[5, ], c(0, -1, 0, -1, 4, -1, 0, -1, 0))
})

test_that("cg donne la meme reponse que solve() sur une grille", {
  A <- reseau_grille(10)
  f <- rep(0.1, 100)
  expect_equal(cg(A, f, tol = 1e-10)$x, as.vector(solve(A, f)), tolerance = 1e-6)
})

test_that("immeuble de 10 etages : deplacement du toit et derive", {
  A <- chaine(c(rep(1e5, 10), 0))
  res <- cg(A, rep(30, 10))
  expect_equal(res$x[10], 0.0165, tolerance = 1e-5)
  expect_equal(max(diff(c(0, res$x))), 0.003, tolerance = 1e-5)
})

test_that("mur : le flux calcule egale la formule des resistances en serie", {
  e   <- c(0.02, 0.20, 0.05, 0.02)
  lam <- c(1.0, 1.4, 0.04, 0.35)
  m   <- c(2, 10, 5, 2)
  g   <- rep(lam * m / e, times = m)
  n   <- length(g) - 1
  b   <- rep(0, n)
  b[1] <- g[1] * 35
  b[n] <- b[n] + g[n + 1] * 22
  temp <- cg(chaine(g), b)$x
  flux <- g[1] * (35 - temp[1])
  expect_equal(flux, (35 - 22) / sum(1 / g), tolerance = 1e-5)
})
