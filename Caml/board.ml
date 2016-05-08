#open "hextile";;

type color = Red | Blue | Empty;;

let getOtherColor color =
    match color with
        | Red -> Blue
        | Blue -> Red
        | _ -> raise (Failure "Empty does not have an opposite color")
;;

let setTileColor board color tile =
    board.(tile.x).(tile.y) <- color;
    board
;;

let getTileColor board tile =
    board.(tile.x).(tile.y)
;;

let isColor board color tile =
    color = getTileColor board tile
;;

let getBoardSize board =
    vect_length board
;;

let getTilesOfColor board color =
    (* Renvoie la liste des coordonée des case de couleur `color` sur
        le plateau `board` *)
    let rec aux tile =
        (* Itère sur chaque case du plateau *)
        match tile with
            | {x=(-1); y=_} -> []
            | {x=n; y=(-1)} -> aux {x=(n - 1); y=(getBoardSize board - 1)}
            | {x=xn; y=yn} when isColor board color tile ->
                tile::(aux {x=xn; y=(yn - 1)})
            | {x=xn; y=yn} -> aux {x=xn; y=(yn - 1)}
    in
    aux {x=(getBoardSize board - 1); y=(getBoardSize board - 1)}
;;


let isOnBoard board tile = 
    tile.x >= 0 && tile.x < getBoardSize board 
    && tile.y >= 0 && tile.y < getBoardSize board
;;


let printBoard board =
    for i = 0 to getBoardSize board - 1  do
        for j = 0 to getBoardSize board - 1 do
            match board.(i).(j) with
                | Blue -> print_string "Blue  "
                | Red -> print_string "Red   "
                | Empty -> print_string "Empty ";
        done;
        print_newline ()
    done
;;
