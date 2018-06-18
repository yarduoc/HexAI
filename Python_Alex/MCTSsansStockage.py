## MCTS sans stockage des Noeuds

# Dans cette version du MCTS on n'a pas de noeud racine globale : l'arbre est regénéré aléatoirement à chaque tour de jeu

# Au début de la partie on créé un état qui servira à la recherche du meilleur coup à chaque tour
N =11
etat = EtatDuJeu(N)

# On crée une fonction pour initialiser les valeurs de départ
def InitialiserPartie(n):
    global N
    global etat
    
    N=n
    etat = EtatDuJeu(n)
    
#rechercheMCTS2 effectue une recherche MCTS à partir de l'etat à la racine pour un temps donné  

def simulationMCTS2( etatRacine, temps):
    
    
    t = temps +time()
    noeudRacine = Noeud("Aucunes","Aucun",etat,True)
    
    
    while time() < t :
  
        
        etat = etatRacine.copie()
        noeud = noeudRacine
        
        #on applique les différentes étapes du MCTS sur etat actuel et le noeud associé qui a été créé
        
        noeud = selection( noeudRacine, etat)
        
        noeud = expansion( noeud, etat)
        
        simulation( etat)
        
        # subtilité : le joueur du dernier noeud est theorique: en realité le plateau est rempli : la victoire ou non est donc pour l'autre joueur
        if not etat.estGagnant() :
            
            gagnant = colorSwap(etat.joueur)
            
        else :
            gagnant = etat.joueur
        
        noeud = propagationInverse( noeud, gagnant)
        
    meilleureVisite = 0
    meilleurEnfant = 0
    
     # on renvoie le noeud le plus visité et on le joue dans l'etat
    
    for k in noeudRacine.enfants :
        
        if k.nPassage >= meilleureVisite :
            
            meilleureVisite = k.nPassage
            meilleurEnfant = k
    
           
    etatRacine.jouerCoup(meilleurEnfant.coordonnees)
    return meilleurEnfant
    
#IAPremierCoup2  est identique à IApremierCoup (MCTS avec Stockage)

def IApremierCoup2 (t):
    
    global racine
    
    lettres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    coup = rechercheMCTS( etat, racine, t)
    
    coup.afficherInfo()
    
    print( "Le meilleur coup est ",coup.coordonnees[0]+1,",",lettres[coup.coordonnees[1]]," ( ",coup.parent.nPassage," tests)")
    
    
#IAHex2 permet de donner un coup (premier coup exclu) avec une simulation MCTS selon le coup précédemment joué    
        
def IAHex2( y,x,t) :
    
    lettres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    y = lettres.index(y)
    
    x=x-1
    
    etat.jouerCoup([x,y])
    
    coup = simulationMCTS( etat, racine, t)
    
    coup.afficherInfo()
    
    print( "Le meilleur coup est ",coup.coordonnees[0]+1,",",lettres[coup.coordonnees[1]]," ( ",coup.parent.nPassage," tests)")