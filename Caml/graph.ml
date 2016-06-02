#open "lstutil";;

(*
TODO: Implémenter une arbre binaire pour enlever la recherche linéaire
à la ligne 9
*)

(* This first version is not the most efficient
let isConnectedToEnd next isEnd node =
    (* Indique si on peut atteindre une node vérifiant `isEnd` en
        partant de `node` en ne passant que par les node connecté entre
        elle. les node connecté à une node étant donné par la fonction
        `next` *)
    let rec aux next isEnd nodes_checked node =
        (not isIn nodes_checked node)
        && ((isEnd node) || (any (aux next isEnd (node::nodes_checked)) (next node)))
    in
    aux next isEnd [] node
;;*)

let isConnectedToEnd next is_end node =
    let nodes_checked = ref [] in
    let rec aux next is_end node =
        if isIn !nodes_checked node then
            false
        else begin
            nodes_checked := node::!nodes_checked;
            (is_end node) || any (aux next is_end) (next node)
        end
    in
    aux next is_end node
;;
