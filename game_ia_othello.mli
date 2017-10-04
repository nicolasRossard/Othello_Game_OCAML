open Game_othello

(* Returns the best result the current player can reach. 
 * Returns None if the game is finished in the current state. *)
val best_move: state -> move option * result

(* Same as best_move with cache *)
val best_move_cache: state -> move option * result
