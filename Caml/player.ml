#open "hextile";;
#open "hex";;
#open "board";;
#open "lstutil";;
#open "graph";;

let color_win board color =
    let is_end_color = is_end_tile board color in
    let is_con_to_end_tile = (is_con (color_ngh_tiles board) is_end_color) in
    let starts = filter (is_color board color) (start_tiles board color) in
    any is_con_to_end_tile starts
;;

let winner board = find_if (color_win board) Empty [Red; Blue];;

let rec good_pos_for board will_play=
    let empty_tile = tile_of_color board Empty in
    match empty_tile with
        | [] -> (winner board)
        | lst when any (good_play board will_play) lst -> will_play
        | _ -> other_color will_play
             
and good_play board color tile =
    let next_board = set_tile_color board color tile in
    let next_player = other_color color in
    let is_good = (good_pos_for next_board next_player) = color in
    set_tile_color board Empty tile;
    is_good
;;
        
let what_play board color =
    let empty_tile = tile_of_color board Empty in
    find_if (good_play board color) (hd empty_tile) (tile_of_color board Empty)
;;
    
