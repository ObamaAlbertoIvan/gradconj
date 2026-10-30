test_that("le filet 3 x 3 a la bonne forme", {
  A <- as.matrix(filet_ressorts(3))
  expect_equal(dim(A), c(9, 9))
  expect_equal(A, t(A))                       # symetrique
  expect_equal(diag(A), rep(4, 9))            # 4 sur la diagonale
  expect_equal(A[5, ], c(0, -1, 0, -1, 4, -1, 0, -1, 0))
})
test_that("cg donne la meme reponse que solve() sur un filet", {
  A <- filet_ressorts(10)
  f <- rep(0.01, 100)
  x_cg  <- cg(A, f, tol = 1e-10)$x
  x_ref <- as.vector(solve(A, f))
  expect_equal(x_cg, x_ref, tolerance = 1e-6)
})
