#open "hex";;
#open "board";;
#open "hextile";;
#open "player";;

let matrix size = 
    let mat = make_vect size (make_vect 0 Empty) in
    for i = 0 to size - 1 do
        mat.(i) <- make_vect size Empty
    done;
    mat
;;

let generate_board size =
    let board = {size=size; tiles=matrix size} in
    let count = [|0; 0|] in
    let color = [|Blue; Red|] in
    for i = 0 to size - 1 do
        for j = 0 to size - 1 do
            if count.(1) > (size * size) / 2 then
                board.tiles.(i).(j) <- Blue
            else if count.(0) > (size * size) / 2 then
                board.tiles.(i).(j) <- Red
            else
                let k = random__int 2 in
                board.tiles.(i).(j) <- color.(k);
                count.(k) <- count.(k) + 1;
        done
    done;
    board
;;

let main () = 
	let board = {size=3; tiles=(matrix 3)} in
    begin
        print_tile (best_play board Blue)
    end
;;
	

printexc__f main ();;

exit 0;;
