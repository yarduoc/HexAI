#open "hextile";;
#open "lstutil";;
#open "funutil";;
#open "graph";;

type color = Red | Blue | Empty;;
type board = {size:int; tiles:color vect vect};;

(*Coordonée à ajouter à une case pour avoir les cases qui lui sont 
connectées*)
let connections =
    [{x=1; y=0}; {x=0; y=1}; {x=(-1); y=0}; 
    {x=0; y=(-1)}; {x=(-1); y=1}; {x=1; y=(-1)}];;

let is_on_board board tile = 
    tile.x >= 0 && tile.x < board.size 
    && tile.y >= 0 && tile.y < board.size
;;

let tile_color board tile = board.tiles.(tile.x).(tile.y);;

let is_color board color tile = (color = (tile_color board tile));;

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


let color_win board color =
    let is_end_color = is_end_tile board color in
    let is_con_to_end_tile = (is_con (color_ngh_tiles board) is_end_color) in
    let starts = filter (is_color board color) (start_tiles board color) in
    any is_con_to_end_tile starts
;;

let winner board = find_if (color_win board) Empty [Red; Blue];;
