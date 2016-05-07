#open "hex";;
#open "board";;
#open "hextile";;
#open "player";;


let main () = 
	let board = genBoard 3 in
    printTile (getBestPlay board Blue)
;;
	
printexc__f main ();;

exit 0;;
