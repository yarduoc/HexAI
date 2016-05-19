##
import os
os.chdir('C:\\Users\\Tibo\\Documents\\MPSI Info\\TIPE\\TIPE_2017\\Python')

import JeuGagnant

from random import random
from time import time
##

class noeud (object):
    
    def __init__ (self, coordonnees, parent, estRacine = False, n = -1):
        
        self.coord = coordonnees #tuple
        self.parent = parent #noeud
        self.estRacine = estRacine #bool
        self.enfants = [] #Liste de noeuds
        self.partiesJouees = 0 #Int
        self.partiesGagnees = 0 #Int
        self.couleur = BLEU
        self.nbVict = 0
        self.nbParties = 0
        
        if n == -1 :
            self.n = parent.n #int, taille du plateau
        else:
            self.n = n
            
        if not estRacine :
            
            parent.enfants.append(self)
            self.couleur = autreCouleur(parent.couleur) # BLEU = 1, ROUGE = 2
        
        self.nbPartiesJouees = 0
        self.nbPartiesGagnees = 0
        
            
        
    
    def cheminNoeud (self): #Donne la liste des tuples des noeuds parents
        if self.estRacine :
            return []
        chemin = self.parent.cheminNoeud()
        chemin.append(self.coord)
        return chemin
    
    
    def estFeuille(self):

        L = self.cheminNoeud()
        N = self.n
        if len(L) == N*N :
            return True
        return False
    
    def etatPlateau(self):
        N = self.n
        T = [[0 for _ in range(N)] for _ in range (N)]
        coupJoues = self.cheminNoeud()
        couleurJoueur = BLEU
        
        for coord in coupJoues :
            x = coord[0]
            y = coord[1]
            T[x][y] = couleurJoueur
            couleurJoueur = autreCouleur(couleurJoueur)
            
        return T
        
    def noeudGagnant(self):
        
        if not self.estFeuille() :
            return False
            
        T = self.etatPlateau()
            
            
        return posGagnante(T, self.couleur)
    
    
        
    
##


def listeCasesNonVides (Plateau):
    n = len(Plateau)
    Sortie = []
    for x in range(n):
        for y in range (n):
            if Plateau[x][y] == 0 :
                Sortie.append([x,y])
    return Sortie
    
    
def remonterVictoires (agamemnon):
    
    T = agamemnon.etatPlateau()
    couleur = agamemnon.couleur
    agamemnon.nbParties += 1
        
    if couleur == couleurGagnante(plateau):
            
        agamemnon.nbVict += 1
            
    noeudP = agamemnon
    
        
    while not noeudP.estRacine :
            
        noeudP.parent.nbParties += 1
            
        if noeudP.parent.couleur == couleurGagnante(plateau):
                
            noeudP.parent.nbVict += 1
            
        noeudP = noeudP.parent
        

##

def creerNoeudsFils (noeudP):
    
    T = noeudP.etatPlateau()
    n = len(T)
    CNV = listeCasesNonVides(T)
    coord = CNV[int(random() * len(CNV))]
    for coord in CNV :
        noeudFilsR = noeud(coord, noeudP)


def MCTSnaif(plateau):
    a = time()
    b = time()
    noeudR = noeud([], "Rien", True, len(plateau))
    
    while b-a < 100 :
        
        agamemnon = noeudR
        
        while not agamemnon.estFeuille() :
            
            if agamemnon.enfants == [] :
                
                creerNoeudsFils (agamemnon)
                
            listeEnfants = agamemnon.enfants
            agamemnon = listeEnfants[int(random()*len(listeEnfants))]
            
        remonterVictoires(agamemnon)
        b = time()
        
    listeEnfants= noeudR.enfants
    meilleurRatio = (listeEnfants[0].nbVict)/(listeEnfants[0].nbParties)
    meilleurCoup = listeEnfants[0].coord
    
    for agamemnon in listeEnfants :
        
        if agamemnon.nbParties != 0 :
            
            ratio = (agamemnon.nbVict)/(agamemnon.nbParties)
        
            if ratio > meilleurRatio :
            
                meilleurRatio = ratio
                meilleurCoup = agamemnon.coup
            
    return meilleurCoup
        
        
        
    
## noe
noe = noeud([], "rien", True, 3)
plateau = platGen(11)
