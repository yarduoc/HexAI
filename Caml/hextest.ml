#open "hex";;
#open "board";;
#open "hextile";;
#open "player";;
#open "testutil";;
#open "randomutil";;
#open "new_mcts";;
#open "timeutil";;


let main () =
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

printexc__f main ();;

exit 0;;
