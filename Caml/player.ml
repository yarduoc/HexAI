#open "randomutil";;
#open "hextile";;
#open "hex";;
#open "board";;
#open "lstutil";;
#open "graph";;

(* On dit que deux cases sont connectées si elles sont reliées par une
    suite de case de même couleur*)
let winOnBoard board color =
    (* Indique si `color` a gagné sur `board` *)
    let isConnectedToEndSide =
        isConnectedToEnd (getSameColorNeighbourTiles board)
            (isNextToEndSide board color) in
    (* fonction indique si une case est connectée à une case de fin *)
    let filled_start_tiles = filter (isColor board color)
        (getColorStartTiles board color) in
    any isConnectedToEndSide filled_start_tiles
;;

let winner board = findIf (winOnBoard board) Empty [Red; Blue];;
    (* Indique qui a gagné sur le plateau `board`, si personne n'a gagnée
        renvoie `Empty`*)

let rec getWinningPlayer board will_play=
    (* Indique si une position du plateau `board` est bonne pour le joueur
        `will_play` qui va jouer *)
    let empty_tiles = getTilesOfColor board Empty in
    match empty_tiles with
        | [] -> winner board
        | lst when any (isWinningPlay board will_play) lst -> will_play
        | _ -> getOtherColor will_play

and isWinningPlay board color tile =
    (* Renvoie si le la case `tile` est un bon coup pour le joueur
        `color` sur le plateau `board` *)
    let board_after_play = setTileColor board color tile in
    let next_player = getOtherColor color in
    let is_winning_play = getWinningPlayer board_after_play next_player = color in
    setTileColor board Empty tile;
    is_winning_play
;;

let getWinningPlay board color =
    (* Renvoie le coup à jouer sur le plateau `board` pour le joueur
        `color` *)
    let empty_tiles = getTilesOfColor board Empty in
    findIf (isWinningPlay board color) (hd empty_tiles) empty_tiles
;;

(* La valeur d'un plateau est `(r, b, w)` ou `r` est le nombre de
    façon que `r` peut gagner en partant de ce plateau `b` est la
    même mais pour bleu et `w` la personne qui gagne si elle jout
    parfaitement en partant du plateau *)

let getFullBoardValue board =
    let winner_of_board = winner board in
    match winner_of_board with
        | Blue -> (0, 1, Blue)
        | Red -> (1, 0, Red)
        | Empty -> raise (Failure "The board is not valid or not full")
;;

let addBoardsValue has_played v1 v2 =
    match v1, v2 with
        | (r1, b1, w1), (r2, b2, w2) when w1 <> w2 ->
            (r1 + r2, b1 + b2, has_played)
        | (r1, b1, _), (r2, b2, _) ->
            (r1 + r2, b1 + b2, getOtherColor has_played)
;;

let rec getBoardValue board will_play=
    (*Renvoie la valeur du plateau `board` sachant que le joueur
        `will_play` va jouer*)
    let empty_tiles = getTilesOfColor board Empty in
    match empty_tiles with
        | [] -> getFullBoardValue board
        | lst ->
            let after_play_values = map (getBoardValueAfterPlay board will_play) 
                empty_tiles in
            (* liste des valeurs des plateaux ateignable depuis le
                plateau `board` *)
            reduce (addBoardsValue will_play) (0, 0, getOtherColor will_play)
                after_play_values

and getBoardValueAfterPlay board playing_color tile =
    (* Renvoie la valeur du tableau obtenue en faisant joué `color`
        sur la case `tile` sur le plateau `board` *)
    setTileColor board playing_color tile;
    let after_play_value = (getBoardValue board (getOtherColor playing_color)) in
    setTileColor board Empty tile;
    after_play_value
;;

let isBetterFor color v1 v2 =
    match v1, v2 with
        | ((r1, b1, w1), _), ((r2, b2, w2), _) ->
            w1 = color && w2 <> color
            || color = Blue && b1 > b2
            || color = Red && r1 > r2
;;

let getBestPlay board color =
    (* Renvoie le coup à jouer sur le plateau `board` pour le joueur
        `color` *)
    let empty_tiles = getTilesOfColor board Empty in
    (* Cherche le coups qui amène le joueur au plateau ayant la plus grande
        valeur *)
    snd (max (isBetterFor color)
        (getImagesAndAntecedants (getBoardValueAfterPlay board color) empty_tiles))
;;

let jouerCoupAleatoire plateau joueur =
    let cases_jouables = avoirCasesJouables plateau in
    let case_joue = avoirElementAleatoire cases_jouables in
    setTileColor plateau joueur case_joue
;;
    
