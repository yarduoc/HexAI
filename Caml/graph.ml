#open "lstutil";;

(*
TODO: Implémenter une arbre binaire pour enlever la recherche linéaire
à la ligne 9
*)
let is_con next is_end snode =
    (* Parcours si on peut atteindre une node vérifiant `is_end` en
        partant de `snode` en ne passant que par les node connecté entre
        elle. les node connecté à une node étant donné par la fonction
        `next` *)
    let rec aux next is_end gone snode =
        (not is_in gone snode) 
        && ((is_end snode) || (any (aux next is_end (snode::gone)) (next snode)))
    in
    aux next is_end [] snode
;;
    
