devtools::load_all()
N <- 30
A <- filet_ressorts(N)                           # 900 masses
f <- rep(0.01, N * N)
cg_res <- cg(A, f)
sd_res <- descente_simple(A, f)
cg_res$iterations                                # attendu : 55
sd_res$iterations                                # attendu : environ 3559
taille_f <- sqrt(sum(f * f))                     # pour comparer a 1 au depart
plot(sd_res$historique / taille_f, type = "l", log = "y", col = "red",
     xlab = "numero d'iteration",
     ylab = "force restante (relative, echelle log)")
lines(cg_res$historique / taille_f, col = "blue", lwd = 2)
abline(h = 1e-8, lty = 2, col = "grey50")        # precision visee
legend("topright", legend = c("descente simple", "gradient conjugue"),
       col = c("red", "blue"), lty = 1, bty = "n")
