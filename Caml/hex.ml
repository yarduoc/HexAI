#open "hextile";;
#open "lstutil";;
#open "graph";;
#open "board";;

(*Coordonée à ajouter à une case pour avoir les cases qui lui sont
connectées*)
let connections =
    [{x=1; y=0}; {x=0; y=1}; {x=(-1); y=0};
    {x=0; y=(-1)}; {x=(-1); y=1}; {x=1; y=(-1)}];;

let getSameColorNeighbourTiles board tile =
    (* Renvoie les case adjaçante à une case `tile` qui sont de la même
        couleur que la case `tile` sur le plateau `board`*)
    let isSameColor = (isColor board (getTileColor board tile)) in
    let isOnBoardAndSameColor = function tile -> isOnBoard board tile && isSameColor tile in
    filter isOnBoardAndSameColor (map (add tile) connections)
;;

let getColorStartTiles board color =
    match color with
        | Red -> applicationSuccessive (add {x=0; y=1}) {x=0; y=0} (getBoardSize board - 1)
        | Blue -> applicationSuccessive (add {x=1; y=0}) {x=0; y=0} (getBoardSize board - 1)
        | _ -> raise (Failure "Empty does not have any start tiles")
;;

let isNextToEndSide board color tile =
       color = Red && tile.x = getBoardSize board - 1
    || color = Blue && tile.y = getBoardSize board - 1
;;

