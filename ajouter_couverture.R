# =====================================================================
# ajouter_couverture.R : ajoute une page de couverture au site.
# 1) Change les 3 lignes juste en dessous (MATIERE, ENCADRANT, ANNEE).
# 2) Mets le logo de l'ecole (png ou jpg) sur le Bureau ou dans
#    Telechargements, avec un nom qui commence par "logo".
# 3) Selectionne tout (Ctrl + A) puis Ctrl + Entree.
# =====================================================================

MATIERE   <- "INTRODUCTION A R"      # entre guillemets, ex : "Programmation en R"
ENCADRANT <- "M.NGNEUMEU IVAN"                       # facultatif, ex : "Pr. Nom" (laisse "" pour ne rien afficher)
ANNEE     <- "2026-2027"              # annee academique

if (!file.exists("DESCRIPTION")) stop("Ouvre d'abord le projet gradconj dans RStudio.")

# --- le logo -----------------------------------------------------------
dossiers <- c(getwd(), file.path(Sys.getenv("USERPROFILE"),
              c("Desktop", "Bureau", "OneDrive/Desktop", "OneDrive/Bureau", "Downloads")))
logos <- list.files(dossiers, pattern = "^logo.*\\.(png|jpg|jpeg)$",
                    full.names = TRUE, ignore.case = TRUE)
if (length(logos) > 0) {
  ext <- tolower(tools::file_ext(logos[1]))
  nom <- paste0("logo_ecole.", ext)
  dir.create("man/figures", recursive = TRUE, showWarnings = FALSE)
  file.copy(logos[1], file.path("man/figures", nom), overwrite = TRUE)
  img <- paste0("<img src='man/figures/", nom, "' alt='Logo' style='height:110px;margin-bottom:18px'>")
  message("Logo utilise : ", logos[1])
} else {
  img <- ""
  message("ATTENTION : aucun logo trouve (nom qui commence par logo). La couverture sera faite sans logo.")
}

# --- la couverture -----------------------------------------------------
lien <- "https://obamaalbertoivan.github.io/gradconj/articles/comprendre.html"
enc  <- if (nzchar(ENCADRANT)) paste0("<p style='margin:4px 0 0'>Encadrant : ", ENCADRANT, "</p>") else ""
couv <- c(
  "<!-- debut-couverture -->",
  "<div style='min-height:85vh;display:flex;flex-direction:column;justify-content:center;align-items:center;text-align:center;padding:30px 10px;'>",
  img,
  "<p style='font-size:1.1rem;color:#1F2933;margin:0'><b>\u00c9cole Nationale Sup\u00e9rieure Polytechnique de Douala</b><br>Universit\u00e9 de Douala</p>",
  "<div style='width:80px;height:4px;background:#E8710A;margin:22px 0'></div>",
  paste0("<p style='font-size:1.2rem;color:#E8710A;letter-spacing:2px;text-transform:uppercase;margin:0'>", MATIERE, "</p>"),
  "<p style='color:#0B6E6E;font-size:2.8rem;font-weight:bold;margin:14px 0 6px'>Le gradient conjugu\u00e9</p>",
  "<p style='font-size:1.25rem;color:#1F2933;margin:0 0 26px'>De l'id\u00e9e \u00e0 l'ing\u00e9nierie : un package R</p>",
  "<p style='margin:0'>Pr\u00e9sent\u00e9 par <b>Albert Ivan EYENGA OBAMA</b></p>",
  enc,
  paste0("<p style='color:#666;margin:4px 0 0'>Ann\u00e9e acad\u00e9mique ", ANNEE, "</p>"),
  paste0("<p style='margin-top:28px'><a href='", lien, "' style='background:#0B6E6E;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-size:1.1rem'>Entrer dans le site &rarr;</a></p>"),
  "</div>",
  "<!-- fin-couverture -->",
  "",
  "---",
  "")

# --- on place la couverture avant le contenu du README -------------------
x <- readLines("README.md", encoding = "UTF-8", warn = FALSE)
d <- grep("debut-couverture", x)
f <- grep("fin-couverture", x)
if (length(d) == 1 && length(f) == 1) x <- x[-(d:min(length(x), f + 3))]   # ancienne couverture
writeLines(c(couv, x), "README.md", useBytes = TRUE)
message("README.md mis a jour.")

# --- on reconstruit le site -------------------------------------------------
options(pkgdown.internet = FALSE)
pkgdown::build_site(preview = FALSE)
message("\nTERMINE. Ouvre docs/index.html pour voir la couverture.")
