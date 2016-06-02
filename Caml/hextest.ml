#open "hex";;
#open "board";;
#open "hextile";;
#open "player";;
#open "testutil";;
#open "randomutil";;


let main () =
    initierAleatoire ();
    let plateau = genererPlateauAleatoireComplet  5 in
    printBoard plateau;
    afficherCouleur (winner plateau)
;;

printexc__f main ();;

exit 0;;
