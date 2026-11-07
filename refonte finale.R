# =====================================================================
# refonte_finale.R : reecrit le contenu du site (pages, style, couverture).
# 1) Remplis les 4 lignes juste en dessous (entre guillemets).
# 2) Clique dans ce fichier, Ctrl + A, puis Ctrl + Entree.
# =====================================================================

MATRICULE <- "24G00823"                       # ton matricule, ex : "21A1234"
MATIERE   <- "Introduction A R"  # nom de la mati\u00e8re
ENCADRANT <- "M. Ngneumeu Ivan"       # laisse "" pour ne rien afficher
ANNEE     <- "2026-2027"              # annee academique

if (!file.exists("DESCRIPTION")) stop("Ouvre d'abord le projet gradconj dans RStudio.")
if (nchar(trimws(MATRICULE)) == 0) stop("Ecris ton matricule entre les guillemets de la ligne MATRICULE, puis relance.")

decode <- function(s) {
  m <- gregexpr("<<u[0-9a-f]{4}>>", s)
  regmatches(s, m) <- lapply(regmatches(s, m), function(z)
    vapply(z, function(t) intToUtf8(strtoi(substr(t, 4, 7), 16L)), ""))
  s
}
ecrire <- function(chemin, texte) {
  dir.create(dirname(chemin), recursive = TRUE, showWarnings = FALSE)
  texte <- gsub("\r", "", texte, fixed = TRUE)
  texte <- sub("^\n", "", texte)
  texte <- sub("\n$", "", texte)
  writeLines(decode(texte), chemin, useBytes = TRUE)
  message("  ecrit : ", chemin)
}

