#open "board";;
#open "randomutil";;
#open "lstutil";;

let genererPlateauAleatoireComplet size =
    let plateau = genBoard size in
    let coups_non_rempli = ref (getTilesOfColor plateau Empty) in
    let couleur_a_pose = ref Blue in
    while !coups_non_rempli <> [] do
        let coup_a_joue = avoirElementAleatoire !coups_non_rempli in
        setTileColor plateau !couleur_a_pose coup_a_joue;
        couleur_a_pose := getOtherColor !couleur_a_pose;
        coups_non_rempli := supprimer !coups_non_rempli coup_a_joue
    done;
    plateau
;;

