test_that("descente_simple trouve aussi la solution des deux masses", {
  K <- matrix(c(11, -10, -10, 11), nrow = 2)
  res <- descente_simple(K, c(1, 0))
  expect_equal(res$x, c(11/21, 10/21), tolerance = 1e-6)
})
