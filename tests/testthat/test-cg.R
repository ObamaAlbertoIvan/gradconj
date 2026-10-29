test_that("cg trouve la solution des deux masses", {
  K <- matrix(c(11, -10, -10, 11), nrow = 2)
  res <- cg(K, c(1, 0))
  expect_equal(res$x, c(11/21, 10/21), tolerance = 1e-6)
  expect_lte(res$iterations, 3)
})
test_that("cg donne la meme reponse que solve()", {
  K <- matrix(c(11, -10, -10, 11), nrow = 2)
  expect_equal(cg(K, c(1, 0))$x, as.vector(solve(K, c(1, 0))), tolerance = 1e-6)
})
