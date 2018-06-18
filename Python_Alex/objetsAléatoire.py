
# on utilise ici une méthode qui se rapproche du tirage MCTS mais en commencant par de simples tirages aléatoires construisant l'arbre

## Class Node

class Node (object) :
    
    # L'objet Node est défini par ses coordonnées, le Node parent, la couleur du joueur (par défaut l'inverse de celle du node parent), la largeur du plateau(par défaut 
    # celle du node parent) et par sa caractérisation en tant que racine ou non
    
    def __init__(self, coordinates, parentNode, couleur=-1, n=-1, isRoot=False):
        
        self.coordinates = coordinates
        self.parentNode = parentNode
        self.isRoot = isRoot
        self.childNodes = []
        self.nGagnant = 0
        self.nPassage = 0
        
        if couleur == -1:
            self.couleur = colorSwap(parentNode.couleur)
        else :
           self.couleur = couleur
        
        if n == -1:
            self.n=parentNode.n
        else :
            self.n = n
            
        # l'arbre se construit tout seul en ajoutant chaque node créé à son node parent
         
        if not isRoot :
            self.parentNode.childNodes.append(self)
            
    # path est une fonction qui renvoie le chemin du node dans l'arbre des séquences de coups possibles (soit les coups ayant mené à la situation actuelle)
         
    def path(self):
         
        if self.isRoot :
            return []
            
        chemin=self.parentNode.path()
        chemin.append(self.coordinates)
        return chemin
        
    # estFeuille renvoie si le node est une feuille de l'arbre

    def estFeuille(self):
        if len(self.path()) == ((self.n)**2):
            return True
        return False
        
    # estGagnant renvoie si le noeud actuel est un noeud gagnant
        
    def estGagnant(self):
        return posGagnante(self.matriceChemin(),self.couleur)
        
    # matriceChemin renvoie la matrice du plateau au node actuel
        
    def matriceChemin(self):
    
        matrice = [[0 for _ in range(self.n)] for _ in range(self.n)]
        chemin = self.path()
        couleur = self.couleur
        
        while chemin != [] :
       
            coord = chemin.pop()
            matrice[coord[0]][coord[1]] = couleur
            couleur=colorSwap(couleur)
            
        return matrice
        
    # displayInfo est une fonction qui permet d'avoir des infos sur le node (utile pour le retour utilisateur et le débuggage du programme)
        
    def displayInfo( self):
        
        print(" Coordonnées = ",self.coordinates)
        print(" Taille max = ", self.n)
        print(" Nb d'enfants = ",len(self.childNodes))
        print(" Nb Gagnant / Nb Passage = ", self.nGagnant , " / ",self.nPassage)
        
        
