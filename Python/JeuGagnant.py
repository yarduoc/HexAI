##
import os
os.chdir('C:\\Users\\Tibo\\Documents\\MPSI Info\\TIPE\\TIPE_2017\\Python')

import AlgoNaifPlateauGagnant

##Couleurs

VIDE = 0
BLEU = 1
ROUGE = 2

## générer plateau 
def platGen (c):
    plateau=[ [ 0 for _ in range (c)] for _ in range (c)]
    return plateau
from random import randint

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

def minimax (plateau, couleur):
    plein = True
    for x in range (len(plateau[0])):
        
        for y in range(len(plateau[0])) :
            
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

def premierCoup(T, couleur): #Renvoie le meilleur premier coup
    
    for x in range(len(T)):
        
        for y in range(len(T)):
            
            if T[x][y] == VIDE :
                
                T[x][y]=couleur
                
                if minimax(T,autreCouleur(couleur)) == couleur:
                    
                    T[x][y] = VIDE
                    return [x,y]
                    
                T[x][y] = VIDE
                
    for x in range(len(T)) :
        for y in range(len(T)) :
            if T[x][y] == VIDE :
                return [x,y]
                
                

## J2

def minimaxPond (plateau, couleur):
    plein = True
    valeurNode = [autreCouleur(couleur), 0, 0]
    
    
    for x in range (len(plateau[0])):
        
        for y in range(len(plateau[0])) :
            
            if plateau[x][y] == VIDE :
                
                plateau[x][y] = couleur
                plein = False
                    
                littleBigNode = minimaxPond (plateau, autreCouleur(couleur))
                
                valeurNode[1] += littleBigNode[1]
                valeurNode[2] += littleBigNode[2]
                if littleBigNode[0] == couleur :
                    valeurNode[0] = couleur
                    
                plateau[x][y] = VIDE
                
    if posGagnante(plateau, couleur) and plein :
        L = [couleur, 0, 0]
        L[couleur] = 1
        return L
    elif plein :
        L = [autreCouleur(couleur), 0, 0]
        L[autreCouleur(couleur)] = 1
        return L
    return valeurNode
    
    
##

def premCaseNonVide (plateau):
    for x in range (len(plateau)):
        for y in range (len(plateau)):
            if plateau[x][y] == VIDE:
                return [x, y]
    
##

def meilleurCoup (plateau, couleur): #renvoie le meilleur coup
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
    
T = platGen(3)

Y = platGen(3)


    

