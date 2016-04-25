##
import os
os.chdir('C:\\Users\\Tibo\\Documents\\MPSI Info\\TIPE')

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
         
        if plateau[x][y]==0:
            libre=True
            plateau[x][y]=couleurbis

##

def autreCouleur (couleur):
    if couleur == BLEU :
        return ROUGE
    return BLEU



##

def minmax (plateau, couleur):
    plein = True
    for x in range (len(plateau[0])):
        
        for y in range(len(plateau[0])) :
            
            if plateau[x][y] == 0 :
                
                plateau[x][y] = couleur
                plein = False
                    
                if minmax (plateau, autreCouleur(couleur)) == couleur :
                    plateau[x][y] = 0
                    return couleur
                plateau[x][y] = 0
                
    if plein and posGagnante(plateau, couleur):
            return couleur
    return autreCouleur(couleur)
    
T=platGen(3)

def premierCoup(T, couleur):
    for x in range(len(T)):
        for y in range(len(T)):
            if T[x][y]==0:
                T[x][y]=couleur
                if minmax(T,autreCouleur(couleur))==couleur:
                    T[x][y]=0
                    return [x,y]
                T[x][y]=0
    return "t'as perdu lol"
    
                
                
for x in range(len(T)):
        for y in range(len(T)):
            T[x][y]=BLEU
            if minmax(T,ROUGE)==BLEU:
                Y[x][y]=BLEU
            else :
                Y[x][y]=ROUGE
            T[x][y]=0
##





