# Demo en direct pour l'expose : selectionne un bloc, puis Ctrl+Entree.
# Les resultats attendus sont ecrits a droite de chaque ligne.
devtools::load_all()

# 1. Le circuit a deux noeuds -------------------------------------------
K <- chaine(c(1, 10, 1))        # la matrice : 11, -10, -10, 11
f <- c(1, 0)                    # 1 A injecte au noeud 1
K
res <- cg(K, f)
res$x                           # 0.5238095 0.4761905 (volts)
res$iterations                  # 2
descente_simple(K, f)$iterations  # 194 : beaucoup plus long

# 2. L'eau d'un quartier de 1 600 intersections --------------------------
A <- reseau_grille(40)
f <- rep(0.1, 40 * 40)          # 0,1 L/s a chaque intersection
res <- cg(A, f)
res$iterations                  # 74
max(res$x)                      # 12.36586 : chute de pression maximale (m)
image(matrix(res$x, 40), col = hcl.colors(50, "YlOrRd", rev = TRUE))

# 3. Un immeuble de 10 etages sous le vent -------------------------------
A <- chaine(c(rep(1e5, 10), 0))
u <- cg(A, rep(30, 10))$x * 1000
round(u, 1)                     # 3.0 5.7 8.1 ... 16.5 (mm)

# 4. Les tests -----------------------------------------------------------
devtools::test()                # FAIL 0 | PASS 17
