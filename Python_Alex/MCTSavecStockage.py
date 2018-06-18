## MCTS avec stockage des Noeuds

# Dans cette version du MCTS on créé un noeud racine au début du programme et on réutilise l'arbre dévellopé à partir de cette racine à chaque tour de jeu.
# L'arbre des coups envisagés s'étoffe donc de plus en plus au fur et à mesure du déroulement de la partie

# Au début de la partie on créé une racine et un état qui serviront à la recherche du meilleur coup à chaque tour
N =11
etat = EtatDuJeu(N)
racine = Noeud("Aucunes","Aucun",etat,True)

# On crée une fonction pour initialiser les valeurs de départ
def InitialiserPartie(n):
    global N
    global etat
    global racine
    
    N=n
    etat = EtatDuJeu(n)
    racine = Noeud("Aucunes","Aucun",etat,True)


#rechercheMCTS effectue une recherche MCTS à partir du noeud racine global pour un temps donné        
        
def rechercheMCTS( etatRacine, temps):
    
    global racine
    
    t = temps +time()
    
    while time() < t :
  
        
        etat = etatRacine.copie()
        noeud = racine
        
        #on applique les différentes étapes du MCTS sur notre noeud et etat actuel
        
        noeud = selection( noeudRacine, etat)
        
        noeud = expansion( noeud, etat)
        
        simulation( etat)
        
        # subtilité : le joueur du dernier noeud est theorique: en realité le plateau est rempli : la victoire ou non est donc pour l'autre joueur
        if etat.estGagnant() :
            
            gagnant = colorSwap(etat.joueur)
            
        else :
            gagnant = etat.joueur
        
        noeud = propagationInverse( noeud, gagnant)
        
    meilleureVisite = 0
    meilleurEnfant = 0
    
    # on renvoie le noeud le plus visité, on le joue dans l'etat et on change la racine
    
    for k in racine.enfants :
        
        if k.nPassage >= meilleureVisite :
            
            meilleureVisite = k.nPassage
            meilleurEnfant = k
    
           
    etatRacine.jouerCoup(meilleurEnfant.coordonnees)
    racine = meilleurEnfant
    racine.estRacine = True
    return meilleurEnfant
    
    
    


#IAPremierCoup  permet de donner le premierCoup avec une simulation MCTS

def IApremierCoup (t):
    
    global racine
    
    lettres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    coup = rechercheMCTS( etat, racine, t)
    
    coup.afficherInfo()
    
    print( "Le meilleur coup est ",coup.coordonnees[0]+1,",",lettres[coup.coordonnees[1]]," ( ",coup.parent.nPassage," tests)")
    
    
#IAHex permet de donner un coup (premier coup exclu) avec une simulation MCTS selon le coup précédemment joué à partir de la racine globale actuelle 
        
def IAHex( y,x,t) :
    
    global racine
    
    lettres = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    y = lettres.index(y)
    
    x=x-1
    
    etat.jouerCoup([x,y])
    
    enfantExistait = False
    
    sousNoeuds = racine.enfants.copy()
    
    for k in sousNoeuds :
        
        if k.coordonnees == [x,y]:
            
            racine = k
            enfantExistait = True
            
    if enfantExistait == False :
        
        racine = racine.creerEnfant([x,y],etat)
        
    racine.estRacine = True
    
    coup = rechercheMCTS( etat, racine, t)
    
    coup.afficherInfo()
    
    print( "Le meilleur coup est ",coup.coordonnees[0]+1,",",lettres[coup.coordonnees[1]]," ( ",coup.parent.nPassage," tests)")