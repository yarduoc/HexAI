#open "hextile";;

type color = Red | Blue | Empty;;
type board = {size:int; tiles:color vect vect};;

let other_color color =
    match color with
        | Red -> Blue
        | Blue -> Red
        | _ -> raise (Failure "Empty does not have an opposite color")
;;

let is_on_board board tile = 
    tile.x >= 0 && tile.x < board.size 
    && tile.y >= 0 && tile.y < board.size
;;

let set_tile_color board color tile =
    board.tiles.(tile.x).(tile.y) <- color;
    board;;

let tile_color board tile = board.tiles.(tile.x).(tile.y);;

let is_color board color tile = (color = (tile_color board tile));;


let tile_of_color board color =
    let rec aux tile =
        match tile with
            | {x=(-1); y=_} -> []
            | {x=n; y=(-1)} -> aux {x=(n - 1); y=(board.size - 1)}
            | {x=xn; y=yn} when is_color board color tile ->
                tile::(aux {x=xn; y=(yn - 1)})
            | {x=xn; y=yn} -> aux {x=xn; y=(yn - 1)}
    in
    aux {x=(board.size - 1); y=(board.size - 1)}
;;

let is_full board =
    match (tile_of_color board Empty) with
        | [] -> true
        | _ -> false
;;

let print_board board =
    for i = 0 to board.size - 1  do
        for j = 0 to board.size - 1 do
            match board.tiles.(i).(j) with
                | Blue -> print_string "Blue  "
                | Red -> print_string "Red   "
                | Empty -> print_string "Empty ";
        done;
        print_newline ()
    done
;;
