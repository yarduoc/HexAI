#open "hextile";;
#open "hex";;
#open "board";;
#open "lstutil";;
#open "graph";;

(* On dit que deux cases sont connectées si elles sont reliées par une
    suite de case de même couleur*)
let color_win board color =
    (* Indique si `color` a gagné sur `board` *)
    let is_end_color = is_end_tile board color in
    (* fonction qui indique si une case est une case de fin *)
    let is_con_to_end_tile = (is_con (color_ngh_tiles board) is_end_color) in
    (* fonction indique si une case est connectée à une case de fin *)
    let starts = filter (is_color board color) (start_tiles board color) in
    any is_con_to_end_tile starts
;;

let winner board = find_if (color_win board) Empty [Red; Blue];;
    (* Indique qui a gagné sur le plateau `board`, si personne n'a gagnée
        renvoie `Empty`*)

let rec good_pos_for board will_play=
    (* Indique si une position du plateau `board` est bonne pour le joueur
        `will_play` qui va jouer *)
    let empty_tile = tile_of_color board Empty in
    match empty_tile with
        | [] -> winner board
        | lst when any (good_play board will_play) lst -> will_play
        | _ -> other_color will_play
             
and good_play board color tile =
    (* Renvoie si le la case `tile` est un bon coup pour le joueur
        `color` sur le plateau `board` *)
    let next_board = set_tile_color board color tile in
    let next_player = other_color color in
    let is_good = (good_pos_for next_board next_player) = color in
    set_tile_color board Empty tile;
    is_good
;;
        
let what_play board color =
    (* Renvoie le coup à jouer sur le plateau `board` pour le joueur
        `color` *)
    let empty_tile = tile_of_color board Empty in
    find_if (good_play board color) (hd empty_tile) empty_tile
;;

let add_pos_value will_play v1 v2 =
    match v1, v2 with
        | (r1, b1, w1), (r2, b2, w2) when w1 <> w2 ->
            (r1 + r2, b1 + b2, will_play)
        | (r1, b1, _), (r2, b2, _) -> 
            (r1 + r2, b1 + b2, other_color will_play)
;;

(* La valeur d'un plateau est `(r, b, w)` ou `r` est le nombre de
    façon que `r` peut gagner en partant de ce plateau `b` est la
    même mais pour bleu et `w` la personne qui gagne si elle jout
    parfaitement en partant du plateau *)
    
let rec value_pos board will_play=
    (*Renvoie la valeur du plateau `board` sachant que le joueur
        `will_play` va jouer*)
    let empty_tile = tile_of_color board Empty in
    match empty_tile with
        | [] -> 
            let win = winner board in
            begin
                match win with
                    | Blue -> (0, 1, Blue)
                    | Red -> (1, 0, Red)
                    | Empty -> raise (Failure "prout")
            end
        | lst -> 
            let sub_values = map (value_play board will_play) empty_tile in
            (* liste des valeurs des plateaux ateignable depuis le
                plateau `board` *)
            list_it (add_pos_value will_play) (0, 0, other_color will_play) sub_values
             
and value_play board color tile =
    (* Renvoie la valeur du tableau obtenue en faisant joué `color`
        sur la case `tile` sur le plateau `board` *)
    set_tile_color board color tile;
    let next_board_value = (value_pos board (other_color color)) in
    set_tile_color board Empty tile;
    next_board_value
;;

let is_best_value color v1 v2 =
    match v1, v2 with
        | ((r1, b1, w1), _), ((r2, b2, w2), _) ->
            w1 = color && w2 <> color
            || color = Blue && b1 > b2
            || color = Red && r1 > r2
;;

let best_play board color =
    (* Renvoie le coup à jouer sur le plateau `board` pour le joueur
        `color` *)
    let empty_tile = tile_of_color board Empty in
    snd (max (is_best_value color) (im_and_ant (value_play board color) empty_tile))
;;
