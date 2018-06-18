from time import time
from random import randint

## lancer aleatoire
    

def creerEnfants(noeud):
    
    plateau = noeud.matriceChemin()
    retour = []
    for x in range(len(plateau)):
        for y in range(len(plateau)):
            
            # l'ajout à la liste des enfants de noeud est automatique dans le contructeur de noeudEnfant
            if plateau[x][y]==0:
                noeudEnfant = Node((x,y),noeud)
                
                

# partieAleatoire déroule une partie aléatoirement à partir du noeud en incrémentant ses valeurs de passage et de victoire
    
def partieAleatoire( noeud):
    
    noeud.nPassage += 1
    
    if not noeud.estFeuille() :
    
        if  noeud.childNodes == []:
            creerEnfants( noeud)
        
        # Si la partie aléatoire d'un noeud enfant est gagnante alors le noeud actuel est perdant et vice versa
        if partieAleatoire( noeud.childNodes[randint(0,len(noeud.childNodes)-1)]) :
            return False
        
        noeud.nGagnant += 1
        return True
        
    if noeud.estGagnant():
        
        noeud.nGagnant += 1 
        return True
        
    return False

# simulationGraphique effectue des parties aléatoires sur un temps t et renvoie la matrice où chaque coup possible a son score dans ce temps imparti
# cette fonction a servi pour les tests et le débuggage
    
def simulationGraphique ( noeud, temps):
    
    tf = time() + temps
    
    while time()<tf :
        partieAleatoire( noeud)
    
    matrice = [['X' for _ in range(noeud.n)] for _ in range(noeud.n)]
    
    for k in noeud.childNodes :
        
        if k.nPassage == 0  :
            
            matrice[k.coordinates[0]][k.coordinates[1]] = 0
        
        
        else :
            
            matrice[k.coordinates[0]][k.coordinates[1]] = k.nGagnant/k.nPassage
            
    return matrice
     
         
# simulation effectue des parties aléatoires sur un temps t et renvoie le meilleur coup possible dans ce temps imparti

def simulation( noeud, temps):
    
    tps = time() + temps
    nombre = 0
    
    while time()<tps :
        
        partieAleatoire(noeud)
        nombre+=1
    #nombre sert à estimer le nombre de simulations en un temps donné pour les comparaisons avec d'autres algorithmes
    
    # on trouve le premier enfant à avoir au moins un passage
    # il existe forcément un noeud avec au moins un passage si temps>0, on ne vérifie donc pas si k reste dans les indices de la liste    
    k=0
    while noeud.childNodes[k].nPassage==0 :
        k+=1
     
    meilleur = noeud.childNodes[k]
    score = meilleur.nGagnant/meilleur.nPassage
        
    for k in noeud.childNodes :
        
        if k.nPassage!=0 and k.nGagnant/k.nPassage > score :
             
            score = k.nGagnant/k.nPassage
            meilleur = k
             
    return [meilleur.coordinates,nombre]
    
# noeudDepuisPlateau est une fonction qui renvoie un noeud racine "fictif" à partir d'un état du plateau (en effet le noeud n'est pas "reel" dans le sens où il est créé comme racine dans un plateau peut etre déjà partiellement rempli, on n'a donc pas la séquence de coups menant à cet état depuis le début de la partie)
# cette fonction permet d'effectuer la methode sur des plateaux non vide en donnant à la simulation cette racine fictive
    
def noeudDepuisPlateau( plateau, couleur):
    
    n = len(plateau)
    
    noeudActuel = Node("Aucune","aucun",couleur, n,True)
     
    for x in range(n):
         
        for y in range(n):
             
            if plateau[x][y] == 0 :
                 
                sousNoeud = Node([x,y],noeudActuel)
    return noeudActuel
    
# Jeu permet de donner le meilleur coup à jouer à partir du coup de l'adversaire sur le plateau Plateau (qu'on créé avant la partie) dans un temps de t
# Par défaut jeu jouera comme joueur rouge ( en second)

Plateau = creerPlateauVide(3)
                 
def Jeu (x, y, couleur=ROUGE, t=15, Plateau=Plateau):
    
    # a(x,y,tabl,couleur) défini dans baseHex) de meme que colorSwap
    a(x-1, y-1, Plateau, colorSwap(couleur))
    
    A= noeudDepuisPlateau(Plateau,couleur)
    
    sim = simulation(A,t)
    
    a(sim[0][0],sim[0][1],Plateau,couleur)
    
    print("Jouez en ",sim[0]," (",sim[1]," tests au total)")