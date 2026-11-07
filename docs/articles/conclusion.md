# Conclusion

**Dans cette conclusion :** ce que nous avons fait, ce qu’il faut
retenir, et ce que l’on peut faire ensuite.

## Ce que nous avons fait

1.  **Compris l’algorithme.** Résoudre K u = f revient à descendre au
    fond d’un bol d’énergie. Le gradient conjugué descend en choisissant
    à chaque pas une direction qui ne défait pas le travail précédent.
2.  **L’avons programmé** dans un package R, `gradconj`, publié sur
    GitHub.
3.  **L’avons testé** sur un circuit, un réseau d’eau, un immeuble et un
    mur, et vérifié par 17 tests automatiques.
4.  **L’avons analysé** : il est bien plus rapide que la plus forte
    pente, car son nombre de pas dépend de √κ et non de κ.

## Ce qu’il faut retenir

- Beaucoup de problèmes d’ingénieur se ramènent à un système **K u =
  f**.
- Quand K est **symétrique définie positive**, résoudre ce système
  revient à **trouver le point le plus bas d’un bol**.
- Le gradient conjugué y arrive en **peu de pas**, en n’utilisant que
  des **produits matrice × liste de nombres**.
- Il est particulièrement adapté aux **grands systèmes creux**.

## Au-delà de nos exemples

Nos exemples (circuit, eau, immeuble, mur) sont volontairement simples.
Mais le principe est général : **dès qu’un problème physique conduit à
un système linéaire symétrique défini positif, le gradient conjugué peut
le résoudre**.

| Pour aller plus loin | De quoi s’agit-il |
|:---|:---|
| **Préconditionnement** | transformer le système pour rendre le bol plus rond et réduire le nombre de pas |
| **Autres méthodes** | si K n’est pas symétrique, on utilise d’autres algorithmes (GMRES, BiCGStab) |
| **Éléments finis** | la même méthode traite des millions d’inconnues en mécanique, en thermique, en électromagnétisme |
| **Moindres carrés** | en statistiques et en apprentissage automatique, on la retrouve pour ajuster un modèle à des données |

**Suite :**
[Merci](https://obamaalbertoivan.github.io/gradconj/articles/merci.md)
