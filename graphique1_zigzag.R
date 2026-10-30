devtools::load_all()
K <- matrix(c(11, -10, -10, 11), nrow = 2)
# les deux masses
f <- c(1, 0)
cg_res <- cg(K, f, garder_points = TRUE)
sd_res <- descente_simple(K, f, maxit = 12, garder_points = TRUE)   # 12 pas seulement
# l'energie du systeme en un point (u1, u2)
energie <- function(u1, u2) 0.5 * (11 * u1^2 - 20 * u1 * u2 + 11 * u2^2) - u1
g <- seq(-0.3, 0.9, length.out = 100)
z <- outer(g, g, energie)                        # energie en chaque point du plan
contour(g, g, z, nlevels = 15, col = "grey60",
        xlab = "deplacement u1 (cm)", ylab = "deplacement u2 (cm)")
pts_sd <- do.call(rbind, sd_res$points)          # liste de points -> tableau
pts_cg <- do.call(rbind, cg_res$points)
lines(pts_sd, type = "o", col = "red",  pch = 16)
lines(pts_cg, type = "o", col = "blue", pch = 16, lwd = 2)
points(11/21, 10/21, pch = 8, cex = 2)           # etoile = solution exacte
legend("topleft", legend = c("descente simple (12 pas)", "gradient conjugue"),
       col = c("red", "blue"), lty = 1, pch = 16, bty = "n")
