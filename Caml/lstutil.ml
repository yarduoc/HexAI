let rec filter prd lst =
    (* Renvoie la liste des élément verifiant le predicat `prd`*)
    match lst with
        | [] -> []
        | x::rlst when prd x -> x::(filter prd rlst)
        | _::rlst -> (filter prd rlst)
;;

let renverser lst =
    let rec aux lst sor =
        match lst with
            | [] -> sor
            | x::rlst -> aux rlst (x::sor)
    in
    aux lst []
;;

let map f lst =
    (* Applique f à tout les élément de la liste *)
    let rec aux f lst sor =
        match lst with
            | [] -> sor
            | x::rlst -> (aux f rlst ((f x)::sor))
    in
    renverser (aux f lst [])
;;


let rec list_it f a lst =
    (* Si lst = [a1; ... an], renvoit f( a1 f( ... f( an a) ) ) *)
    match lst with
        | [] -> a
        | x::rlst -> f x (list_it f a rlst)
;;

let rec app_suc f a n =
    (* renvoit [f^n (a); f^{n - 1} (a); ... ; f^2 (a); f (a); a] *)
    match n with
        | 0 -> [a]
        | n ->
            let rst_app_suc = app_suc f a (n - 1) in
            (f (hd rst_app_suc))::rst_app_suc
;;

let rec any prd lst =
    match lst with
        | [] -> false
        | x::rlst -> (prd x) || (any prd rlst)
;;

let rec is_in lst x =
    match lst with
        | [] -> false
        | elm::rlst when x = elm -> true
        | _::rlst -> is_in rlst x
;;

let rec find_if prd default lst =
    (* Renvoie le premier élément verifiant `prd` ou default si aucun *)
    match lst with
        | [] -> default
        | x::rlst when prd x -> x
        | _::rlst -> find_if prd default rlst
;;

let rec im_and_ant f lst =
    match lst with
        | [] -> []
        | x::rlst -> (f x, x)::(im_and_ant f rlst)
;;

let rec max grtr lst =
    (* Renvoie le maximum de tel que {a > b <=> grtr a b} *)
    let rec aux cmax lst =
        match lst with
            | [] -> cmax
            | x::rlst when grtr x cmax -> aux x rlst
            | _::rlst -> aux cmax rlst
    in
    match lst with
        | [] -> raise (Failure "Empty list has no max")
        | x::rlst -> aux x rlst
;;
