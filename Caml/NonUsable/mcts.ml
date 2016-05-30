#open "hextile";;
#open "lstutil";;
#open "board";;
#open "randomutil";;
#open "timeutil";;
#open "player";;

type arbre =
    | Racine of racine
    | Arbre of noeud
and noeud = {
    mutable parent:arbre;
    mutable victoires: int * int;
    mutable sous_arbres: arbre list;
    coup_case: tile;
    prochain_joueur: color
}
and racine = {
    mutable premier_sous_arbres: arbre list;
    mutable premier_joueur: color
}
;;

let estNoeudDeVictoire arbre =
    match arbre.victoires with
        | 0, 1 | 1, 0 -> true
        | _ -> false
;;

let genererRacine premier_joueur =
    Racine {
        premier_joueur=premier_joueur;
        premier_sous_arbres=[];
    }
;;

let avoirVictoires arbre = arbre.victoires;;

let ajouterSousArbres arbre sous_arbre =
    match arbre with
        | Arbre arbre -> arbre.sous_arbres <- sous_arbre::arbre.sous_arbres
        | Racine racine -> arbre.premier_sous_arbres <- sous_arbre::arbre.premier_sous_arbres
;;

let avoirProchainJoueur arbre =
    match arbre with
        | Racine racine -> racine.premier_joueur
        | Arbre arbre -> arbre.prochain_joueur
;;

let avoirCoupleDesVictoireInitiale plateau coups_jouables =
    match coups_jouables with
        | [] -> 
            match winner plateau with
                | Red -> 1, 0
                | Blue -> 0, 1
                | _ -> raise (Failure "Il doit y avoir au moin un joueur gagnant sur un plateau complet")
        | _ ->
            1, 1
;;

let ajouterVictoires victoire1 victoire2 =
    match victoire1, victoire2 with
        | (victoire_rouge1, victoire_bleu1), (victoire_rouge2, victoire_bleu2) ->
            victoire_rouge1 + victoire_rouge2, victoire_bleu1 + victoire_bleu2
;;
    
let genSousArbre parent coup_case plateau_actuelle coups_jouables =
    let coup_couleur = avoirProchainJoueur parent in
    setTileColor plateau_actuelle coup_couleur coup_case;
    let victoires = avoirCoupleDesVictoireInitiale plateau_actuelle coups_jouables in
    Arbre {
        parent=parent;
        victoires=victoires;
        sous_arbres = [];
        coup_case = coup_case;
        prochain_joueur = getOtherColor coup_couleur
    }
;;

let rec mettreAJourVictoiresParent arbre =
    match arbre with
        | Racine  _ -> ()
        | Arbre arbre ->
            let victoires_sous_arbres = map avoirVictoires arbre.sous_arbres in
            let nouvelle_victoires = reduce ajouterVictoires (0, 0) victoires_sous_arbres in
            arbre.victoires <- nouvelle_victoires;
            mettreAJourVictoiresParent arbre.parent
;;
    
let ajouterNoeudEtRenvoyerNouveauNoeud arbre plateau_actuelle coups_jouables coup_case =
    let nouvelle_arbre = genSousArbre arbre coup_case plateau coups_jouables in
    ajouterSousArbres arbre nouvelle_arbre;
    hd arbre.sous_arbres
;;

let avoirSousArbreDeCoup arbre plateau_actuelle coups_jouables coup_case =
    let aux sous_arbres
        match sous_arbres with
            | [] -> ajouterNoeudEtRenvoyerNouveauNoeud arbre plateau_actuelle coups_jouables coup_case
            | sous_arbre::_ when sous_arbre.coup_case = coup_case ->
                sous_arbres
            | _::reste_sous_arbres -> aux reste_sous_arbres
    in
    aux arbre.sous_arbres
;;

let ajouterNoeudsAleatoire arbre plateau_actuelle coups_jouables =
    let rec ajouterNoeudsAleatoireAuxiliaire arbre plateau_actuelle coups_jouables =
        let prochain_coup_case = avoirElementAleatoire coups_jouables in
        ajouterNoeudsAleatoireApresCoup arbre plateau_actuelle prochain_coup_case
    and ajouterNoeudsAleatoireApresCoup arbre plateau_actuelle coups_jouables coup_case =
        let noeud_suivant = avoirSousArbreDeCoup arbre plateau_actuelle coups_jouables coup_case in
        if not estNoeudDeVictoire noeud_suivant then 
            setTileColor plateau_actuelle arbre.prochain_joueur coup_case;
            let nouveau_coups_jouables = supprimer coups_jouables coup_case in
            ajouterNoeudsAleatoire arbre plateau_actuelle nouveau_coups_jouables
        else
            mettreAJourVictoiresParent noeud_suivant
    in
    let copie_plateau = copierPlateau plateau_actuelle
    ajouterNoeudsAleatoireAuxiliaire arbre copie_plateau coups_jouables
;;

let estMeilleurSousArbrePourJoueur joueur sous_arbre1 sous_arbre2 =
    let victoires_rouge1, victoires_bleu1 = sous_arbre1.victoires in
    let victoires_rouge2, victoires_bleu2 = sous_arbre2.victoires in
    match joueur with
        | Blue -> victoire_bleu1 * victoire_rouge2 > victoire_bleu2 * victoire_rouge2
        | Red -> victoire_rouge1 * victoire_bleu2 > victoire_rouge2 * victoire_bleu2
;;

let avoirMeilleureSousArbre arbre =
    let joueur_actuelle = avoirJoueurActuelle arbre in
    max (estMeilleurSousArbrePourJoueur joueur_actuelle) arbre.sous_arbres
;;

let developerArbrePendantTemp arbre plateau_actuelle temp =
    let debut_temp = avoirTemp () in
    let coups_jouables = getTilesOfColor plateau_actuelle Empty in
    while avoirTemp () - debut_temp < temp do
        ajouterNoeudsAleatoire arbre plateau_actuelle coups_jouables
    done
;;

let avoirMeilleureSousArbrePendantTemp arbre plateau_actuelle temp =
    developerArbrePendantTemps arbre plateau_actuelle temp;
    avoirMeilleureSousArbre arbre
;;

let avoirNouveauSousArbreApresJouerMeilleureCoups arbre plateau_actuelle temp =
    let nouveau_sous_arbre = avoirMeilleureSousArbrePendantTemp arbre plateau_actuelle temp in
    setTileColor plateau_actuelle arbre.prochain_joueur nouveau_sous_arbre.coup_case;
    nouveau_sous_arbre
;;

let avoirNouveauArbreApresJouerCoup arbre plateau coup =
    let arbre_suivant = avoirSousArbreDeCoup arbre plateau coup in
    mettreAJourVictoiresParent arbre_suivant;
    arbre_suivant
;;
