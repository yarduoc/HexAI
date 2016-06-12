#open "hextile";;
#open "randomutil";;
#open "player";;
#open "board";;
#open "timeutil";;
#open "lstutil";;

type arbre =
    | Racine
    | Noeud of noeud
and noeud = {
    mutable parent:arbre;
    mutable tester: int;
    mutable victoires: int;
    mutable sous_noeuds: noeud list;
    plateau: color vect vect;
    case_joue: tile;
    joueur_actuelle: color;
    couleur_interesse: color
}
;;

let genererPremierNoeud couleur_interesse premier_joueur size =
    {
        parent=Racine;
        tester=0;
        victoires=0;
        sous_noeuds=[];
        plateau=genBoard size;
        case_joue={x=(-1);y=(-1)};
        joueur_actuelle=premier_joueur;
        couleur_interesse=couleur_interesse
    }
;;

let estVictoireApresPartieAleatoireNoeud noeud =
    let rec estVictoireApresPartieAleatoirePlateau plateau joueur_actuelle =
        let cases_jouables = avoirCasesJouables plateau in
        match cases_jouables with
            | [] -> winOnBoard plateau noeud.couleur_interesse
            | cases_jouables ->
                let prochain_joueur = getOtherColor joueur_actuelle in
                jouerCoupAleatoire plateau joueur_actuelle;
                estVictoireApresPartieAleatoirePlateau plateau prochain_joueur
    in
    let plateau_auxiliaire = copierPlateau noeud.plateau in
    estVictoireApresPartieAleatoirePlateau plateau_auxiliaire noeud.joueur_actuelle
;;

let rec propagationNoeud noeud victoire =
    if victoire then noeud.victoires <- noeud.victoires + 1;
    noeud.tester <- noeud.tester + 1;
    match noeud.parent with
        | Racine -> ()
        | Noeud noeud_parent ->
            propagationNoeud noeud_parent victoire
;;


let simulationNoeud noeud =
    let victoire = estVictoireApresPartieAleatoireNoeud noeud in
    propagationNoeud noeud victoire
;;

let ajouterNoeud noeud case_joue =
    let nouveau_plateau = copierPlateau noeud.plateau in
    setTileColor nouveau_plateau noeud.joueur_actuelle case_joue;
    let nouveau_noeud = {
        parent=Noeud noeud;
        tester=0;
        victoires=0;
        sous_noeuds=[];
        plateau=nouveau_plateau;
        case_joue=case_joue;
        joueur_actuelle=getOtherColor noeud.joueur_actuelle;
        couleur_interesse=noeud.couleur_interesse;
    } in
    noeud.sous_noeuds <- nouveau_noeud::noeud.sous_noeuds;
    nouveau_noeud
;;

let avoirSousNoeudDeCase noeud case =
    let rec aux sous_noeuds =
        match sous_noeuds with
            | [] ->
                ajouterNoeud noeud case
            | sous_noeud::reste_sous_noeuds when sous_noeud.case_joue = case ->
                sous_noeud
            | _::reste_sous_noeuds ->
                aux reste_sous_noeuds
    in
    aux noeud.sous_noeuds
;;


let rec testerSousNoeudAleatoire noeud =
    let coups_jouables = avoirCasesJouables noeud.plateau in
    let case_joue = avoirElementAleatoire coups_jouables in
    let rec aux sous_noeuds =
        match sous_noeuds with
            | [] ->
                let nouveau_noeud = ajouterNoeud noeud case_joue in
                simulationNoeud nouveau_noeud
            | sous_noeud::reste_sous_noeuds when sous_noeud.case_joue = case_joue ->
                testerSousNoeudAleatoire sous_noeud
            | _::reste_sous_noeuds ->
                aux reste_sous_noeuds
    in
    aux noeud.sous_noeuds
;;

let testerSousNoeudAleatoirePendant temp noeud =
    let start = avoirTemp () in
    while avoirTemp () -. start < temp do
        testerSousNoeudAleatoire noeud
    done
;;

let estMeilleurNoeud noeud1 noeud2 =
    noeud1.victoires / noeud1.tester > noeud2.victoires / noeud2.tester
;;

let avoirMeilleurSousNoeudAvant temp noeud =
    testerSousNoeudAleatoirePendant temp noeud;
    max estMeilleurNoeud noeud.sous_noeuds
;;

let printNoeud noeud =
    print_string "Noeud:"; print_string "\n";
    print_string "    tester:"; print_int noeud.tester; print_string "\n";
    print_string "    victoires:"; print_int noeud.victoires; print_string "\n";
    print_string "    case_joue:"; printTile noeud.case_joue; print_string "\n";
    print_string "    joueur_actuelle:"; afficherCouleur noeud.joueur_actuelle; print_string "\n";
    print_string "    couleur_interesse:"; afficherCouleur noeud.couleur_interesse; print_string "\n"
;;

