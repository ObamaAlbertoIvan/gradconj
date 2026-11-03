# =====================================================================
# ajouter_sommaire.R : ajoute la page "Sommaire" au site.
# Mode d'emploi : clique dans ce fichier, Ctrl + A, puis Ctrl + Entree.
# =====================================================================
if (!file.exists("DESCRIPTION")) stop("Ouvre d'abord le projet gradconj dans RStudio.")

decode <- function(s) {
  m <- gregexpr("<<u[0-9a-f]{4}>>", s)
  regmatches(s, m) <- lapply(regmatches(s, m), function(z)
    vapply(z, function(t) intToUtf8(strtoi(substr(t, 4, 7), 16L)), ""))
  s
}

# 1. la page
texte <- r"----(
---
title: "Sommaire"
---

Ce site pr<<u00e9>>sente le **gradient conjugu<<u00e9>>**, une m<<u00e9>>thode pour r<<u00e9>>soudre les syst<<u00e8>>mes d'<<u00e9>>quations $K u = f$, et le package R **gradconj** qui la programme. Voici le parcours conseill<<u00e9>> : environ **12 minutes**, dans l'ordre.

<div style="margin:1.5rem 0">

<a href="comprendre.html" style="display:block;border-left:6px solid #0B6E6E;background:#EAF4F4;padding:12px 18px;margin:10px 0;border-radius:0 10px 10px 0;text-decoration:none;color:#1F2933">
<b style="color:#0B6E6E;font-size:1.15rem">1. Comprendre</b> <span style="float:right;color:#E8710A">3 min</span><br>
L'id<<u00e9>>e avec un circuit simple : le <<u00ab>> bol <<u00bb>> de l'<<u00e9>>nergie, pourquoi la descente simple zigzague, et comment le gradient conjugu<<u00e9>> va droit au but.
</a>

<a href="eau.html" style="display:block;border-left:6px solid #0B6E6E;background:#EAF4F4;padding:12px 18px;margin:10px 0;border-radius:0 10px 10px 0;text-decoration:none;color:#1F2933">
<b style="color:#0B6E6E;font-size:1.15rem">2. L'eau</b> <span style="float:right;color:#E8710A">2 min</span><br>
Le m<<u00ea>>me calcul sur un quartier de 1 600 intersections : une matrice <<u00e9>>norme, mais presque vide.
</a>

<a href="analyser.html" style="display:block;border-left:6px solid #0B6E6E;background:#EAF4F4;padding:12px 18px;margin:10px 0;border-radius:0 10px 10px 0;text-decoration:none;color:#1F2933">
<b style="color:#0B6E6E;font-size:1.15rem">3. Analyser</b> <span style="float:right;color:#E8710A">2 min</span><br>
La vitesse de convergence, le conditionnement, et une comparaison honn<<u00ea>>te avec les autres m<<u00e9>>thodes.
</a>

<a href="appliquer.html" style="display:block;border-left:6px solid #E8710A;background:#FFF1E4;padding:12px 18px;margin:10px 0;border-radius:0 10px 10px 0;text-decoration:none;color:#1F2933">
<b style="color:#E8710A;font-size:1.15rem">4. Applications en ing<<u00e9>>nierie</b> <span style="float:right;color:#E8710A">3 min</span><br>
Hydraulique, g<<u00e9>>nie civil, g<<u00e9>>nie thermique, g<<u00e9>>nie <<u00e9>>lectrique : quatre probl<<u00e8>>mes d'ing<<u00e9>>nieur r<<u00e9>>solus avec le package.
</a>

<a href="validation.html" style="display:block;border-left:6px solid #0B6E6E;background:#EAF4F4;padding:12px 18px;margin:10px 0;border-radius:0 10px 10px 0;text-decoration:none;color:#1F2933">
<b style="color:#0B6E6E;font-size:1.15rem">5. Tests</b> <span style="float:right;color:#E8710A">1 min</span><br>
Comment v<<u00e9>>rifier que les r<<u00e9>>sultats sont justes : v<<u00e9>>rifications en direct et 17 tests automatiques.
</a>

<a href="../reference/index.html" style="display:block;border-left:6px solid #9AA5B1;background:#F4F6F8;padding:12px 18px;margin:10px 0;border-radius:0 10px 10px 0;text-decoration:none;color:#1F2933">
<b style="color:#1F2933;font-size:1.15rem">Package : la documentation</b><br>
Les 4 fonctions : <code>cg</code>, <code>descente_simple</code>, <code>chaine</code>, <code>reseau_grille</code>.
</a>

</div>

::: retenir
**En une phrase.** Beaucoup de probl<<u00e8>>mes d'ing<<u00e9>>nieur s'<<u00e9>>crivent $K u = f$ (circuit, r<<u00e9>>seau d'eau, b<<u00e2>>timent, mur). Le gradient conjugu<<u00e9>> les r<<u00e9>>sout en peu d'it<<u00e9>>rations, m<<u00ea>>me quand la matrice est <<u00e9>>norme.
:::
)----"
texte <- sub("^\n", "", texte)
texte <- sub("\n$", "", texte)
dir.create("vignettes/articles", recursive = TRUE, showWarnings = FALSE)
writeLines(decode(texte), "vignettes/articles/sommaire.Rmd", useBytes = TRUE)
message("page ecrite : vignettes/articles/sommaire.Rmd")

# 2. le menu (_pkgdown.yml)
y <- readLines("_pkgdown.yml", encoding = "UTF-8", warn = FALSE)
if (!any(grepl("^    sommaire:", y))) {
  y <- sub("left: [comprendre,", "left: [sommaire, comprendre,", y, fixed = TRUE)
  i <- grep("^  components:", y)
  if (length(i) != 1) stop("Je ne trouve pas la ligne components dans _pkgdown.yml")
  nouveau <- c("    sommaire:", "      text: \"Sommaire\"", "      href: articles/sommaire.html")
  y <- append(y, nouveau, after = i)
  writeLines(y, "_pkgdown.yml", useBytes = TRUE)
  message("menu mis a jour : _pkgdown.yml")
} else message("le menu contient deja Sommaire")

# 3. le bouton de la couverture mene au sommaire
if (file.exists("README.md")) {
  x <- readLines("README.md", encoding = "UTF-8", warn = FALSE)
  x <- gsub("articles/comprendre.html", "articles/sommaire.html", x, fixed = TRUE)
  writeLines(x, "README.md", useBytes = TRUE)
}

# 4. on reconstruit le site
options(pkgdown.internet = FALSE)
pkgdown::build_site(preview = FALSE)
message("\nTERMINE. Ouvre docs/index.html : le menu doit commencer par Sommaire.")
