type tile = {x:int; y:int};;

let add tf ts = {x=tf.x + ts.x; y=tf.y + ts.y};;

let print_tile tile =
    print_char `(`;
    print_int tile.x;
    print_char `,`;
    print_int tile.y;
    print_char `)`
;;