message("=== 1/4  Ecriture des pages et du style ===")
ecrire("_pkgdown.yml", r"----(
url: https://obamaalbertoivan.github.io/gradconj/

home:
  title: Algorithme du gradient conjugu<<u00e9>>

template:
  bootstrap: 5
  bootswatch: flatly
  bslib:
    primary: "#0B6E6E"
    secondary: "#C65D0A"
    bg: "#FFFFFF"
    fg: "#1F2933"
    headings-color: "#0B6E6E"
    link-color: "#0B6E6E"
    font-size-base: 1.02rem

navbar:
  bg: primary
  type: dark
  structure:
    left: [sommaire, introduction, comprendre, eau, analyser, appliquer, validation, conclusion, package]
    right: [github]
  components:
    sommaire:
      text: "Sommaire"
      href: articles/sommaire.html
    introduction:
      text: "Introduction"
      href: articles/introduction.html
    comprendre:
      text: "1. Comprendre"
      href: articles/comprendre.html
    eau:
      text: "2. L'eau"
      href: articles/eau.html
    analyser:
      text: "3. Analyser"
      href: articles/analyser.html
    appliquer:
      text: "4. Applications"
      href: articles/appliquer.html
    validation:
      text: "5. Tests"
      href: articles/validation.html
    conclusion:
      text: "Conclusion"
      href: articles/conclusion.html
    package:
      text: "Package"
      href: reference/index.html
    github:
      icon: fab fa-github fa-lg
      href: https://github.com/ObamaAlbertoIvan/gradconj

reference:
  - title: "R<<u00e9>>soudre K u = f"
    contents:
      - cg
      - descente_simple
  - title: "Construire les mod<<u00e8>>les"
    contents:
      - chaine
      - reseau_grille
)----")
ecrire("pkgdown/extra.scss", r"----(
/* ===== Typographie ===== */
body { font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif; line-height: 1.7; color: #1F2933; }
h1 { color: #0B6E6E; font-weight: 700; letter-spacing: -0.3px; }
h2 { color: #0B6E6E; font-weight: 650; margin-top: 2.6rem; padding-bottom: 0.4rem;
     border-bottom: 2px solid #E3E8EC; position: relative; }
h2::after { content: ""; position: absolute; left: 0; bottom: -2px; width: 64px; height: 2px; background: #C65D0A; }
h3 { color: #1F2933; font-weight: 650; margin-top: 1.9rem; }
p, li { font-size: 1.02rem; }

/* ===== Barre de navigation ===== */
.navbar { box-shadow: 0 2px 6px rgba(0, 0, 0, 0.18); }
.navbar-nav .nav-link { font-weight: 500; font-size: 0.93rem; }

/* ===== Tableaux ===== */
table { width: 100%; border-collapse: collapse; margin: 1.3rem 0; font-size: 0.95rem; }
table thead th { background: #0B6E6E; color: #FFFFFF; padding: 0.55rem 0.8rem; border: none; font-weight: 600; }
table td { padding: 0.5rem 0.8rem; border-bottom: 1px solid #E3E8EC; vertical-align: top; }
table tbody tr:nth-child(even) { background: #F6F9FA; }

/* ===== Code ===== */
pre { background: #F6F8FA; border: 1px solid #E3E8EC; border-left: 4px solid #0B6E6E; border-radius: 6px; padding: 0.8rem 1rem; }
code { color: #0B5A5A; }
:not(pre) > code { background: #EEF3F4; padding: 0.1rem 0.35rem; border-radius: 4px; }

/* ===== Images ===== */
.contents img, main img { max-width: 100%; height: auto; border-radius: 6px; }

/* ===== Encadr<<u00e9>>s ===== */
.vous-allez { border-left: 5px solid #0B6E6E; background: #EDF5F5; padding: 0.9rem 1.3rem; margin: 1.4rem 0;
              border-radius: 0 8px 8px 0; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06); }
.retenir { border-left: 5px solid #C65D0A; background: #FFF3E8; padding: 0.9rem 1.3rem; margin: 1.6rem 0;
           border-radius: 0 8px 8px 0; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06); }
.attention { border-left: 5px solid #8896A4; background: #F4F6F8; padding: 0.9rem 1.3rem; margin: 1.4rem 0;
             border-radius: 0 8px 8px 0; font-size: 0.97rem; }
.conclusion { border: 2px solid #0B6E6E; background: #FFFFFF; padding: 0.9rem 1.3rem; margin: 1.8rem 0; border-radius: 8px; }

/* ===== Pied de page ===== */
footer { border-top: 1px solid #E3E8EC; color: #6B7785; font-size: 0.9rem; }
)----")
ecrire("vignettes/articles/sommaire.Rmd", r"----(
---
title: "Sommaire"
---

Ce site pr<<u00e9>>sente l'**algorithme du gradient conjugu<<u00e9>>**, une m<<u00e9>>thode pour r<<u00e9>>soudre de grands syst<<u00e8>>mes d'<<u00e9>>quations, et le package R **gradconj** qui le programme. Voici le plan, <<u00e0>> suivre dans l'ordre.

<div style="margin:1.5rem 0">
<a href='introduction.html' style='display:block;border-left:5px solid #0B6E6E;background:#EDF5F5;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#0B6E6E;font-size:1.1rem'>Introduction</b><br>L'algorithme du gradient conjugu<<u00e9>> : le probl<<u00e8>>me, l'id<<u00e9>>e, le plan.</a>
<a href='comprendre.html' style='display:block;border-left:5px solid #0B6E6E;background:#EDF5F5;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#0B6E6E;font-size:1.1rem'>1. Comprendre l'algorithme</b><br>Un petit circuit, le bol d'<<u00e9>>nergie, l'algorithme pas <<u00e0>> pas.</a>
<a href='eau.html' style='display:block;border-left:5px solid #0B6E6E;background:#EDF5F5;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#0B6E6E;font-size:1.1rem'>2. L'eau</b><br>La m<<u00ea>>me m<<u00e9>>thode sur un quartier de 1 600 intersections.</a>
<a href='analyser.html' style='display:block;border-left:5px solid #0B6E6E;background:#EDF5F5;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#0B6E6E;font-size:1.1rem'>3. Analyser</b><br>Rapidit<<u00e9>>, conditionnement, comparaison avec d'autres m<<u00e9>>thodes.</a>
<a href='appliquer.html' style='display:block;border-left:5px solid #C65D0A;background:#FFF3E8;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#C65D0A;font-size:1.1rem'>4. Applications en ing<<u00e9>>nierie</b><br>G<<u00e9>>nie civil (un immeuble sous le vent) et g<<u00e9>>nie thermique (isoler un mur).</a>
<a href='validation.html' style='display:block;border-left:5px solid #0B6E6E;background:#EDF5F5;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#0B6E6E;font-size:1.1rem'>5. Tests</b><br>Comment on v<<u00e9>>rifie que le programme est juste.</a>
<a href='conclusion.html' style='display:block;border-left:5px solid #0B6E6E;background:#EDF5F5;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#0B6E6E;font-size:1.1rem'>Conclusion</b><br>Ce qu'il faut retenir et pour aller plus loin.</a>
<a href='../reference/index.html' style='display:block;border-left:5px solid #6B7785;background:#F4F6F8;padding:12px 18px;margin:10px 0;border-radius:0 8px 8px 0;text-decoration:none;color:#1F2933'><b style='color:#6B7785;font-size:1.1rem'>Package : documentation</b><br>Les 4 fonctions : cg, descente_simple, chaine, reseau_grille.</a>
</div>

<p style='text-align:center;margin-top:30px'><a href='introduction.html' style='background:#C65D0A;color:#ffffff;padding:10px 24px;border-radius:6px;text-decoration:none;font-size:1.05rem'>Commencer : Introduction &rarr;</a></p>
)----")
ecrire("vignettes/articles/introduction.Rmd", r"----(
---
title: "Introduction : l'algorithme du gradient conjugu<<u00e9>>"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(fig.align = "center", fig.width = 6.5, fig.height = 4.5, dpi = 120)
library(gradconj)
```

::: vous-allez
**Dans cette introduction, vous allez comprendre :**

- ce qu'est un algorithme, et quel probl<<u00e8>>me celui-ci r<<u00e9>>sout ;
- pourquoi ce probl<<u00e8>>me est important en ing<<u00e9>>nierie ;
- l'id<<u00e9>>e du gradient conjugu<<u00e9>>, sans calcul ;
- le plan de la pr<<u00e9>>sentation.
:::

## Un algorithme, c'est quoi ?

Un **algorithme** est une suite d'instructions, toujours les m<<u00ea>>mes, qui permet <<u00e0>> un ordinateur de r<<u00e9>>soudre un probl<<u00e8>>me. Une recette de cuisine en est un bon exemple : on suit les <<u00e9>>tapes dans l'ordre et on obtient le plat.

L'**algorithme du gradient conjugu<<u00e9>>** r<<u00e9>>sout un probl<<u00e8>>me pr<<u00e9>>cis : trouver les inconnues d'un **syst<<u00e8>>me d'<<u00e9>>quations lin<<u00e9>>aires**.

## Le probl<<u00e8>>me <<u00e0>> r<<u00e9>>soudre

En math<<u00e9>>matiques, un syst<<u00e8>>me d'<<u00e9>>quations lin<<u00e9>>aires s'<<u00e9>>crit :

$$A\,x = b$$

- **A** est un tableau de nombres (une *matrice*), connu ;
- **b** est une liste de nombres, connue ;
- **x** est la liste des inconnues, que l'on cherche.

En ing<<u00e9>>nierie, on garde la m<<u00ea>>me <<u00e9>>quation, mais on change les lettres pour rappeler le sens physique :

$$K\,u = f$$

| Lettre | R<<u00f4>>le | Exemple (circuit <<u00e9>>lectrique) |
|:--|:--|:--|
| **f** | ce qu'on **impose** au syst<<u00e8>>me | un courant inject<<u00e9>> |
| **u** | ce qu'on **cherche** : la r<<u00e9>>action du syst<<u00e8>>me | les tensions aux n<<u0153>>uds |
| **K** | la **description du syst<<u00e8>>me** : comment ses <<u00e9>>l<<u00e9>>ments sont reli<<u00e9>>s | les conductances des fils |

C'est le m<<u00ea>>me probl<<u00e8>>me, avec des noms plus parlants. Dans la suite, on utilise la notation de l'ing<<u00e9>>nieur.

## O<<u00f9>> rencontre-t-on ce probl<<u00e8>>me ?

Partout o<<u00f9>> une quantit<<u00e9>> se r<<u00e9>>partit dans un r<<u00e9>>seau ou dans un milieu.

| Domaine | Ce qu'on impose (f) | Ce qu'on cherche (u) |
|:--|:--|:--|
| <<u00c9>>lectricit<<u00e9>> | des courants | des tensions |
| R<<u00e9>>seau d'eau | des d<<u00e9>>bits consomm<<u00e9>>s | des pressions |
| Construction | des forces (vent, charges) | des d<<u00e9>>placements |
| Thermique | de la chaleur | des temp<<u00e9>>ratures |

Une seule m<<u00e9>>thode de calcul sert donc <<u00e0>> plusieurs m<<u00e9>>tiers. C'est ce qui rend l'algorithme int<<u00e9>>ressant.

## Pourquoi un algorithme sp<<u00e9>>cial ?

Avec 2 ou 3 inconnues, on r<<u00e9>>sout <<u00e0>> la main. Mais un vrai probl<<u00e8>>me en compte **des milliers, voire des millions** : un r<<u00e9>>seau de 1 600 intersections, un b<<u00e2>>timent mod<<u00e9>>lis<<u00e9>> en d<<u00e9>>tail. Il faut alors une m<<u00e9>>thode **rapide**, qui n'utilise **pas trop de m<<u00e9>>moire**.

## L'id<<u00e9>>e du gradient conjugu<<u00e9>>

L'id<<u00e9>>e tient en trois phrases :

1. On transforme le probl<<u00e8>>me : au lieu de r<<u00e9>>soudre l'<<u00e9>>quation, on cherche le **point le plus bas d'un bol**, une surface qui repr<<u00e9>>sente l'<<u00e9>>nergie du syst<<u00e8>>me.
2. On descend vers ce point **pas <<u00e0>> pas**, en partant de z<<u00e9>>ro.
3. <<u00c0>> chaque pas, on choisit la **direction de descente avec soin**, pour ne pas d<<u00e9>>faire le travail des pas pr<<u00e9>>c<<u00e9>>dents.

On obtient une solution pr<<u00e9>>cise en **peu de pas**, m<<u00ea>>me avec beaucoup d'inconnues. Le seul calcul demand<<u00e9>> <<u00e0>> l'ordinateur est simple et r<<u00e9>>p<<u00e9>>t<<u00e9>> : multiplier la matrice par une liste de nombres.

::: attention
**Condition.** L'algorithme fonctionne quand la matrice K est **sym<<u00e9>>trique** (un lien entre deux <<u00e9>>l<<u00e9>>ments agit de la m<<u00ea>>me fa<<u00e7>>on dans les deux sens) et **d<<u00e9>>finie positive** (le syst<<u00e8>>me est stable : le bol a un fond). C'est le cas de la plupart des syst<<u00e8>>mes physiques stables, et de tous nos exemples.
:::

## Le plan de la pr<<u00e9>>sentation

| Partie | Ce qu'on y fait |
|:--|:--|
| **1. Comprendre** | on suit l'algorithme sur un petit circuit |
| **2. L'eau** | on l'utilise sur un grand r<<u00e9>>seau d'eau |
| **3. Analyser** | on mesure sa rapidit<<u00e9>> et on le compare <<u00e0>> d'autres m<<u00e9>>thodes |
| **4. Applications** | on l'applique en g<<u00e9>>nie civil et en g<<u00e9>>nie thermique |
| **5. Tests** | on v<<u00e9>>rifie que le programme est juste |

Tout au long du site, on utilise le package R **gradconj**, qui contient quatre fonctions :

| Fonction | R<<u00f4>>le |
|:--|:--|
| `cg()` | le gradient conjugu<<u00e9>> |
| `descente_simple()` | la m<<u00e9>>thode <<u00ab>> plus forte pente <<u00bb>>, pour comparer |
| `chaine()` | construit la matrice K d'une cha<<u00ee>>ne d'<<u00e9>>l<<u00e9>>ments (circuit, immeuble, mur) |
| `reseau_grille()` | construit la matrice K d'un r<<u00e9>>seau en grille (quartier d'eau) |

**Suite :** [1. Comprendre l'algorithme](comprendre.html)
)----")
ecrire("vignettes/articles/comprendre.Rmd", r"----(
---
title: "1. Comprendre l'algorithme sur un petit circuit"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(fig.align = "center", fig.width = 6.5, fig.height = 4.5, dpi = 120)
library(gradconj)
```

::: vous-allez
**Dans cette page, vous allez :**

- <<u00e9>>crire un probl<<u00e8>>me sous la forme K u = f, <<u00e0>> partir d'un petit circuit ;
- comprendre l'id<<u00e9>>e de <<u00ab>> descendre dans un bol <<u00bb>> ;
- suivre l'algorithme pas <<u00e0>> pas.
:::

## 1. Le probl<<u00e8>>me : un petit circuit

Prenons le plus petit exemple utile : **deux n<<u0153>>uds** reli<<u00e9>>s par des fils. On injecte **1 A** au n<<u0153>>ud 1. On cherche la **tension** (en volts) de chaque n<<u0153>>ud, par rapport <<u00e0>> la masse (0 V).

<img src="../img/circuit.png" alt="Circuit <<u00e0>> deux n<<u0153>>uds" width="85%">

Chaque fil est d<<u00e9>>crit par sa **conductance** : sa facilit<<u00e9>> <<u00e0>> laisser passer le courant (c'est l'inverse de la r<<u00e9>>sistance). Ici : 1 entre le n<<u0153>>ud 1 et la masse, 10 entre les deux n<<u0153>>uds, 1 entre le n<<u0153>>ud 2 et la masse.

### Deux r<<u00e8>>gles de physique

1. **Pour un fil** : le courant qui le traverse est <<u00e9>>gal <<u00e0>> la conductance multipli<<u00e9>>e par la diff<<u00e9>>rence de tension entre ses deux bouts. C'est la loi d'Ohm.
2. **Pour un n<<u0153>>ud** : tout le courant qui arrive repart. Un n<<u0153>>ud ne garde rien. C'est la **loi des n<<u0153>>uds** (comme une jonction de tuyaux : l'eau qui entre est <<u00e9>>gale <<u00e0>> l'eau qui sort).

### On <<u00e9>>crit l'<<u00e9>>quation de chaque n<<u0153>>ud

**Au n<<u0153>>ud 1.** Il arrive 1 A. Il repart par deux fils :

- vers la masse : 1 <<u00d7>> (u<<u2081>> <<u2212>> 0) = u<<u2081>>
- vers le n<<u0153>>ud 2 : 10 <<u00d7>> (u<<u2081>> <<u2212>> u<<u2082>>)

Donc : u<<u2081>> + 10 (u<<u2081>> <<u2212>> u<<u2082>>) = 1, ce qui donne **11 u<<u2081>> <<u2212>> 10 u<<u2082>> = 1**.

**Au n<<u0153>>ud 2.** Il n'arrive rien (0 A). Il repart par deux fils :

- vers la masse : 1 <<u00d7>> u<<u2082>>
- vers le n<<u0153>>ud 1 : 10 <<u00d7>> (u<<u2082>> <<u2212>> u<<u2081>>)

Donc : u<<u2082>> + 10 (u<<u2082>> <<u2212>> u<<u2081>>) = 0, ce qui donne **<<u2212>>10 u<<u2081>> + 11 u<<u2082>> = 0**.

### On range les deux <<u00e9>>quations en tableau

Chaque ligne du tableau est un n<<u0153>>ud. C'est la forme **K u = f** :

$$\begin{pmatrix} 11 & -10 \\ -10 & 11 \end{pmatrix} \begin{pmatrix} u_1 \\ u_2 \end{pmatrix} = \begin{pmatrix} 1 \\ 0 \end{pmatrix}$$

Pourquoi ces nombres ?

- **11** = 1 + 10 : les conductances des deux fils qui touchent le n<<u0153>>ud 1 (on additionne).
- **<<u2212>>10** : le fil entre les deux n<<u0153>>uds, avec un signe moins parce que u<<u2082>> appara<<u00ee>>t <<u00ab>> de l'autre c<<u00f4>>t<<u00e9>> <<u00bb>> de l'<<u00e9>>quation.
- La ligne 2 se lit pareil : 10 + 1 = 11, et <<u2212>>10 pour le fil commun.

La fonction `chaine()` du package construit ce tableau <<u00e0>> partir des conductances des fils, dans l'ordre :

```{r circuit}
K <- chaine(c(1, 10, 1))   # trois fils : conductances 1, 10 et 1
K
f <- c(1, 0)               # 1 A inject<<u00e9>> au n<<u0153>>ud 1, rien au n<<u0153>>ud 2
```

### La solution, <<u00e0>> la main puis par l'ordinateur

<<u00c0>> la main : la ligne 2 donne u<<u2081>> = 1,1 <<u00d7>> u<<u2082>>. On remplace dans la ligne 1 : 12,1 u<<u2082>> <<u2212>> 10 u<<u2082>> = 1, donc 2,1 u<<u2082>> = 1. Ainsi **u<<u2082>> = 0,4762 V** et **u<<u2081>> = 0,5238 V**.

Avec notre algorithme :

```{r circuit-cg}
res <- cg(K, f)
res$x           # les tensions u1 et u2 (volts)
res$iterations  # le nombre de pas
```

Le r<<u00e9>>sultat est le m<<u00ea>>me, trouv<<u00e9>> en **2 pas**. Le n<<u0153>>ud 1 a la tension la plus <<u00e9>>lev<<u00e9>>e parce que le courant entre par l<<u00e0>>.

## 2. L'id<<u00e9>>e : descendre dans un bol

Pour deux inconnues, r<<u00e9>>soudre <<u00e0>> la main est facile. Pour des milliers, il faut une autre approche. L'id<<u00e9>>e est de **transformer l'<<u00e9>>quation en un probl<<u00e8>>me de descente**.

### D'abord avec une seule inconnue

Prenons l'<<u00e9>>quation 2 u = 4 (on voit que u = 2). On construit une fonction appel<<u00e9>>e **<<u00e9>>nergie** :

$$E(u) = \tfrac{1}{2} \times 2 \times u^2 - 4u$$

- Le premier terme (**<<u00bd>> k u<<u00b2>>**) est l'<<u00e9>>nergie que le syst<<u00e8>>me emmagasine quand il est d<<u00e9>>form<<u00e9>> : elle augmente vite quand u s'<<u00e9>>loigne de z<<u00e9>>ro.
- Le second (**<<u2212>> f u**) est le travail de la force : c'est le gain d'<<u00e9>>nergie quand la force fait avancer le syst<<u00e8>>me.

```{r parabole, fig.height=3.8}
u <- seq(-1, 5, length.out = 200)
E <- u^2 - 4 * u                       # 1/2 * 2 * u^2 - 4 * u
plot(u, E, type = "l", lwd = 3, col = "#0B6E6E", xlab = "u", ylab = "<<u00e9>>nergie E(u)",
     main = "L'<<u00e9>>nergie en fonction de u")
abline(v = 2, lty = 2, col = "#E8710A", lwd = 2)
points(2, -4, pch = 19, cex = 1.8, col = "#E8710A")
```

La courbe descend, atteint un **point le plus bas**, puis remonte. Ce point est en **u = 2**, c'est-<<u00e0>>-dire la solution de 2 u = 4. Ce n'est pas un hasard :

- au point le plus bas, la courbe est horizontale : la pente est nulle ;
- la pente de E vaut k u <<u2212>> f (ici 2u <<u2212>> 4) ;
- pente nulle <<u21d4>> k u <<u2212>> f = 0 <<u21d4>> **k u = f**.

**Chercher le point le plus bas, c'est donc r<<u00e9>>soudre l'<<u00e9>>quation.** Un syst<<u00e8>>me physique fait de lui-m<<u00ea>>me ce chemin : il se place au point d'<<u00e9>>nergie minimale, comme une bille au fond d'une cuvette.

### Avec deux inconnues : un bol

Avec u<<u2081>> et u<<u2082>>, la parabole devient un **bol** <<u00e0>> trois dimensions : la position est le couple (u<<u2081>>, u<<u2082>>), et la hauteur est l'<<u00e9>>nergie. La formule est la m<<u00ea>>me, avec des tableaux de nombres <<u00e0>> la place des nombres :

$$E(u) = \tfrac{1}{2}\, u^T K u - f^T u$$

M<<u00ea>>me raisonnement : le fond du bol est l'endroit o<<u00f9>> la pente est nulle, c'est-<<u00e0>>-dire o<<u00f9>> **K u = f**.

Pour dessiner un bol sur une feuille, on trace des **courbes de niveau**, comme sur une carte de randonn<<u00e9>>e : chaque ligne relie des points de m<<u00ea>>me hauteur. Le fond du bol est au centre des ellipses.

### Deux fa<<u00e7>>ons de descendre

1. **La plus forte pente.** <<u00c0>> chaque pas, on regarde o<<u00f9>> <<u00e7>>a descend le plus vite, et on y va. C'est intuitif, mais dans un bol **allong<<u00e9>>** (une vall<<u00e9>>e <<u00e9>>troite), la plus forte pente pointe vers le **flanc** de la vall<<u00e9>>e, pas vers le fond. On traverse la vall<<u00e9>>e, puis on repart de l'autre c<<u00f4>>t<<u00e9>> : on **zigzague**.
2. **Le gradient conjugu<<u00e9>>.** <<u00c0>> chaque pas, on choisit une direction qui **ne d<<u00e9>>fait pas le travail d<<u00e9>>j<<u00e0>> fait**.

```{r bol, fig.height=5}
cg_res <- cg(K, f, garder_points = TRUE)
sd_res <- descente_simple(K, f, garder_points = TRUE)

E2 <- function(a, b) 0.5 * (K[1, 1] * a^2 + 2 * K[1, 2] * a * b + K[2, 2] * b^2) - f[1] * a - f[2] * b
u1 <- seq(-0.1, 0.7, length.out = 120)
u2 <- seq(-0.1, 0.7, length.out = 120)

contour(u1, u2, outer(u1, u2, E2), nlevels = 18, col = "grey70", asp = 1,
        xlab = "u1 (volts)", ylab = "u2 (volts)", main = "Le bol d'<<u00e9>>nergie du circuit")
P <- do.call(rbind, cg_res$points)
Q <- do.call(rbind, sd_res$points[1:12])
lines(Q, type = "o", col = "#E8710A", lwd = 2, pch = 16)
lines(P, type = "o", col = "#0B6E6E", lwd = 3, pch = 19)
legend("topleft", c("plus forte pente (12 premiers pas)", "gradient conjugu<<u00e9>> (2 pas)"),
       col = c("#E8710A", "#0B6E6E"), lwd = 3, bty = "n")
```

Comment lire ce graphique : les ellipses grises sont les courbes de niveau, le fond du bol est en leur centre. La ligne **orange** (plus forte pente) rebondit d'un c<<u00f4>>t<<u00e9>> <<u00e0>> l'autre. La ligne **verte** (gradient conjugu<<u00e9>>) arrive au fond en **2 pas**.

<img src="../img/anim_zigzag.gif" alt="Animation : zigzag contre gradient conjugu<<u00e9>>" width="75%">

Comptons les pas jusqu'<<u00e0>> la pr<<u00e9>>cision demand<<u00e9>>e :

```{r comparaison}
cg(K, f)$iterations
descente_simple(K, f)$iterations
```

**2 pas contre 194**, pour seulement deux inconnues.

## 3. L'algorithme pas <<u00e0>> pas

<<u00c0>> chaque pas, le gradient conjugu<<u00e9>> r<<u00e9>>p<<u00e8>>te quatre id<<u00e9>>es :

1. **Mesurer ce qui reste.** On calcule la **force restante** (le *r<<u00e9>>sidu*) : ce que le syst<<u00e8>>me n'a pas encore <<u00e9>>quilibr<<u00e9>>. Si elle est nulle, on a la solution.
2. **Choisir une direction.** Au premier pas, c'est la force restante. Ensuite, c'est la force restante **corrig<<u00e9>>e** pour ne pas d<<u00e9>>faire les pas pr<<u00e9>>c<<u00e9>>dents.
3. **Avancer du bon pas.** On avance dans cette direction exactement jusqu'au point le plus bas de la ligne.
4. **Recommencer** jusqu'<<u00e0>> ce que la force restante soit tr<<u00e8>>s petite.

Sur notre circuit, voici ce qui se passe :

| Pas | Tension u<<u2081>> | Tension u<<u2082>> | Force restante |
|:--|:--|:--|:--|
| D<<u00e9>>part | 0 | 0 | 1 |
| 1 | 0,0909 | 0 | 0,909 |
| 2 | 0,5238 | 0,4762 | 0 |

- **Pas 1** : on pousse dans la direction de la force restante, qui est enti<<u00e8>>rement au n<<u0153>>ud 1. Seule u<<u2081>> bouge. Il reste de la force, maintenant au n<<u0153>>ud 2.
- **Pas 2** : la nouvelle direction tient compte du premier pas. Elle m<<u00e8>>ne directement au fond du bol : la force restante est nulle.

::: retenir
**Pourquoi <<u00ab>> conjugu<<u00e9>> <<u00bb>> ?** Parce que chaque nouvelle direction est choisie pour ne pas d<<u00e9>>faire ce que les pr<<u00e9>>c<<u00e9>>dentes ont r<<u00e9>>gl<<u00e9>>. Avec 2 inconnues, 2 directions suffisent : l'algorithme termine en 2 pas.
:::

## Mini-glossaire

| Mot | Sens simple |
|:--|:--|
| **Conductance** | facilit<<u00e9>> de passage d'un fil, d'un tuyau, d'un mur (l'inverse d'une r<<u00e9>>sistance) |
| **<<u00c9>>nergie E(u)** | la hauteur du bol ; son point le plus bas est la solution |
| **R<<u00e9>>sidu** | la force restante, ce qu'il reste <<u00e0>> <<u00e9>>quilibrer |
| **It<<u00e9>>ration** | un pas de l'algorithme |

**Suite :** [2. Un deuxi<<u00e8>>me exemple : l'eau d'un quartier](eau.html)
)----")
ecrire("vignettes/articles/eau.Rmd", r"----(
---
title: "2. Un deuxi<<u00e8>>me exemple : l'eau d'un quartier"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(fig.align = "center", fig.width = 6.5, fig.height = 5, dpi = 120)
library(gradconj)
```

::: vous-allez
**Dans cette page, vous allez voir :**

- que la m<<u00ea>>me m<<u00e9>>thode calcule les **pressions d'un r<<u00e9>>seau d'eau** ;
- un petit exemple de 9 intersections, que l'on lit <<u00e0>> la main ;
- un quartier de **1 600 intersections**, r<<u00e9>>solu en une fraction de seconde ;
- pourquoi l'algorithme convient bien aux grands r<<u00e9>>seaux.
:::

## Du circuit au r<<u00e9>>seau d'eau

Dans la page pr<<u00e9>>c<<u00e9>>dente, nous avions 2 inconnues. Ici, nous passons <<u00e0>> un probl<<u00e8>>me bien plus grand, mais le **raisonnement est identique**. Seuls les mots changent :

| Circuit <<u00e9>>lectrique | R<<u00e9>>seau d'eau |
|:--|:--|
| tension | chute de pression |
| courant inject<<u00e9>> | d<<u00e9>>bit consomm<<u00e9>> |
| fil | tuyau |
| loi des n<<u0153>>uds | l'eau qui arrive <<u00e0>> une intersection est <<u00e9>>gale <<u00e0>> l'eau qui en repart |

## La situation

Un quartier est aliment<<u00e9>> par un ch<<u00e2>>teau d'eau. Les tuyaux forment une **grille**. <<u00c0>> chaque intersection, des habitants consomment de l'eau. Plus on est loin de l'alimentation, plus la pression baisse.

L'ing<<u00e9>>nieur veut savoir : **de combien la pression chute-t-elle <<u00e0>> chaque intersection ?** Si elle chute trop, l'eau n'arrive plus aux <<u00e9>>tages <<u00e9>>lev<<u00e9>>s.

## Le mod<<u00e8>>le

Chaque intersection est reli<<u00e9>>e <<u00e0>> ses **4 voisins** (haut, bas, gauche, droite). Les intersections du bord sont aussi reli<<u00e9>>es <<u00e0>> l'alimentation, o<<u00f9>> la chute de pression est nulle.

On <<u00e9>>crit, comme pour le circuit, l'<<u00e9>>quation de chaque intersection. Cela donne une ligne du tableau K avec :

- un **4** sur la diagonale (les 4 tuyaux qui touchent l'intersection) ;
- un **<<u2212>>1** pour chacun des 4 voisins ;
- des **z<<u00e9>>ros** partout ailleurs (pas de tuyau direct).

Les inconnues u sont les chutes de pression (en m<<u00e8>>tres). Le second membre f contient les d<<u00e9>>bits consomm<<u00e9>>s (en L/s). La fonction `reseau_grille()` construit K.

## Un petit exemple : 3 <<u00d7>> 3 intersections

Au centre (intersection 5), une usine consomme **8 L/s**. Les autres intersections ne consomment rien.

<img src="../img/reseau_eau3.png" alt="R<<u00e9>>seau 3 x 3" width="65%">

```{r reseau3}
A <- reseau_grille(3)
as.matrix(A)       # le tableau K, 9 lignes et 9 colonnes
```

Regardons la **ligne 5**, celle du centre : un 4 au milieu, et <<u2212>>1 pour les intersections 2, 4, 6 et 8, ses quatre voisins. Les z<<u00e9>>ros disent <<u00ab>> pas de tuyau direct <<u00bb>>.

```{r pression3}
f <- c(0, 0, 0, 0, 8, 0, 0, 0, 0)    # l'usine est <<u00e0>> l'intersection 5
res <- cg(A, f)
matrix(res$x, nrow = 3)              # on remet les 9 valeurs en carr<<u00e9>> 3 x 3
```

On lit : **3 m** au centre, **1 m** pour les quatre voisins, **0,5 m** dans les coins. La chute est maximale l<<u00e0>> o<<u00f9>> l'on consomme, et elle diminue en s'<<u00e9>>loignant. C'est conforme <<u00e0>> l'intuition : le r<<u00e9>>sultat est coh<<u00e9>>rent.

## Un vrai quartier : 40 <<u00d7>> 40 intersections

Passons <<u00e0>> **1 600 intersections**, chacune consommant 0,1 L/s (les habitations). Cela fait 1 600 <<u00e9>>quations <<u00e0>> 1 600 inconnues.

```{r quartier}
N <- 40
A <- reseau_grille(N)
f <- rep(0.1, N * N)
res <- cg(A, f)

res$iterations     # nombre de pas
max(res$x)         # la plus forte chute de pression (m)
```

**74 pas** suffisent pour 1 600 inconnues. Voici la carte des pressions :

```{r carte, fig.height=5.4}
image(1:N, 1:N, matrix(res$x, N), col = hcl.colors(60, "YlOrRd", rev = TRUE),
      xlab = "intersections d'ouest en est", ylab = "intersections du sud au nord",
      main = "Chute de pression dans le quartier (m)", asp = 1)
contour(1:N, 1:N, matrix(res$x, N), add = TRUE, col = "white", lwd = 1.2)
```

Plus la zone est fonc<<u00e9>>e, plus la pression chute. Le **centre est le point faible** : c'est le plus loin de l'alimentation, qui entoure le quartier. Au bord, la chute est presque nulle. Les traits blancs relient les points de m<<u00ea>>me chute de pression.

<img src="../img/anim_eau.gif" alt="Animation : les pressions se construisent pas <<u00e0>> pas" width="70%">

L'animation montre la solution se construire : l'algorithme trouve d'abord la forme g<<u00e9>>n<<u00e9>>rale, puis affine.

## Pourquoi l'algorithme convient ici

- Le tableau K est **creux** : chaque ligne n'a que 5 valeurs non nulles sur 1 600. On ne m<<u00e9>>morise que celles-l<<u00e0>>.
- L'algorithme n'a besoin que de **multiplier K par une liste de nombres**, ce qui est tr<<u00e8>>s rapide sur un tableau creux.
- Pour un r<<u00e9>>seau de centaines de milliers d'intersections, les m<<u00e9>>thodes qui traitent tout le tableau deviennent trop lourdes.

::: attention
**Limite du mod<<u00e8>>le.** Tous les tuyaux ont ici la m<<u00ea>>me conductance et les pertes de pression sont suppos<<u00e9>>es proportionnelles au d<<u00e9>>bit. Un vrai calcul de r<<u00e9>>seau tient compte des diam<<u00e8>>tres, des pompes et des vannes. On retrouve toutefois ce m<<u00ea>>me type de syst<<u00e8>>me <<u00e0>> l'int<<u00e9>>rieur des logiciels professionnels.
:::

**Suite :** [3. Analyser l'algorithme](analyser.html)
)----")
ecrire("vignettes/articles/analyser.Rmd", r"----(
---
title: "3. Analyser l'algorithme"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(fig.align = "center", fig.width = 6.5, fig.height = 4.5, dpi = 120)
library(gradconj)
```

::: vous-allez
**Dans cette page, vous allez :**

- mesurer la rapidit<<u00e9>> de l'algorithme et la comparer <<u00e0>> la plus forte pente ;
- comprendre **pourquoi** il est plus rapide, gr<<u00e2>>ce au conditionnement ;
- voir quand il est le bon choix, et quand il ne l'est pas.
:::

Les deux pages pr<<u00e9>>c<<u00e9>>dentes montraient que l'algorithme **fonctionne**, sur un petit circuit puis sur un grand r<<u00e9>>seau. Ici, on se demande : **est-il vraiment efficace, et pourquoi ?**

## 1. La rapidit<<u00e9>>

On r<<u00e9>>sout un r<<u00e9>>seau d'eau de 30 <<u00d7>> 30 intersections (900 inconnues) avec les deux m<<u00e9>>thodes, et on suit la **force restante** <<u00e0>> chaque pas.

```{r courbes}
N <- 30
A <- reseau_grille(N)
f <- rep(0.01, N * N)

a <- cg(A, f)
b <- descente_simple(A, f)

c(gradient_conjugue = a$iterations, plus_forte_pente = b$iterations)
```

```{r graphe-courbes}
plot(b$historique / b$historique[1], type = "l", log = "y", col = "#E8710A", lwd = 3,
     xlab = "nombre de pas", ylab = "force restante (<<u00e9>>chelle logarithmique)",
     main = "R<<u00e9>>seau 30 x 30 : 900 inconnues")
lines(a$historique / a$historique[1], col = "#0B6E6E", lwd = 3)
legend("topright", c("plus forte pente", "gradient conjugu<<u00e9>>"),
       col = c("#E8710A", "#0B6E6E"), lwd = 3, bty = "n")
```

**Comment lire ce graphique.** L'axe horizontal compte les pas. L'axe vertical montre la force restante : plus elle est basse, plus on est proche de la solution. Il est en <<u00e9>>chelle logarithmique : chaque graduation est 10 fois plus petite que la pr<<u00e9>>c<<u00e9>>dente, ce qui permet de voir une grandeur qui passe de 1 <<u00e0>> 0,00000001. Plus la courbe descend vite, meilleure est la m<<u00e9>>thode.

**R<<u00e9>>sultat :** le gradient conjugu<<u00e9>> atteint la pr<<u00e9>>cision demand<<u00e9>>e en **55 pas**, la plus forte pente en **3 559**. C'est 65 fois moins de pas pour la m<<u00ea>>me r<<u00e9>>ponse.

## 2. Pourquoi ? Le conditionnement

Souvenons-nous du bol d'<<u00e9>>nergie. Un bol peut <<u00ea>>tre **rond** ou **allong<<u00e9>>** comme une vall<<u00e9>>e <<u00e9>>troite.

- Dans un bol **rond**, la plus forte pente pointe droit vers le fond : tr<<u00e8>>s peu de pas.
- Dans un bol **allong<<u00e9>>**, elle pointe vers le flanc : on zigzague, beaucoup de pas.

Le **conditionnement**, not<<u00e9>> <<u03ba>>, mesure <<u00e0>> quel point le bol est allong<<u00e9>>. C'est le rapport entre sa plus grande et sa plus petite <<u00ab>> raideur <<u00bb>>, obtenues avec `eigen()` (les valeurs propres de K).

```{r kappa}
K <- chaine(c(1, 10, 1))        # le circuit de la page 1
valeurs <- eigen(K)$values
valeurs                          # la plus grande et la plus petite raideur
max(valeurs) / min(valeurs)      # le conditionnement
```

Pour notre circuit, <<u03ba>> = 21 / 1 = **21**.

| Conditionnement <<u03ba>> | Forme du bol | Difficult<<u00e9>> |
|:--|:--|:--|
| proche de 1 | rond | facile |
| grand | vall<<u00e9>>e <<u00e9>>troite | difficile |

Le point important est la fa<<u00e7>>on dont le nombre de pas d<<u00e9>>pend de <<u03ba>> :

- **plus forte pente** : le nombre de pas est proportionnel <<u00e0>> **<<u03ba>>** ;
- **gradient conjugu<<u00e9>>** : il est proportionnel <<u00e0>> **<<u221a>><<u03ba>>** (la racine carr<<u00e9>>e de <<u03ba>>).

::: retenir
Pour <<u03ba>> = 10 000, cela fait de l'ordre de 10 000 pas pour la plus forte pente, contre 100 pour le gradient conjugu<<u00e9>>. Plus le probl<<u00e8>>me est difficile, plus l'<<u00e9>>cart se creuse.
:::

Un autre r<<u00e9>>sultat de la th<<u00e9>>orie : en calcul exact, le gradient conjugu<<u00e9>> termine en **au plus n pas** pour n inconnues. C'est ce que l'on a vu : 2 pas pour 2 inconnues, 3 pas pour les 9 inconnues du petit r<<u00e9>>seau.

## 3. Une comparaison honn<<u00ea>>te

Le gradient conjugu<<u00e9>> n'est pas la meilleure m<<u00e9>>thode partout.

| Situation | Meilleur choix |
|:--|:--|
| Petit syst<<u00e8>>me | n'importe quelle m<<u00e9>>thode ; `solve()` est tr<<u00e8>>s bien |
| Grand syst<<u00e8>>me creux, probl<<u00e8>>me plan (2D) | m<<u00e9>>thode directe pour matrices creuses et gradient conjugu<<u00e9>> sont proches |
| Tr<<u00e8>>s grand syst<<u00e8>>me, probl<<u00e8>>me en volume (3D) | **gradient conjugu<<u00e9>>** : il utilise peu de m<<u00e9>>moire |
| M<<u00ea>>me matrice, **beaucoup de seconds membres** | m<<u00e9>>thode directe : on pr<<u00e9>>pare la matrice une seule fois |
| Une r<<u00e9>>ponse approch<<u00e9>>e suffit | **gradient conjugu<<u00e9>>** : on s'arr<<u00ea>>te quand la pr<<u00e9>>cision est suffisante |

## 4. Les limites

- La matrice K doit <<u00ea>>tre **sym<<u00e9>>trique d<<u00e9>>finie positive**. Sinon, on utilise d'autres m<<u00e9>>thodes (GMRES, BiCGStab).
- Quand <<u03ba>> est tr<<u00e8>>s grand, l'algorithme ralentit. Le rem<<u00e8>>de s'appelle le **pr<<u00e9>>conditionnement** : on transforme le syst<<u00e8>>me pour rendre le bol plus rond. Il n'est pas programm<<u00e9>> dans ce package : c'est la suite naturelle du travail.
- <<u00c0>> cause des arrondis de l'ordinateur, on s'arr<<u00ea>>te sur un **crit<<u00e8>>re de pr<<u00e9>>cision** plut<<u00f4>>t que sur le nombre de pas.

::: conclusion
**<<u00c0>> retenir.** Le gradient conjugu<<u00e9>> est bien plus rapide que la plus forte pente parce que son nombre de pas d<<u00e9>>pend de <<u221a>><<u03ba>> et non de <<u03ba>>. Il est id<<u00e9>>al pour les grands syst<<u00e8>>mes creux, sans <<u00ea>>tre la meilleure m<<u00e9>>thode dans tous les cas.
:::

**Suite :** [4. Applications en ing<<u00e9>>nierie](appliquer.html)
)----")
ecrire("vignettes/articles/appliquer.Rmd", r"----(
---
title: "4. Applications en ing<<u00e9>>nierie"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(fig.align = "center", fig.width = 6.5, fig.height = 4.5, dpi = 120)
library(gradconj)
```

::: vous-allez
**Deux probl<<u00e8>>mes d'ing<<u00e9>>nieur, r<<u00e9>>solus avec l'algorithme :**

1. **G<<u00e9>>nie civil** : un immeuble de 10 <<u00e9>>tages sous le vent.
2. **G<<u00e9>>nie thermique** : faut-il isoler un mur ?

Dans chaque cas, la d<<u00e9>>marche est la m<<u00ea>>me : **poser la question**, **mod<<u00e9>>liser** (<<u00e9>>crire K et f), **r<<u00e9>>soudre** avec `cg()`, puis **interpr<<u00e9>>ter** le r<<u00e9>>sultat pour prendre une d<<u00e9>>cision.
:::

Les deux applications pr<<u00e9>>c<<u00e9>>dentes ont d<<u00e9>>j<<u00e0>> montr<<u00e9>> le **g<<u00e9>>nie <<u00e9>>lectrique** (le circuit de la page 1) et l'**hydraulique** (le r<<u00e9>>seau d'eau de la page 2). Voici deux domaines de plus, trait<<u00e9>>s en d<<u00e9>>tail.

## G<<u00e9>>nie civil : un immeuble sous le vent

### La question

Le vent pousse sur un immeuble de 10 <<u00e9>>tages. **De combien l'immeuble se d<<u00e9>>forme-t-il ?** Si la d<<u00e9>>formation entre deux <<u00e9>>tages est trop grande, les cloisons fissurent et les vitres cassent. L'ing<<u00e9>>nieur doit le v<<u00e9>>rifier avant de construire.

### Le mod<<u00e8>>le

On repr<<u00e9>>sente l'immeuble par des **ressorts empil<<u00e9>>s** : chaque <<u00e9>>tage est retenu par l'<<u00e9>>tage du dessous, comme par un ressort.

<img src="../img/immeuble.png" alt="Immeuble de 10 <<u00e9>>tages" width="50%">

- **u** : le d<<u00e9>>placement horizontal de chaque <<u00e9>>tage (ce qu'on cherche) ;
- **f** : la force du vent sur chaque <<u00e9>>tage : 30 kN ;
- **K** : d<<u00e9>>crit les ressorts. Chaque <<u00e9>>tage a une **raideur** de 100 000 kN/m : la force qu'il faut pour le d<<u00e9>>former d'un m<<u00e8>>tre.

C'est exactement le m<<u00ea>>me raisonnement que pour le circuit. Pour un <<u00e9>>tage, la loi s'<<u00e9>>crit : *la force du vent est <<u00e9>>gale <<u00e0>> la force que transmettent les ressorts du dessous et du dessus*. La raideur joue le r<<u00f4>>le de la conductance, le d<<u00e9>>placement joue le r<<u00f4>>le de la tension, la force joue le r<<u00f4>>le du courant. On peut donc r<<u00e9>>utiliser `chaine()`.

Le **0 <<u00e0>> la fin** de la liste dit qu'il n'y a rien au-dessus du toit pour le retenir.

```{r immeuble}
k <- rep(1e5, 10)            # la raideur de chaque <<u00e9>>tage (kN/m)
A <- chaine(c(k, 0))         # la matrice K : le 0 final = le toit n'est retenu par rien d'autre
vent <- rep(30, 10)          # 30 kN de vent sur chaque <<u00e9>>tage

res <- cg(A, vent)
u <- res$x * 1000            # on passe des m<<u00e8>>tres aux millim<<u00e8>>tres
round(u, 1)                  # d<<u00e9>>placement de chaque <<u00e9>>tage (mm)
```

### Les r<<u00e9>>sultats

Le d<<u00e9>>placement augmente avec la hauteur : le **toit bouge de 16,5 mm**. Mais ce qui casse les cloisons n'est pas le d<<u00e9>>placement total : c'est la **d<<u00e9>>rive**, c'est-<<u00e0>>-dire de combien un <<u00e9>>tage bouge **par rapport <<u00e0>> celui du dessous**.

```{r derive}
derive <- diff(c(0, u))      # d<<u00e9>>placement d'un <<u00e9>>tage moins celui du dessous
round(derive, 1)             # d<<u00e9>>rive de chaque <<u00e9>>tage (mm)
```

La d<<u00e9>>rive est maximale au **rez-de-chauss<<u00e9>>e (3 mm)**. Pourquoi ? Parce que le premier <<u00e9>>tage doit retenir la pouss<<u00e9>>e de **tous les <<u00e9>>tages au-dessus**. Plus on monte, moins il y a d'<<u00e9>>tages <<u00e0>> retenir : la d<<u00e9>>rive diminue.

```{r immeuble-graphe}
plot(c(0, u), 0:10, type = "o", pch = 19, lwd = 3, col = "#0B6E6E",
     xlab = "d<<u00e9>>placement horizontal (mm)", ylab = "<<u00e9>>tage",
     main = "D<<u00e9>>form<<u00e9>>e de l'immeuble")
```

<img src="../img/anim_immeuble.gif" alt="Animation : l'immeuble sous le vent" width="50%">

### Et si un <<u00e9>>tage est plus souple ?

Imaginons que le 5e <<u00e9>>tage ait de grandes baies vitr<<u00e9>>es : sa raideur tombe <<u00e0>> 40 % de celle des autres.

```{r etage-souple}
k2 <- k
k2[5] <- 0.4 * 1e5
res2 <- cg(chaine(c(k2, 0)), vent)
derive2 <- diff(c(0, res2$x * 1000))
round(derive2, 1)            # d<<u00e9>>rive de chaque <<u00e9>>tage (mm)
```

<<u00c0>> l'<<u00e9>>tage 5, la d<<u00e9>>rive passe de **1,8 mm <<u00e0>> 4,5 mm**, et le toit passe <<u00e0>> **19,2 mm**. Un <<u00e9>>tage souple **concentre la d<<u00e9>>formation** : il se d<<u00e9>>forme beaucoup plus, car il est le maillon faible de la cha<<u00ee>>ne.

### La d<<u00e9>>cision

::: retenir
Il faut <<u00e9>>viter les <<u00e9>>tages <<u00ab>> mous <<u00bb>> : un <<u00e9>>tage plus souple concentre la d<<u00e9>>formation et peut d<<u00e9>>passer la limite de d<<u00e9>>rive fix<<u00e9>>e par la norme (la valeur se trouve dans votre cours). Le calcul permet de le voir **avant** de construire, et de renforcer l'<<u00e9>>tage concern<<u00e9>>.
:::

## G<<u00e9>>nie thermique : faut-il isoler un mur ?

### La question

Il fait **35 <<u00b0>>C dehors** et **22 <<u00b0>>C dedans** (climatisation). Un mur s<<u00e9>>pare les deux. **Quelle quantit<<u00e9>> de chaleur le traverse ?** Et un isolant de 5 cm change-t-il vraiment les choses ? Cette chaleur doit <<u00ea>>tre <<u00e9>>vacu<<u00e9>>e par la climatisation : plus elle est grande, plus on consomme d'<<u00e9>>lectricit<<u00e9>>.

### Le mod<<u00e8>>le

Le mur est fait de **couches** : enduit, b<<u00e9>>ton, isolant, pl<<u00e2>>tre (de l'ext<<u00e9>>rieur vers l'int<<u00e9>>rieur).

<img src="../img/mur.png" alt="Mur multicouche" width="80%">

La chaleur traverse chaque couche comme le courant traverse un fil. Chaque couche a une **conductance** : elle laisse plus ou moins passer la chaleur. Elle se calcule avec

$$\text{conductance} = \frac{\lambda}{\text{<<u00e9>>paisseur}}$$

o<<u00f9>> <<u03bb>> est la conductivit<<u00e9>> thermique du mat<<u00e9>>riau (grande pour le b<<u00e9>>ton, minuscule pour un isolant).

| Circuit <<u00e9>>lectrique | Mur |
|:--|:--|
| tension | **temp<<u00e9>>rature** |
| courant | **flux de chaleur** |
| fil | **couche** |

Les inconnues sont les temp<<u00e9>>ratures aux **interfaces** entre les couches. Les temp<<u00e9>>ratures ext<<u00e9>>rieure et int<<u00e9>>rieure sont impos<<u00e9>>es : elles entrent dans le second membre.

```{r mur-fonction}
mur <- function(e, lam, T_ext = 35, T_int = 22) {
  g <- lam / e                     # conductance de chaque couche
  n <- length(g) - 1               # nombre d'interfaces entre deux couches
  b <- rep(0, n)
  b[1] <- g[1] * T_ext             # la premi<<u00e8>>re couche touche l'ext<<u00e9>>rieur (35 <<u00b0>>C)
  b[n] <- b[n] + g[n + 1] * T_int  # la derni<<u00e8>>re touche l'int<<u00e9>>rieur (22 <<u00b0>>C)
  T_inter <- cg(chaine(g), b)$x    # on r<<u00e9>>sout : temp<<u00e9>>ratures aux interfaces
  list(T = c(T_ext, T_inter, T_int),
       position = cumsum(c(0, e)) * 100,        # position dans le mur (cm)
       flux = g[1] * (T_ext - T_inter[1]))      # chaleur qui traverse le mur
}
```

### Les r<<u00e9>>sultats

On calcule d'abord le mur isol<<u00e9>>, puis le m<<u00ea>>me mur **sans la couche d'isolant**.

```{r mur-calcul}
e   <- c(0.02, 0.20, 0.05, 0.02)    # <<u00e9>>paisseurs : enduit, b<<u00e9>>ton, isolant, pl<<u00e2>>tre (m)
lam <- c(1.0, 1.4, 0.04, 0.35)      # conductivit<<u00e9>> thermique de chaque mat<<u00e9>>riau

avec <- mur(e, lam)
sans <- mur(e[-3], lam[-3])         # on retire la couche n<<u00b0>>3 (l'isolant)

c(avec_isolant = avec$flux, sans_isolant = sans$flux)    # chaleur en W par m2
```

L'isolant fait passer le flux de **59 W/m<<u00b2>> <<u00e0>> 8,8 W/m<<u00b2>>** : **85 % de chaleur en moins**. Pour un mur de 20 m<<u00b2>>, la climatisation doit <<u00e9>>vacuer 177 W au lieu de 1 182 W.

```{r mur-graphe}
plot(avec$position, avec$T, type = "o", pch = 19, lwd = 3, col = "#0B6E6E", ylim = c(21, 36),
     xlab = "position dans le mur (cm, de l'ext<<u00e9>>rieur vers l'int<<u00e9>>rieur)",
     ylab = "temp<<u00e9>>rature (<<u00b0>>C)", main = "La temp<<u00e9>>rature dans l'<<u00e9>>paisseur du mur")
lines(sans$position, sans$T, type = "o", pch = 19, lwd = 3, col = "#E8710A")
legend("topright", c("avec isolant", "sans isolant"), col = c("#0B6E6E", "#E8710A"),
       lwd = 3, bty = "n")
```

**Comment lire ce graphique.** Chaque point est une interface entre deux couches. **Avec isolant** (vert), la temp<<u00e9>>rature reste entre 34,8 et 33,6 <<u00b0>>C jusqu'au b<<u00e9>>ton, puis **chute de 33,6 <<u00e0>> 22,5 <<u00b0>>C dans l'isolant seul**. C'est la couche isolante qui <<u00ab>> porte <<u00bb>> presque tout l'<<u00e9>>cart de temp<<u00e9>>rature : elle bloque la chaleur. **Sans isolant** (orange), c'est le b<<u00e9>>ton qui absorbe la baisse (de 33,8 <<u00e0>> 25,4 <<u00b0>>C), mais il laisse passer beaucoup plus de chaleur : le flux est 6 fois plus grand.

### La d<<u00e9>>cision

::: retenir
Isoler divise la chaleur qui traverse le mur par plus de 6, avec seulement 5 cm de mat<<u00e9>>riau. Le calcul chiffre ce gain **avant** de choisir les mat<<u00e9>>riaux : il aide <<u00e0>> d<<u00e9>>cider de l'<<u00e9>>paisseur d'isolant <<u00e0>> pr<<u00e9>>voir, en fonction de la consommation de climatisation que l'on veut atteindre.
:::

## Et dans d'autres domaines ?

Le m<<u00ea>>me principe sert d<<u00e8>>s qu'une quantit<<u00e9>> se r<<u00e9>>partit dans un r<<u00e9>>seau ou un milieu : <<u00e9>>coulement d'eau dans le sol (g<<u00e9>>otechnique), potentiel <<u00e9>>lectrique (<<u00e9>>lectrostatique), <<u00e9>>l<<u00e9>>ments finis en m<<u00e9>>canique des structures, traitement d'image, statistiques (moindres carr<<u00e9>>s). Dans les logiciels d'<<u00e9>>l<<u00e9>>ments finis, les syst<<u00e8>>mes d<<u00e9>>passent le million d'inconnues : c'est l<<u00e0>> que le gradient conjugu<<u00e9>> devient indispensable.

**Suite :** [5. Les tests](validation.html)
)----")
ecrire("vignettes/articles/validation.Rmd", r"----(
---
title: "5. Les tests : comment savoir que le programme est juste ?"
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(fig.align = "center", fig.width = 6.5, fig.height = 4.5, dpi = 120)
library(gradconj)
```

::: vous-allez
**Dans cette page, vous allez comprendre :**

- pourquoi on teste un programme, et comment ;
- trois v<<u00e9>>rifications ex<<u00e9>>cut<<u00e9>>es en direct ;
- les 17 tests automatiques du package ;
- comment les refaire soi-m<<u00ea>>me.
:::

## Pourquoi tester ?

Un programme qui affiche un nombre ne prouve pas que ce nombre est juste. C'est comme une balance : pour savoir si elle est fiable, on pose dessus un poids dont on conna<<u00ee>>t la valeur. Si elle affiche la bonne valeur, on peut lui faire confiance.

Pour notre programme, on fait de m<<u00ea>>me : on lui donne un probl<<u00e8>>me dont **la r<<u00e9>>ponse est connue par un autre chemin**, et on regarde s'il la retrouve. Nous utilisons trois sortes de r<<u00e9>>f<<u00e9>>rences :

1. **un calcul fait <<u00e0>> la main** (le circuit <<u00e0>> deux n<<u0153>>uds) ;
2. **une autre m<<u00e9>>thode reconnue** (la fonction `solve()` de R) ;
3. **une formule de physique** (les r<<u00e9>>sistances thermiques en s<<u00e9>>rie).

## Trois v<<u00e9>>rifications en direct

Chaque v<<u00e9>>rification ci-dessous est ex<<u00e9>>cut<<u00e9>>e au moment o<<u00f9>> le site est construit. `TRUE` veut dire que la comparaison est r<<u00e9>>ussie.

**1. Le circuit contre le calcul <<u00e0>> la main.** Dans la page 1, nous avons trouv<<u00e9>> <<u00e0>> la main u = (11/21 ; 10/21). L'algorithme donne-t-il la m<<u00ea>>me chose ?

```{r verif-circuit}
res <- cg(chaine(c(1, 10, 1)), c(1, 0))
isTRUE(all.equal(res$x, c(11/21, 10/21), tolerance = 1e-6))
```

**2. Le r<<u00e9>>seau d'eau contre `solve()`.** On r<<u00e9>>sout un r<<u00e9>>seau de 100 inconnues avec notre algorithme et avec la fonction de R. Les r<<u00e9>>ponses doivent <<u00ea>>tre les m<<u00ea>>mes.

```{r verif-solve}
A <- reseau_grille(10)
f <- rep(0.1, 100)
x_cg    <- cg(A, f, tol = 1e-10)$x
x_exact <- as.vector(solve(A, f))
isTRUE(all.equal(x_cg, x_exact, tolerance = 1e-6))
max(abs(x_cg - x_exact))       # l'<<u00e9>>cart le plus grand entre les deux r<<u00e9>>ponses
```

L'<<u00e9>>cart est minuscule : les deux m<<u00e9>>thodes donnent la m<<u00ea>>me r<<u00e9>>ponse, <<u00e0>> la pr<<u00e9>>cision de l'ordinateur pr<<u00e8>>s.

**3. Le mur contre la formule de physique.** Pour un mur, la chaleur qui passe est <<u00e9>>gale <<u00e0>> l'<<u00e9>>cart de temp<<u00e9>>rature divis<<u00e9>> par la somme des r<<u00e9>>sistances des couches. Notre algorithme doit retrouver cette valeur.

```{r verif-mur}
e   <- c(0.02, 0.20, 0.05, 0.02)
lam <- c(1.0, 1.4, 0.04, 0.35)
g   <- lam / e                                # conductance de chaque couche
b   <- c(g[1] * 35, 0, g[4] * 22)             # les temp<<u00e9>>ratures impos<<u00e9>>es aux bords
temp <- cg(chaine(g), b)$x                    # temp<<u00e9>>ratures aux interfaces
flux_cg      <- g[1] * (35 - temp[1])         # chaleur calcul<<u00e9>>e par l'algorithme
flux_formule <- (35 - 22) / sum(1 / g)        # chaleur donn<<u00e9>>e par la formule
c(algorithme = flux_cg, formule = flux_formule)
isTRUE(all.equal(flux_cg, flux_formule, tolerance = 1e-5))
```

## Les tests automatiques du package

Les v<<u00e9>>rifications ci-dessus sont ex<<u00e9>>cut<<u00e9>>es <<u00e0>> la main. Le package contient aussi des **tests automatiques**, <<u00e9>>crits avec le package **testthat** et rang<<u00e9>>s dans le dossier `tests/testthat/` du d<<u00e9>>p<<u00f4>>t GitHub. L'avantage : on les relance tous **en une seule commande**, et on voit tout de suite si une modification du code a cass<<u00e9>> quelque chose.

Un test a toujours la m<<u00ea>>me forme : *<<u00ab>> avec ceci en entr<<u00e9>>e, j'attends cela en sortie <<u00bb>>*. Voici l'un d'eux :

```{r, eval=FALSE}
test_that("reseau d'eau 3 x 3 : les pressions attendues", {
  A <- reseau_grille(3)
  f <- c(0, 0, 0, 0, 8, 0, 0, 0, 0)
  res <- cg(A, f)
  expect_equal(res$x, c(0.5, 1, 0.5, 1, 3, 1, 0.5, 1, 0.5), tolerance = 1e-6)
})
```

Ce test dit : <<u00ab>> sur le petit r<<u00e9>>seau 3 <<u00d7>> 3 avec une usine au centre, je m'attends aux pressions 0,5 / 1 / 3 que l'on a lues <<u00e0>> la main <<u00bb>>. Si le programme donne autre chose, le test <<u00e9>>choue.

Les 17 tests couvrent :

| Ce qui est test<<u00e9>> | Pourquoi |
|:--|:--|
| `cg()` et `descente_simple()` | les deux m<<u00e9>>thodes donnent la bonne solution |
| `chaine()` et `reseau_grille()` | les matrices construites ont la bonne forme et les bonnes valeurs |
| le r<<u00e9>>seau d'eau | pressions 3 / 1 / 0,5 et accord avec `solve()` |
| l'immeuble | d<<u00e9>>placement du toit de 16,5 mm |
| le mur | la chaleur calcul<<u00e9>>e <<u00e9>>gale la formule |

## Refaire les tests soi-m<<u00ea>>me

::: retenir
**Option 1 : essayer le package (30 secondes).** Dans R :

`install.packages("remotes")`

`remotes::install_github("ObamaAlbertoIvan/gradconj")`

`library(gradconj)`

`cg(chaine(c(1, 10, 1)), c(1, 0))$x`

R<<u00e9>>ponse attendue : **0.5238095 0.4761905**.
:::

::: retenir
**Option 2 : lancer les 17 tests.** Sur GitHub, bouton vert **Code**, puis **Download ZIP**. Ouvrir le projet dans RStudio, puis taper dans la console :

`devtools::test()`

R<<u00e9>>sultat attendu : **FAIL 0 | WARN 0 | SKIP 0 | PASS 17**, c'est-<<u00e0>>-dire 0 <<u00e9>>chec et 17 r<<u00e9>>ussis.
:::

**Option 3 : la d<<u00e9>>monstration.** Le fichier `scripts/demo.R` du d<<u00e9>>p<<u00f4>>t ex<<u00e9>>cute, ligne par ligne, le circuit, le quartier d'eau, l'immeuble, puis les tests.

**Suite :** [Conclusion](conclusion.html)
)----")
ecrire("vignettes/articles/conclusion.Rmd", r"----(
---
title: "Conclusion"
---

::: vous-allez
**Dans cette conclusion :** ce que nous avons fait, ce qu'il faut retenir, et ce que l'on peut faire ensuite.
:::

## Ce que nous avons fait

1. **Compris l'algorithme.** R<<u00e9>>soudre K u = f revient <<u00e0>> descendre au fond d'un bol d'<<u00e9>>nergie. Le gradient conjugu<<u00e9>> descend en choisissant <<u00e0>> chaque pas une direction qui ne d<<u00e9>>fait pas le travail pr<<u00e9>>c<<u00e9>>dent.
2. **L'avons programm<<u00e9>>** dans un package R, `gradconj`, publi<<u00e9>> sur GitHub.
3. **L'avons test<<u00e9>>** sur un circuit, un r<<u00e9>>seau d'eau, un immeuble et un mur, et v<<u00e9>>rifi<<u00e9>> par 17 tests automatiques.
4. **L'avons analys<<u00e9>>** : il est bien plus rapide que la plus forte pente, car son nombre de pas d<<u00e9>>pend de <<u221a>><<u03ba>> et non de <<u03ba>>.

## Ce qu'il faut retenir

::: retenir
- Beaucoup de probl<<u00e8>>mes d'ing<<u00e9>>nieur se ram<<u00e8>>nent <<u00e0>> un syst<<u00e8>>me **K u = f**.
- Quand K est **sym<<u00e9>>trique d<<u00e9>>finie positive**, r<<u00e9>>soudre ce syst<<u00e8>>me revient <<u00e0>> **trouver le point le plus bas d'un bol**.
- Le gradient conjugu<<u00e9>> y arrive en **peu de pas**, en n'utilisant que des **produits matrice <<u00d7>> liste de nombres**.
- Il est particuli<<u00e8>>rement adapt<<u00e9>> aux **grands syst<<u00e8>>mes creux**.
:::

## Au-del<<u00e0>> de nos exemples

Nos exemples (circuit, eau, immeuble, mur) sont volontairement simples. Mais le principe est g<<u00e9>>n<<u00e9>>ral : **d<<u00e8>>s qu'un probl<<u00e8>>me physique conduit <<u00e0>> un syst<<u00e8>>me lin<<u00e9>>aire sym<<u00e9>>trique d<<u00e9>>fini positif, le gradient conjugu<<u00e9>> peut le r<<u00e9>>soudre**.

| Pour aller plus loin | De quoi s'agit-il |
|:--|:--|
| **Pr<<u00e9>>conditionnement** | transformer le syst<<u00e8>>me pour rendre le bol plus rond et r<<u00e9>>duire le nombre de pas |
| **Autres m<<u00e9>>thodes** | si K n'est pas sym<<u00e9>>trique, on utilise d'autres algorithmes (GMRES, BiCGStab) |
| **<<u00c9>>l<<u00e9>>ments finis** | la m<<u00ea>>me m<<u00e9>>thode traite des millions d'inconnues en m<<u00e9>>canique, en thermique, en <<u00e9>>lectromagn<<u00e9>>tisme |
| **Moindres carr<<u00e9>>s** | en statistiques et en apprentissage automatique, on la retrouve pour ajuster un mod<<u00e8>>le <<u00e0>> des donn<<u00e9>>es |

**Suite :** [Merci](merci.html)
)----")
ecrire("vignettes/articles/merci.Rmd", r"----(
---
title: "Fin"
---

<div style='text-align:center;padding:40px 10px'>
<p style='color:#0B6E6E;font-size:3rem;font-weight:bold;margin:0'>Merci pour votre attention</p>
<div style='width:80px;height:4px;background:#E8710A;margin:22px auto'></div>
<p style='font-size:1.5rem;margin:0 0 20px'>Des questions ?</p>
<p>Code source et package : <a href='https://github.com/ObamaAlbertoIvan/gradconj'>github.com/ObamaAlbertoIvan/gradconj</a></p>
<p style='margin-top:28px'><a href='sommaire.html' style='background:#0B6E6E;color:#ffffff;padding:10px 24px;border-radius:6px;text-decoration:none;font-size:1.05rem'>Retour au sommaire</a></p>
</div>
)----")

# README (page GitHub) : on remplace les 3 balises par tes valeurs
readme <- r"----(
# Algorithme du gradient conjugu<<u00e9>> : de l'id<<u00e9>>e <<u00e0>> l'ing<<u00e9>>nierie

![Quatre domaines, une seule <<u00e9>>quation K u = f](man/figures/analogies.png)

**gradconj** est un package R qui programme l'**algorithme du gradient conjugu<<u00e9>>**, une m<<u00e9>>thode pour r<<u00e9>>soudre les syst<<u00e8>>mes d'<<u00e9>>quations **K u = f** que l'on rencontre partout en ing<<u00e9>>nierie : r<<u00e9>>seaux d'eau, circuits <<u00e9>>lectriques, structures, transferts de chaleur.

**Auteur :** Albert Ivan EYENGA OBAMA
**Matricule :** @@MATRICULE@@
**<<u00c9>>tablissement :** <<u00c9>>cole Nationale Sup<<u00e9>>rieure Polytechnique de Douala (ENSPD), Universit<<u00e9>> de Douala
**Mati<<u00e8>>re :** @@MATIERE@@ <<u00b7>> **Ann<<u00e9>>e acad<<u00e9>>mique :** @@ANNEE@@

Site de pr<<u00e9>>sentation : <https://obamaalbertoivan.github.io/gradconj/>

## Contenu du site

1. **Introduction** : le probl<<u00e8>>me et l'id<<u00e9>>e de l'algorithme.
2. **Comprendre** : l'algorithme sur un petit circuit.
3. **L'eau** : l'algorithme sur un r<<u00e9>>seau de 1 600 intersections.
4. **Analyser** : rapidit<<u00e9>>, conditionnement, comparaison avec d'autres m<<u00e9>>thodes.
5. **Applications** : g<<u00e9>>nie civil (immeuble sous le vent) et g<<u00e9>>nie thermique (isolation d'un mur).
6. **Tests** : comment v<<u00e9>>rifier que le programme est juste.
7. **Conclusion**.

## Installation

```r
install.packages("remotes")
remotes::install_github("ObamaAlbertoIvan/gradconj")
```

## Premier exemple

```r
library(gradconj)

K <- chaine(c(1, 10, 1))     # circuit <<u00e0>> deux n<<u0153>>uds
f <- c(1, 0)                 # 1 A inject<<u00e9>> au n<<u0153>>ud 1
res <- cg(K, f)

res$x                        # 0.5238095 0.4761905 (volts)
res$iterations               # 2 pas
```

## Les fonctions

| Fonction | R<<u00f4>>le |
|:--|:--|
| `cg()` | gradient conjugu<<u00e9>> |
| `descente_simple()` | descente de plus forte pente (pour comparer) |
| `chaine()` | matrice d'une cha<<u00ee>>ne d'<<u00e9>>l<<u00e9>>ments : circuit, immeuble, mur |
| `reseau_grille()` | matrice d'un r<<u00e9>>seau en grille : quartier d'eau |

## V<<u00e9>>rifier

```r
devtools::test()             # 17 tests : FAIL 0 | PASS 17
```

La d<<u00e9>>monstration compl<<u00e8>>te est dans `scripts/demo.R`.

## Licence

MIT.
)----"
readme <- gsub("@@MATRICULE@@", MATRICULE, readme, fixed = TRUE)
readme <- gsub("@@MATIERE@@", decode(MATIERE), readme, fixed = TRUE)
readme <- gsub("@@ANNEE@@", ANNEE, readme, fixed = TRUE)
ecrire("README.md", readme)

message("=== 2/4  Page de couverture ===")
logos <- list.files("man/figures", pattern = "^logo_ecole\\.(png|jpg|jpeg)$", full.names = TRUE, ignore.case = TRUE)
if (length(logos) == 0) {
  dossiers <- c(getwd(), file.path(Sys.getenv("USERPROFILE"),
                c("Desktop", "Bureau", "OneDrive/Desktop", "OneDrive/Bureau", "Downloads")))
  trouves <- list.files(dossiers, pattern = "^logo.*\\.(png|jpg|jpeg)$", full.names = TRUE, ignore.case = TRUE)
  if (length(trouves) > 0) {
    nom <- paste0("logo_ecole.", tolower(tools::file_ext(trouves[1])))
    dir.create("man/figures", recursive = TRUE, showWarnings = FALSE)
    file.copy(trouves[1], file.path("man/figures", nom), overwrite = TRUE)
    logos <- file.path("man/figures", nom)
  }
}
if (length(logos) > 0) {
  img <- paste0("<img src='man/figures/", basename(logos[1]), "' alt='Logo' style='height:110px;margin-bottom:18px'>")
  message("  logo utilise : ", logos[1])
} else {
  img <- ""
  message("  ATTENTION : aucun logo trouve. La couverture sera faite sans logo.")
}
enc  <- if (nzchar(ENCADRANT)) paste0("<p style='margin:4px 0 0'>Encadrant : ", ENCADRANT, "</p>") else ""
couv <- c(
  "<!-- debut-couverture -->",
  "<div style='min-height:85vh;display:flex;flex-direction:column;justify-content:center;align-items:center;text-align:center;padding:30px 10px;'>",
  img,
  "<p style='font-size:1.1rem;color:#1F2933;margin:0'><b>\u00c9cole Nationale Sup\u00e9rieure Polytechnique de Douala</b><br>Universit\u00e9 de Douala</p>",
  "<div style='width:80px;height:4px;background:#C65D0A;margin:22px 0'></div>",
  paste0("<p style='font-size:1.2rem;color:#C65D0A;letter-spacing:2px;text-transform:uppercase;margin:0'>", decode(MATIERE), "</p>"),
  "<p style='color:#0B6E6E;font-size:2.8rem;font-weight:bold;margin:14px 0 6px;line-height:1.2'>Algorithme du gradient conjugu\u00e9</p>",
  "<p style='font-size:1.25rem;color:#1F2933;margin:0 0 26px'>De l'id\u00e9e \u00e0 l'ing\u00e9nierie : un package R</p>",
  "<p style='margin:0'>Pr\u00e9sent\u00e9 par <b>Albert Ivan EYENGA OBAMA</b></p>",
  paste0("<p style='margin:4px 0 0'>Matricule : ", MATRICULE, "</p>"),
  enc,
  paste0("<p style='color:#666;margin:4px 0 0'>Ann\u00e9e acad\u00e9mique ", ANNEE, "</p>"),
  "<p style='margin-top:28px'><a href='articles/sommaire.html' style='background:#0B6E6E;color:#ffffff;padding:12px 28px;border-radius:6px;text-decoration:none;font-size:1.1rem'>Entrer dans le site &rarr;</a></p>",
  "</div>",
  "<!-- fin-couverture -->")
writeLines(couv, "index.md", useBytes = TRUE)
message("  ecrit : index.md")
suppressWarnings(try(usethis::use_build_ignore("index.md"), silent = TRUE))

message("=== 3/4  Construction du site (2 a 3 minutes) ===")
options(pkgdown.internet = FALSE)
pkgdown::build_site(preview = FALSE)

message("\n=== 4/4  TERMINE ===")
message("Ouvre docs/index.html pour voir le site. Puis GitHub Desktop : Commit to main, Push origin.")
