#open "hex";;
#open "board";;
#open "hextile";;
#open "player";;
#open "testutil";;
#open "randomutil";;
#open "new_mcts";;
#open "timeutil";;
#open "lstutil";;

let jeu () =
    initierAleatoire ();
    let noeud = ref (genererPremierNoeud Red Blue 5) in
    while true do
        let case_x = print_string "x: "; read_int () in
        let case_y = print_string "y: "; read_int () in
        noeud := avoirSousNoeudDeCase !noeud {x=case_x;y=case_y};
        noeud := avoirMeilleurSousNoeudAvant 15. !noeud;
        printBoard !noeud.plateau
    done
;;

let avoirNombresTestEntre premier_temp deuxieme_temp pas taille =
    let avoir_temp_suivant = (fun temp -> temp +. pas) in
    let est_temp_fin = (fun temp -> temp > deuxieme_temp) in
    let nombre_teste temp =
        let noeud = genererPremierNoeud Blue Blue taille in
        testerSousNoeudAleatoirePendant temp noeud;
        noeud.tester
    in
    testEntreBorne premier_temp avoir_temp_suivant est_temp_fin nombre_teste
;;

let avoirNombresTestEnFonctionsDeTaille premiere_taille derniere_taille temp =
    let avoir_taille_suivante = (fun taille -> taille + 1) in
    let est_derniere_taille = (fun taille -> taille > derniere_taille) in
    let avoir_nombres_est = (fun taille ->
        let noeud = genererPremierNoeud Blue Blue taille in
        testerSousNoeudAleatoirePendant temp noeud;
        noeud.tester)
    in
    testEntreBorne premiere_taille avoir_taille_suivante est_derniere_taille avoir_nombres_est
;;

let afficherNombresTestEnFonctionsDeTaille premiere_taille derniere_taille temp =
    let nombres_test = avoirNombresTestEnFonctionsDeTaille premiere_taille derniere_taille temp in
    let afficher_test = fun taille_nombre_test ->
        print_int (fst taille_nombre_test);
        print_string "\t";
        print_int (snd taille_nombre_test);
        print_string "\n"
    in
    print_string "taille\tnombre_test \n";
    appliquerProcedure afficher_test nombres_test
;;

let afficherTempPrisParTestEnFonctionsDeTaille premiere_taille derniere_taille temp =
    let nombres_test = avoirNombresTestEnFonctionsDeTaille premiere_taille derniere_taille temp in
    let afficher_test = fun taille_nombre_test ->
        print_int (fst taille_nombre_test);
        print_string "\t";
        print_float (temp /. float_of_int (snd taille_nombre_test));
        print_string "\n"
    in
    print_string "taille\ttemp_test \n";
    appliquerProcedure afficher_test nombres_test
;;

let afficherTempPrisParTestEnFonctionsDeTailleCarre premiere_taille derniere_taille temp =
    let nombres_test = avoirNombresTestEnFonctionsDeTaille premiere_taille derniere_taille temp in
    let afficher_test = fun taille_nombre_test ->
        print_int (fst taille_nombre_test * fst taille_nombre_test);
        print_string "\t";
        print_float (temp /. float_of_int (snd taille_nombre_test));
        print_string "\n"
    in
    print_string "taille\ttemp_test \n";
    appliquerProcedure afficher_test nombres_test
;;

let afficherNombresTestEntre premier_temp deuxieme_temp pas taille =
    let nombres_test = avoirNombresTestEntre premier_temp deuxieme_temp pas taille in
    let afficher = (fun nombre_test ->
        print_float (fst nombre_test);
        print_string "\t";
        print_int (snd nombre_test);
        print_char `\n`) in
    appliquerProcedure afficher nombres_test
;;

let afficherTestPerSecond taille =
    let noeud = genererPremierNoeud Blue Blue taille in
    testerSousNoeudAleatoirePendant 30. noeud;
    print_float (float_of_int noeud.tester /. 30.)
;;

let main () =
    afficherNombresTestEntre 1. 30. 2. (int_of_string sys__command_line.(1))
;;

printexc__f main ();;

exit 0;;
