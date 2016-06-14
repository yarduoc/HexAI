let rec list_length lst =
    match lst with
        | [] -> 0
        | _::rlst -> 1 + list_length rlst
;;

let rec filter predicat lst =
    (* Renvoie la liste des élément verifiant le predicat `predicat`*)
    match lst with
        | [] -> []
        | x::rlst when predicat x -> x::(filter predicat rlst)
        | _::rlst -> (filter predicat rlst)
;;

let renverser lst =
    let rec aux lst sortie =
        match lst with
            | [] -> sortie
            | x::rlst -> aux rlst (x::sortie)
    in
    aux lst []
;;

let map f lst =
    (* Applique f à tout les élément de la liste *)
    let rec aux f lst sortie =
        match lst with
            | [] -> sortie
            | x::rlst -> (aux f rlst ((f x)::sortie))
    in
    renverser (aux f lst [])
;;

let rec reduce f a lst =
    (* Si lst = [a1; ... an], renvoit f( a1 f( ... f( an a) ) ) *)
    match lst with
        | [] -> a
        | x::rlst -> f x (reduce f a rlst)
;;

let rec applicationSuccessive f a n =
    (* renvoit [f^n (a); f^{n - 1} (a); ... ; f^2 (a); f (a); a] *)
    match n with
        | 0 -> [a]
        | n ->
            let reste_app_successive = applicationSuccessive f a (n - 1) in
            (f (hd reste_app_successive))::reste_app_successive
;;

let rec any predicat lst =
    match lst with
        | [] -> false
        | x::rlst -> (predicat x) || (any predicat rlst)
;;

let rec isIn lst x =
    match lst with
        | [] -> false
        | elm::rlst when x = elm -> true
        | _::rlst -> isIn rlst x
;;

let rec findIf predicat default lst =
    (* Renvoie le premier élément verifiant `predicat` ou `default` si aucun *)
    match lst with
        | [] -> default
        | x::rlst when predicat x -> x
        | _::rlst -> findIf predicat default rlst
;;

let rec getImagesAndAntecedants f lst =
    match lst with
        | [] -> []
        | x::rlst -> (f x, x)::(getImagesAndAntecedants f rlst)
;;

let rec max isGreater lst =
    (* Renvoie le maximum de tel que {a > b <=> isGreater a b} *)
    let rec aux current_max lst =
        match lst with
            | [] -> current_max
            | x::rlst when isGreater x current_max -> aux x rlst
            | _::rlst -> aux current_max rlst
    in
    match lst with
        | [] -> raise (Failure "Empty list has no max")
        | x::rlst -> aux x rlst
;;

let rec avoirNEmeElement lst n =
        match n, lst with
            | _, [] -> raise (Failure "Out Of Bound")
            | 0, elm::_ -> elm
            | n, _::rlst -> avoirNEmeElement rlst (n - 1)
;;

let rec supprimer liste valeur =
    match liste with
        | [] -> []
        | element::reste_liste when element = valeur -> reste_liste
        | element::reste_liste -> element::(supprimer reste_liste valeur)
;;

let rec appliquerProcedure procedure liste =
    match liste with
        | [] -> ()
        | element::reste_liste ->
            (procedure element); appliquerProcedure procedure reste_liste
;;
