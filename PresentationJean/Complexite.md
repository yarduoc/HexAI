# Complexite

## MiniMax

fichier `player.ml`

On travaille avec un plateau d'une taille constante `taille`.

### winner

#### isConnectedToEnd

##### Première version

Comme `isConnectedToEnd` parcours tous les chemins possibles entre
une fin et le debut donné,
On trouve une borne supérieur simplement en calculant tout les
chemins existant entre le début et la fin dans le pire des cas
simplifié.

Chaque case est voisine d'au maximum 6 cases. ainsi pour former
un chemin, on choisit une des 6 cases suivant et on continue
jusqu'à avoir parcouru au maximum n^2 cases.
De plus les chemin commences à n cases différente.
d'où une majoration du nombre maximum de chemin: n6^{n^2}

De plus si `isConnectedToEnd` parcours un seul chemin, on peut
calculer sa compléxité temporel facilement en fonction de la
profondeur du chemin, en notant `p` la profondeur du chemin
en case et `C` la compléxité temporel de `isConnectedToEnd` on
a `T(p) = p + 1 + T(p + 1), T(taille^2) = 1`  car la fonction vérifier si
elle est déjà passé par la case ce qui prend `p` puis ce qu'il faut
traverser une liste de taille `p`; de plus elle doit verifier si la
case est une case de fin, ce qui prend un temp constant, la partie
`T(taille^2) = 1` existe pour indiquer que la récurence ce termine quand
on à parcourue `taille^2` cases. On peut donc avoir un format plus simple
à utiliser `T(N) = taille^2 - N + 1 + T(N - 1), T(0) = 1`. On a ainsi par
récurence sum `T(N) = sum^{taille^2}_{k = 1} taille^2 - k` ce qui nous donne
`T(taille^2) = O(taille^4)`

Ce qui donne une majoration de la compléxité: `T(n) = O(n^5 6^{n^2})`

###### Deuxième version

La nouvelle version crée après avoir chercher des exemple de compléxité
sur internet est plus simple à démontré est plus éfficace.

La fonction essaye les cases lié les une au autre sans jammais tester
une case déjà tester. Pour chaque case la fonction regarde si la case
à déjà été testé, si elle est une case de fin puis teste les cases
suivantes. Les deux derniere action prenne un temps constant. Par contre,
voir si une case a déjà été testée prend un temps dépendant du nombre
de cases déjà testé ainsi on a la compléxité pour un noeud qui est de
`O(k)` où `k` sont les noeuds déjà testé.

Ainsi on a la compléxité temporel de la nouvelle version:
`T(taille) = sum^{taille^2}_{k = 1} k = O(taille^3)`

#### Conclusion

`winner` appelle au maximum deux fois `winOnBoard`, pour la couleur de
chaque joueur.

`winOnBoard` appelle pour chaque case de départ la fonction
`isConnectedToEndSide` qui est une curryfication de `isConnectedToEnd`
du fichier `graph.ml`;
Les cases de départ étant sur tout le long d'un seul coté on a
`taille` cases de départ et donc `taille` appelle à `isConnectedToEnd`.

Ainsi on a simplement la compléxité de `winner` qui est
`O(taille^5)`

#### Amélioration

Au lieu d'utiliser une liste pour garder les noeuds déjà verifier
il serait interessant de garder les noeuds dans un vecteur
pour avoir une verification constante. ce qui donnerait
`O(taille^2)`


### getWinningPlay

#### Calcul

Nous allons chercher la compléxité temporel de `getWinningPlay`
en fonction du nombre `n` de case vide sur le plateau

On peut representer le travaille de `getWinningPlay` sous la forme
d'un arbre. calculer la compléxité à la profondeur `p`.

On compte d'apord le nombre de noeuds à la profondeur `p` de l'arbre
le nombre de noeurs à la profondeur `p` est le nombre de façons de
joué `p` jetons quelconque sur `n` cases vide, ainsi le nombre d'arrangement
de `n` cases de taille `p` ainsi `c_p` le nombre de noeurs et
`A_n^p = n! / (n - p)!`

A chacun de ces noeuds on génére la liste des coups à jouer ce qui prend
`taille^2` de temps

Ainsi la compléxité à la profondeur p est de `taille^2 n! / (n - p)!`

Il nous suffis à présent de faire la somme sur `p` pour avoir la compléxité
de `getWinningPlay` i-e `sum_{p = 0}^n taille^2 n! / (n - p)!`
En majorant `n! / (n - p)!` par `n!` on a une majoration de la compléxité de
`getWinningPlay`: `O(n taille^2 n!)`

#### Amelioration

Cette compléxité peut être amélioré en évitant de generer une liste à
chaque profondeur et garder la liste avec le coups joué en moin

Comme supprimer un élément prend `O(n)` ou n est la taille de la liste
notre somme ressemblerai à `sum_{p = 0}^n (n - p) n! / (n - p)!`
ce qui nous donnes `sum_{p = 0}^{n - 1} (n! / (n - p - 1)!) + O(1)`
i-e en faisant une majoration de `n! / (n - p - 1)!` par `n!`
On a la compléxité de `getWinningPlay` si l'amélioration est faite
`O(n n! )`


### getBestPlay

`getBestPlay` fait exactement la même chose que `getWinningPlay` et la
même amélioration est faisable sur ce dernier. ainsi on les même
compléxité.
