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
`T(taille) = sum^{taille^2}_{k = 1} k + O(n^2) = O(taille^4)`

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
