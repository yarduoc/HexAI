##Couleurs

VIDE = 0
BLEU = 1
ROUGE = 2

##Cases valides autours

def cellProxy (L, cellule): # L = taille du plateau, cellule = [Ligne, colonne]
    n = cellule[0] #Ligne de la cellule
    k = cellule[1] #Colonne de la cellule
    if n == 0 :
        if k == 0 :
            return [[n+1, k], [n, k+1]]
        if k == L-1 :
            return [[n, k-1], [n+1, k-1], [n+1, k]]
        return [[n, k-1], [n, k+1], [n+1, k-1], [n+1, k]]
    if n == L-1 :
        if k == 0:
            return [[n-1, k], [n-1, k+1], [n, k+1]]
        if k == L-1 :
            return [[n-1, k], [n, k-1]]
        return [[n-1, k], [n-1, k+1], [n, k-1], [n, k+1]]
    if k == 0:
        return [[n-1, k], [n+1, k], [n-1, k+1] ,[n, k+1]]
    if k == L-1 :
        return [[n-1, k], [n, k-1], [n+1, k-1], [n+1, k]]
    return [[n-1, k], [n-1, k+1], [n, k-1], [n, k+1], [n+1, k-1], [n+1, k]]
##Valeur d'une cellule

def valeur(plateau, cellule):
    return plateau[cellule[0]][cellule[1]]

##CellMemeCouleurs

def cellMemeCouleur (plateau, cellule):
    couleur = valeur(plateau, cellule)
    L = len(plateau)
    sortie = []
    T = cellProxy(L, cellule)
    for x in T:
        if valeur(plateau, x) == couleur :
            sortie.append(x)
    return sortie

##Positions de départ

def posDeparts (plateau, couleur):
    L = len(plateau[0])
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
def casesArivee (plateau, couleur):
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


def posGagnante(plateau, couleur):
    L = len(plateau)
    tableau = [ [0 for _ in range (L)] for _ in range (L)]
    for posDepart in posDeparts(plateau, couleur):
        if __posGagnante(plateau, couleur, tableau, posDepart):
            return True
    return False
        
        
def __posGagnante (plateau, couleur, tableau, cellule): 
    L = len(plateau)
    for k in cellMemeCouleur(plateau, cellule):
        if valeur(tableau, k) == 0:
            tableau[k[0]][k[1]] = 1
            if k in casesArivee(plateau, couleur):
                return True
            if __posGagnante(plateau, couleur, tableau, k):
                return True
    return False

        

## générer plateau 
Plateau=[ [ 0 for _ in range (11)] for _ in range (11)]
from random import randint

couleurbis=ROUGE

for _ in range (121):
    libre=False
     
    while libre==False :
         
        if couleurbis==ROUGE:
            couleurbis=BLEU
        else :
            couleurbis=ROUGE    
        
        x=randint(0,10)
        y=randint(0,10)
         
        if Plateau[x][y]== VIDE :
            libre=True
            Plateau[x][y]=couleurbis
            
def a(x,y,table,couleur=BLEU):
    table[x][y]=couleur
