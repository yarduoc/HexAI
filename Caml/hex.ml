#open "hextile";;
#open "lstutil";;
#open "funutil";;
#open "graph";;
#open "board";;

(*Coordonée à ajouter à une case pour avoir les cases qui lui sont 
connectées*)
let connections =
    [{x=1; y=0}; {x=0; y=1}; {x=(-1); y=0}; 
    {x=0; y=(-1)}; {x=(-1); y=1}; {x=1; y=(-1)}];;

let ngh_tiles board tile =
    filter (is_on_board board) (map (add tile) connections)
;;

let color_ngh_tiles board tile =
    let good_color = (is_color board (tile_color board tile)) in
    let is_ngh_and_color = (all_pred [(is_on_board board); good_color]) in
    filter is_ngh_and_color (map (add tile) connections)
;;

let start_tiles board color =
    match color with
        | Red -> app_suc (add {x=0; y=1}) {x=0; y=0} (board.size - 1)
        | Blue -> app_suc (add {x=1; y=0}) {x=0; y=0} (board.size - 1)
        | _ -> raise (Failure "Empty does not have any start tiles")
;;

let is_end_tile board color tile = 
       color = Red && tile.x = board.size - 1
    || color = Blue && tile.y = board.size - 1
;;

