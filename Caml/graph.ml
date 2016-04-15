#open "lstutil";;

let is_con next is_end snode =
    let rec aux next is_end gone snode =
        (not is_in gone snode) 
        && ((is_end snode) || (any (aux next is_end (snode::gone)) (next snode)))
    in
    aux next is_end [] snode
;;
    
