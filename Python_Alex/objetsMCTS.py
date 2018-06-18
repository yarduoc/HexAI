
# On définit dans ce fichier les deux objets Noeud et EtatDuJeu qui vont servir au MCTS

## Class Noeud

# La classe Noeud permet de construire l'arbre

class Noeud ( object):
    
    #Le noeud se construit avec les coordonnees du coup qui mene a ce noeud, le parent de ce noeud, l'etat du jeu actuel et si le noeud est une racine
    
    def __init__ ( self, coordonnees, parent, etat, estRacine):
        
        self.nPassage = 0
        self.nGagnant = 0
        
        self.parent = parent
        self.enfants = []
        
        self.estRacine = estRacine
        self.coordonnees = coordonnees
        self.joueur = etat.joueur
        self.coupsPossibles = etat.coupsPossibles()
        
        
    #CreerEnfant cree l'enfant qui a les coordonees coord et l'etat etat
    
    def creerEnfant( self, coord, etat):
        
        enfant = Noeud(coord,self,etat,False)
        self.enfants.append(enfant)
        self.coupsPossibles.remove(coord)
        
        return enfant
        
    # Score renvoie le score UCT du noeud
    
    def score( self):
        
        if self.nPassage == 0:
            
            return 0
            
        return (self.nGagnant/self.nPassage) + (2*log(self.nPassage)/self.nPassage)**(1/2)
    
    # AfficherInfo est une fonction qui permet d'avoir des infos sur le noeud (utile pour le retour utilisateur et le débuggage du programme)
    
    def afficherInfo( self):
        
        print(" Coordonnées = ",self.coordonnees)
        print(" Nb d'enfants = ",len(self.enfants))
        print(" Nb Gagnant / Nb Passage = ", self.nGagnant , " / ",self.nPassage)
        
        
## Objet EtatDuJeu


# L'objet EtatDuJeu est un objet qui stocke l'etat actuel du jeu. 
# Il permet de donner des informations pour la construction des Noeuds et les resultats de parties aléatoires

class EtatDuJeu ( object) :
    
    # On construit l'état du jeu avec la taille du tableau de jeu. En effet au début de la partie quand on crée l'etat, le plateau est vierge
    # On considère que le premier joueur est en bleu
    
    def __init__( self, taille):
        
        self.joueur = BLEU
        self.taille = taille
        self.plateau = [[0 for _ in range(taille)] for _ in range(taille)]
     
        
    # Copie permet de faire une copie de l'état du jeu actuel. 
    # Cette méthode permet de creer un nouvel objet qui ne modifiera pas le premier (cas des références)
        
    def copie( self):
        
        etat = EtatDuJeu( self.taille)
        etat.joueur = self.joueur
        etat.plateau = [[x for x in y] for y in self.plateau]
        
        return etat
    
    # JouerCoup effectue un coup aux coordonnées données    
        
    def jouerCoup( self, coord):
        
        x=coord[0]
        y=coord[1]
        
        if self.estSurPlateau(coord) :
            
            self.plateau[x][y]=self.joueur
        
            self.joueur = colorSwap( self.joueur)
            
        else :
            
            raise NameError('Coordonnées non sur le plateau')
            
    
    # coupsPossibles renvoie les coups jouables à partir de l'état actuel
        
    def coupsPossibles( self):
        
        sortie = []
        
        for x in range(self.taille):
            
            for y in range(self.taille):
                
                if self.plateau[x][y] == 0:
                    sortie.append([x,y])
        return sortie
     
    # estGagnant utilise la fonction de détermination de victoire (dans baseHex) et détermine si l'etat est gagnant pour un joueur    
        
    def estGagnant( self):
        
        return posGagnante( self.plateau, self.joueur) 
            
    # representation est une fonction qui permet de représenter l'etat du jeu actuel
    
    def representation( self):
        
        sortie = ""
        
        for x in self.plateau :
            
            ligne = ""
            
            for y in x :
                
                # "\033[NumeromMa chaine de caractères\033[1m" affichera à l'écran : Ma chaine de caraxtères dans la couleur Numero avec 30=Noir , 31=Rouge et 34=Bleu
                
                if y == 0 :
                    ligne+="\033[30mO\033[1m "
                elif y == 1 :
                    ligne+="\033[34mO\033[1m "
                else :
                    ligne+="\033[31mO\033[1m "
            
            sortie+=(ligne+"\n")
            
        print( sortie)    

    # estSurPlateau renvoie si une coordonnée est sur le plateau
    
    def estSurPlateau( self, coord):
        
        return (0<=coord[0]<self.taille and 0<=coord[1]<self.taille)
    