#open "hex";;

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

let main () =
    print_string "Since Caml doesn't provide multi-platform time function \
        you have to enter a fucking seed yourself\n";
    random__init (read_int ());
    let board = generate_board 5 in
    begin
        print_board board;
        match (winner board) with
            | Blue -> print_string "Blue"
            | Red -> print_string "Red"
            | Empty -> print_string "What the fuck is this shit Oo";
        print_newline ()
    end
;;

printexc__f main ();;

exit 0;;
