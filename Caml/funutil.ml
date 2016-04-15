let fnot1 f a = (not f a);;

let rec all_pred preds a =
    match preds with
        | [] -> true
        | pred::rpreds -> (pred a) && (all_pred rpreds a)
;;
