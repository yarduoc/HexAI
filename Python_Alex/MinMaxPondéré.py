## MinMax Pondéré

# Les variables de couleur sont definies des le depart

VIDE = 0
BLEU = 1
ROUGE = 2

#colorSwap renvoie la couleur de l'autre joueur que celui en parametre

def colorSwap(color):
    
    if color==BLEU :
        return ROUGE
    return BLEU
    
#Le parcours va partir d'un plateau qui définira l'état du jeu et renvoie les valeurs de victoires pour cette position
def parcours (plateau, joueur):
    
    full = True 
    valeur_Node = [colorSwap(joueur),0,0]
    
    # on regarde les cases libres soit les coups suivants possibles
    
    for l in range(len(plateau)) :
        for c in range(len(plateau)):
            
            if plateau[c][l] == VIDE:
                
                full = False
                
                # on joue un coup, on regarde ses valeurs de victoire qu'on ajoute à celles pour l'état actuel du jeu et on enlève ce coup 
                
                plateau[c][l]=joueur
                
                valeur_SubNode = parcours(plateau, colorSwap(joueur))
                    
                addValeur(valeur_Node,valeur_SubNode)
                
                if joueur == valeur_SubNode[0]:
                    valeur_Node[0]=joueur
                
                plateau[c][l]=0
                

    #Si le tableau est plein alors on determine le gagnant et on renvoie la liste representant une victoire pour lui
    if full and posGagnante(plateau,joueur):
        return retour(joueur)
    elif full :
        return retour(colorSwap(joueur))
        
    #Si le tableau est non plein alors on renvoie la valeur de node correspondante
    return valeur_Node
    
        
#fonction qui prend en parametre la valeur d'un joueur à la node actuelle et lui ajoute le poid d'une node inferieure
def addValeur ( valeur_Node , valeur_SubNode ):
    valeur_Node[1] += valeur_SubNode[1]
    valeur_Node[2] += valeur_SubNode[2]
    
                
#fonction qui prend en parametre un joueur et qui renvoie la liste pour une victoire de ce joueur
def retour(joueur):
    retour = [joueur,0,0]
    retour[joueur]=1
    return retour                
    
    
# meilleurCoup est une fonction qui pour un état donné va donner le meilleur coup pour avoir le meilleur nombre de victoires
            
def meilleurCoup( plateau, joueur):
    
    retour = [-1,-1]
    meilleurScore = 0
    
    for x in range(len(plateau)):
        for y in range(len(plateau)):
            
            if plateau[x][y]==VIDE :
                
                plateau[x][y]=joueur
                score = parcours(plateau,joueur)
                
                if score[joueur]>meilleurScore :
                    meilleurScore=score[joueur]
                    retour=[x,y]
                    
                plateau[x][y]=VIDE
                
    return retour
                
                
                
                




            
            