from random import *
from time import *
from math import *

## Base du MCTS
        

# La Methode de recherche en arbres Monte Carlo se base sur 4 étapes : la selection, l'expansion, la simulation et la propagation inverse des résultats (traduction des termes angalis respectivement selection, expansion , simulation, backpropagation)  
    
        
# La selection est la premiere etape du MCTS : on descend dans l'arbre jusqu'a atteindre un noeud qui est non terminal ( n'est pas une feuille) et est non totalement devellopé (il reste des coups qui n'ont jamais ete joués à partir de ce noeud) en faisant suivre l'etat

def selection( noeud, etat):
    
    if noeud.coupsPossibles == [] and  noeud.enfants != [] :
        
        meilleurScore = 0
        meilleurEnfant = 0
        
        for k in noeud.enfants:
            
            if k.score() >= meilleurScore :
                
                meilleurScore=k.score()
                meilleurEnfant = k
        
        etat.jouerCoup(meilleurEnfant.coordonnees)
        return selection( meilleurEnfant, etat)
        
    return noeud
   
   
# L'expansion est la deuxieme etape du MCTS : quand on a atteint le noeud selectionné on crée un enfant aléatoire au noeud et on fait jouer ce coup à l'etat
    
def expansion( noeud, etat):
    
    if not noeud.coupsPossibles == []:
        
        a = randint(0,len(noeud.coupsPossibles)-1)
        
        coup = noeud.coupsPossibles[a]
        
        etat.jouerCoup( coup)
        
        noeud = noeud.creerEnfant( coup, etat)
        
    return noeud
    

# La simulation est la troisieme etape du MCTS : Le noeud reste inchangé et une copie de l'etat joue des coups aléatoires jusqu'à atteindre un etat terminal (plateau rempli) 

def simulation( etat):
    
    coups = etat.coupsPossibles()
    if coups == []:
        
        return etat
        
    a = randint(0,len(coups)-1)
    etat.jouerCoup(coups[a])
    return simulation(etat)
    

# La propagation Inverse des resultats est la derniere etape du MCTS : à partir du noeud devellopé et du resultat de l'etat à la racine, on change les valeurs du nombre de Passages et du nombre de Victoires

def propagationInverse( noeud, joueur):
    
    if noeud.joueur == joueur :
        
        noeud.nGagnant +=1
        
    noeud.nPassage +=1
    
    if noeud.estRacine :
        
        return noeud
        
    return propagationInverse( noeud.parent, joueur)
        

        
            


            
        
        
        
        
        


    
    
    
    