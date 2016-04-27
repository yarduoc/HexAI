#open "hextile";;
#open "hex";;
#open "board";;
#open "lstutil";;
#open "graph";;

(* on dit que deux cases sont connecté si elle sont reliée par une
    suite de case de même couleur*)
let color_win board color =
    (* Renvoie si `color` à gagner sur `board` *)
    let is_end_color = is_end_tile board color in
    (* fonction qui indique si une case est une case de fin *)
    let is_con_to_end_tile = (is_con (color_ngh_tiles board) is_end_color) in
    (* fonction indique si une case est connecté à une case de fin *)
    let starts = filter (is_color board color) (start_tiles board color) in
    any is_con_to_end_tile starts
;;

let winner board = find_if (color_win board) Empty [Red; Blue];;
    (* Indique qui à gagner sur le plateau `board`, si personne n'as gagner
        renvoie `Empty`*)

let rec good_pos_for board will_play=
    (* Indique si une position du plateau `board` est bonne pour le joueur
        `will_play` qui va jouer *)
    let empty_tile = tile_of_color board Empty in
    match empty_tile with
        | [] -> (winner board)
        | lst when any (good_play board will_play) lst -> will_play
        | _ -> other_color will_play
             
and good_play board color tile =
    (* Renvoie si le la case `tile` est un bon coups pour le joueur
        `color` sur le plateau `board` *)
    let next_board = set_tile_color board color tile in
    let next_player = other_color color in
    let is_good = (good_pos_for next_board next_player) = color in
    set_tile_color board Empty tile;
    is_good
;;
        
let what_play board color =
    (* Renvoie le coups à jouer sur le plateau `board` pour le joueur
        `color` *)
    let empty_tile = tile_of_color board Empty in
    find_if (good_play board color) (hd empty_tile) (tile_of_color board Empty)
;;
    
