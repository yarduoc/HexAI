type tile = {x:int; y:int};;

let add tile1 tile2 = {x=tile1.x + tile2.x; y=tile1.y + tile2.y};;

let printTile tile =
    print_char `(`;
    print_int tile.x;
    print_char `,`;
    print_int tile.y;
    print_char `)`
;;
