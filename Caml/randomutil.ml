#open "lstutil";;

let initierAleatoire () =
    let system_random_number_generator = open_in "/dev/urandom" in
    random__init (input_binary_int system_random_number_generator)
;;

let avoirElementAleatoire lst =
    avoirNEmeElement lst (random__int (list_length lst))
;;
