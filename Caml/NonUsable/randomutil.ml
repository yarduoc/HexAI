#open "lstutil";;

let est_initialiser = ref false;;

let initierAleatoire () =
    let system_random_number_generator = open_in "/dev/urandom" in
    random__init (input_binary_int system_random_number_generator);
    est_initialiser := true
;;

let avoirElementAleatoire lst =
    if not !est_initialiser then initierAleatoire ();
    avoirNEmeElement lst (random__int (list_length lst - 1))
;;
