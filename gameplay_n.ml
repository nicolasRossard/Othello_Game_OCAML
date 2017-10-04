open Gamebase_othello
open Game_othello

(* GAME WITH 2 PLAYERS *)

(* Interactively ask for the player's move. 
 * Returns Some move, or None when the move is invalid. *)
let ask_move state =
  Printf.printf "  => Your move ? write 2 int : first for the row second for the column %!" ;  
  let line = read_line () in

  match readmove line with
  | None ->
    Printf.printf "\n Cannot read this move: %s\n\n%!" line ;
    None
    
  | Some mov ->
    if not (is_valid state mov) then
      begin
        Printf.printf "\n This move is invalid: %s\n\n%!" (move2s mov) ;
        None
      end
    else Some mov

  
(*** Each player in turn. ***)
    
let rec run without_ia state =
  
  (* Print state & which player to play. *)
  Printf.printf "\n%s\n %s to play.\n\n%!" (state2s state) (player2s (turn state)) ;
  
  match is_finished state with
  | Some r ->
    (* Game is finished. Print result. *)
    Printf.printf "*** %s ***\n%!" (result2s r) ;
    ()
    
  | None ->
    (* Game is not finished. Play one turn. *)

    let state' =
        begin match ask_move state with
          | None -> state (* Invalid move, play same state again. *)
          | Some mov -> play state mov
        end
    in
    run without_ia state'


let () = run true initial
