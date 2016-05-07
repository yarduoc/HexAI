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

let main () = 
	let board = matrix 3 in
    begin
        printTile (getBestPlay board Blue)
    end
;;
	
printexc__f main ();;

exit 0;;
