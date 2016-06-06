##
import os
os.chdir('C:\\Users\\Tibo\\Documents\\MPSI Info\\TIPE\\TIPE_2017\\Python')

import AlgoNaifPlateauGagnant
from random import randint

##Couleurs

VIDE = 0
BLEU = 1
ROUGE = 2

## générer plateau 

#Fonction pour générer un plateau vide de taille c

def platGen (c): 
    plateau=[ [ 0 for _ in range (c)] for _ in range (c)]
    return plateau

## génèreun plateau aléatoire

plateau=platGen(11)
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
         
        if plateau[x][y]==VIDE:
            libre=True
            plateau[x][y]=couleurbis

##

def autreCouleur (couleur):
    
    if couleur == BLEU :
        
        return ROUGE
        
    return BLEU

## minimax

#Algorithme permettant, étant donné un plateau, de déterminer, si les deux joueurs jouent aux mieux, quel joueur est certain de gagner

def minimax (plateau, couleur):
    
    plein = True
    
    for x in range (len(plateau[0])):
        
        for y in range(len(plateau[0])) :
            #on lance une boucle pour toutes les cases du plateau afin de tester toutes les issues possibles
            
            if plateau[x][y] == VIDE :
                
                plateau[x][y] = couleur
                plein = False
                    
                if minimax (plateau, autreCouleur(couleur)) == couleur :
                    
                    plateau[x][y] = VIDE
                    
                    return couleur
                    
                plateau[x][y] = VIDE
                
    if plein and posGagnante(plateau, couleur): 
        
            return couleur
            
    return autreCouleur(couleur)
    
##

#Permet de déterminer un coup permettant, si le joueur 'couleur' joue la meilleur façon possible, de gagner à coup sûr
def premierCoup(T, couleur):  
    a = time()
    for x in range(len(T)):
        
        for y in range(len(T)):
            
            if T[x][y] == VIDE :
                
                T[x][y]=couleur
                
                if minimax(T,autreCouleur(couleur)) == couleur:
                    
                    T[x][y] = VIDE
                    b = time()
                    print(b-a)
                    return [x,y]
                    
                T[x][y] = VIDE
                
    for x in range(len(T)) :
        
        for y in range(len(T)) :
            
            if T[x][y] == VIDE :
                b = time()
                print (b-a)
                return [x,y]
                
                

## J2
#Renvoie un noeud (ici une liste) composé des informations suivantes : [couleur, nombre de victoires du joueur bleu, nombre de victoires du joueur rouge]
#minimaxPond est une fonction récursive : on descend l'arbre de tous les plateaux possibles, et à chaque feuille, on met à jour le noeud intermédiaire selon si le joueur a gagné ou non. On fait ensuite remonter successivement les noeuds jusqu'à arriver à la racine.

def minimaxPond (plateau, couleur): 
    plein = True
    valeurNoeud = [autreCouleur(couleur), 0, 0]
    
    
    for x in range (len(plateau[0])):
        
        for y in range(len(plateau[0])) : 
            
            if plateau[x][y] == VIDE :
                
                plateau[x][y] = couleur
                plein = False
                    
                noeudInt = minimaxPond (plateau, autreCouleur(couleur))
                
                valeurNoeud[1] += noeudInt[1]
                valeurNoeud[2] += noeudInt[2]
                
                if noeudInt[0] == couleur :
                    valeurNoeud[0] = couleur
                    
                plateau[x][y] = VIDE
                
    if posGagnante(plateau, couleur) and plein :
        
        L = [couleur, 0, 0]
        L[couleur] = 1
        
        return L
        
    elif plein :
        
        L = [autreCouleur(couleur), 0, 0]
        L[autreCouleur(couleur)] = 1
    
        return L
        
    return valeurNoeud
    
    
def meilleurCoupPond (plateau, couleur):
    
    coupJouables = []
    chancesVictoire = []
    
    for x in range (len(plateau)):
        
        for y in range(len(plateau)):
            
            if plateau[x][y] == 0:
                
                coupJouables.append([x,y])
                plateau[x][y] = couleur
                noeudJeu = minimaxPond(plateau, autreCouleur(couleur))
                chancesVictoire.append(noeudJeu[couleur])
                plateau[x][y] = VIDE
                
    plusGrandesVict = chancesVictoire[0]
    meilleurCoup = coupJouables[0]
    
    for k in range (len(chancesVictoire)):
        
        if chancesVictoire[k] > plusGrandesVict :
            
            plusGrandesVict = chancesVictoire[k]
            meilleurCoup = coupJouables[k]
            
    return meilleurCoup
##
#Renvoie la première case non vide

def premCaseNonVide (plateau):
    
    for x in range (len(plateau)):
        
        for y in range (len(plateau)):
            
            if plateau[x][y] == VIDE:
                
                return [x, y]
    
##

#renvoie le meilleur coup (coup qui donne au joueur le plus de plateaux gagnants) pour le joueur 'couleur'
def meilleurCoup (plateau, couleur): 

    maxNodesGagnantes = 0
    meilleurePos = premCaseNonVide(plateau)
        
    for x in range (len(plateau)):
        
        for y in range (len(plateau)):
            
            if plateau[x][y] == VIDE :
                
                plateau[x][y] = couleur
                Node = minimaxPond(plateau, autreCouleur(couleur))
                plateau[x][y] = VIDE
                
                if Node[0] == couleur :
                    
                    return [x, y]
                    
                if Node[couleur] > maxNodesGagnantes :
                    
                    maxNodesGagnantes = Node[couleur]
                    meilleurePos = [x,y]
                
    return meilleurePos
                
 ## platgen
    
T = platGen(5)

Y = platGen(3)


    

