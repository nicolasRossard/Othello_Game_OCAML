open Game_othello

let rec best_move state =
  match is_finished state with
    |Some x -> (None, x) (* no move possible game is finished*)
    |_ -> let list_ =  List.filter (is_valid state) (all_moves state) in
        	let rec loop l m r = (* Find the move with the best res *)
          match l with
            |[] -> (m ,r) (* No moves possible *)
            |one_move::rest_moves -> (* all moves in list *)
                (* take result of the next move*)
                let (_,next_r) = best_move (play state one_move) in 
                  (* compare result of the next move with the older result *)
                  match (compare (turn state) r next_r) with
                    |Smaller -> (* keep the older res and continue the loop*)
                        loop rest_moves m r
                    |Equal -> (* Keep the older res and continue the loop *)
                        loop rest_moves one_move r
                    |_ -> (* we find one which player wins so we send the information and stop the loop *) (one_move,next_r) in

        (* take the result for best_move *)
        let (best_m,best_result) = loop list_ (List.hd list_) (worst_for(turn state)) in
          (* move option * result *)
          (Some (best_m),best_result);;

let cache f = 
  let memory = Hashtbl.create 100000 in
    (fun arg -> 
	(* check if f(arg) is in memory *)
       if Hashtbl.mem memory arg then Hashtbl.find memory arg
       else  
         (let res=f arg in
            Hashtbl.add memory arg res;
            res));;

let best_move_cache = cache best_move;;
