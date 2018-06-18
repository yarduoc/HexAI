
## Bases pour le jeu HEX


##Couleurs

VIDE = 0
BLEU = 1
ROUGE = 2

##Cases valides autours

def estDans(tableau, cellule): #Définis si une cellule est présente dans le tableau
    abs = cellule[0]
    ord = cellule[1]
    l = len(tableau)-1
    if 0 > abs or abs > l or 0 > ord or ord > l :
        return False
    return True
    

def cellProxy (plateau, cellule): #retourne les cellules autours d'une cellule donnée
    l = len(plateau)-1
    n = cellule[0]
    k = cellule[1]
    s = []
    for x in range (n-1, n+2) :
        for y in range (k-1, k+2):
            if estDans(plateau, [x,y]) :
                if [x,y] != [n-1, k-1] and [x,y] != [n+1, k+1] and [x,y] != cellule :
                    s.append([x,y])
    return s
    
    
##Valeur d'une cellule

def valeur(plateau, cellule):
    return plateau[cellule[0]][cellule[1]] #retourne la couleur d'une cellule du plateau

##CellMemeCouleurs

def cellMemeCouleur (plateau, cellule): #retourne les cellules de même couleur autours d'une certaine cellule
    couleur = valeur(plateau, cellule)
    sortie = []
    T = cellProxy(plateau, cellule)
    for x in T:
        if valeur(plateau, x) == couleur :
            sortie.append(x)
    return sortie

##Positions de départ

def posDeparts (plateau, couleur): #retourne la liste des cellules de départ pour la recherche d'un chemin
    L = len(plateau)
    Sortie = []
    if couleur == ROUGE:
        for k in range (L):
            if plateau[0][k]==ROUGE:
                Sortie.append([0,k])
    if couleur == BLEU:
        for n in range (L):
            if plateau[n][0]==BLEU:
                Sortie.append([n,0])
    return Sortie

## Cases valides finales
def casesArivee (plateau, couleur): #retourne la liste des cellules d'arrivée
    Sortie = []
    L = len(plateau)-1
    if couleur == BLEU :
        for n in range (L+1):
            if plateau[n][L] == BLEU :
                Sortie.append([n,L])
    if couleur == ROUGE :
        for k in range (L+1):
            if plateau[L][k] == ROUGE:
                Sortie.append([L,k])
    return Sortie

##pos2 OP

def posGagnante(plateau, couleur): # retourne si la couleur est gagnante
    L = len(plateau)
    tableau = [ [0 for _ in range (L)] for _ in range (L)]
    for posDepart in posDeparts(plateau, couleur):
        #On regarde pour chaque position de départ s'il y a un chemin pour la relier à une position finale
        if __posGagnante(plateau, couleur, tableau, posDepart):
            return True
    return False
        
        
def __posGagnante (plateau, couleur, tableau, cellule): #initialiste la fonction posGagnante
    L = len(plateau)
    for k in cellMemeCouleur(plateau, cellule):
        if valeur(tableau, k) == 0:
            tableau[k[0]][k[1]] = 1
            if k in casesArivee(plateau, couleur):
                return True
            if __posGagnante(plateau, couleur, tableau, k):
                return True
    return False

        

## fonctions pratiques

def creerPlateauVide(n):
    return[ [ 0 for _ in range (n)] for _ in range (n)]
from random import randint

def creerPlateauRempli(n):
    
    Plateau=creerPlateauVide(n)
    couleur=ROUGE

    for _ in range (121):
        libre=False
     
        while libre==False :
            
            colorSwap(couleur)    
        
            x=randint(0,10)
            y=randint(0,10)
         
            if Plateau[x][y]== VIDE :
                libre=True
                Plateau[x][y]=couleur
                
    return Plateau

# a a été défini pour une qustion d'aisance dans les tests du programme (la combinaison de touches pour [ et ] étant moins faciles pour certains claviers)
def a(x,y,table,couleur=BLEU):
    table[x][y]=couleur