devtools::load_all()
library(Matrix)
tailles <- c(10, 20, 30, 40, 50)         # N : le filet a N x N masses
resultats <- data.frame()
for (N in tailles) {
  A <- filet_ressorts(N)                 # matrice creuse
  f <- rep(0.01, N * N)                  # 0,01 N sur chaque masse
  # 1) Cholesky classique : on traite A comme une matrice pleine
  t_dense <- system.time({
    R  <- chol(as.matrix(A))             # A = R^T R
    x1 <- backsolve(R, forwardsolve(t(R), f))
  })[["elapsed"]]
  # 2) Cholesky creux : il profite des zeros de A
  t_creux <- system.time({
    x2 <- as.vector(solve(Cholesky(forceSymmetric(A)), f))
  })[["elapsed"]]
  # 3) Gradient conjugue
  t_cg <- system.time({
    res <- cg(A, f)
  })[["elapsed"]]
  resultats <- rbind(resultats,
                     data.frame(N = N, n = N * N, dense = t_dense, creux = t_creux,
                                cg = t_cg, iterations = res$iterations))
  cat("N =", N, " ecart entre CG et Cholesky :", max(abs(res$x - x1)), "\n")
}
print(resultats)
temps <- pmax(as.matrix(resultats[, c("dense", "creux", "cg")]), 0.001)
matplot(resultats$n, temps, type = "b", log = "xy", lty = 1,
        pch = c(15, 17, 16), col = c("grey40", "red", "blue"),
        xlab = "nombre d'inconnues n", ylab = "temps (secondes)")
legend("topleft", legend = c("Cholesky classique", "Cholesky creux", "gradient conjugue"),
       col = c("grey40", "red", "blue"), pch = c(15, 17, 16), lty = 1, bty = "n")
