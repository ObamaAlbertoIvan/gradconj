install.packages("gifski")                # une seule fois
library(gifski)
devtools::load_all()
K <- matrix(c(11, -10, -10, 11), nrow = 2)
f <- c(1, 0)
cg_res <- cg(K, f, garder_points = TRUE)
sd_res <- descente_simple(K, f, maxit = 12, garder_points = TRUE)
pts_sd <- do.call(rbind, sd_res$points)           # 13 points
pts_cg <- do.call(rbind, cg_res$points)           # 3 points
energie <- function(u1, u2) 0.5 * (11 * u1^2 - 20 * u1 * u2 + 11 * u2^2) - u1
g <- seq(-0.3, 0.9, length.out = 100)
z <- outer(g, g, energie)
save_gif({
  for (k in 1:13) {                               # une image par pas
    contour(g, g, z, nlevels = 15, col = "grey60",
            xlab = "deplacement u1 (cm)", ylab = "deplacement u2 (cm)")
    lines(pts_sd[1:k, , drop = FALSE], type = "o", col = "red", pch = 16)
    lines(pts_cg[1:min(k, 3), , drop = FALSE], type = "o", col = "blue",
          pch = 16, lwd = 2)
    points(11/21, 10/21, pch = 8, cex = 2)
  }
}, gif_file = "zigzag.gif", width = 600, height = 500, delay = 0.6)
