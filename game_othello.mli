open Gamebase_othello


(*** Abstract representation of a two-player game.
 *
 * Othello
 *
*)


(* Size square matrix = 4 it could be changed but you have to change initial disk  *)
(* val sizeMat: -> int *)

(* The type 'state' represents a game configuration.
 *  for example, for tic-tac-toe it is a 3x3 grid 
 *  for connect 4 (puissance 4), it is a 6x7 grid 
 *
 * It contains also the current turn (i.e. which player can play now). *)
type state


(* This type represents a move. 
 *   tic-tac-toe: a coordinate in the grid.
 *   connect 4: a column number. *)
type move


(* This type represents the final result of a game.
 *   For example, it can be the final score of each player (two ints)
 *   or a value of type player indicating the winner (Human wins / Comput wins)
 *   or a three-value result: (Human wins / Comput wins / Even game) *)
type result


(* to_string functions *)
val state2s:   state -> string
val move2s:     move -> string
val result2s: result -> string


(* Reads a move from a string. 
 * Returns None if the string fails to be parsed. *)
val readmove: string -> move option

(* Intialize matrix 4 * 4 cell are empty (E)
	Matrix has already one disk X (1,1) one disk O (2,2)
	human starts to play *)
val initial: state

(* Indicates which player must play now, in the current state. *)
val turn: state -> player


(* Indicates if a move is valid in the current state. 
*)
val is_valid: state -> move -> bool

(* Play a move. 
 * Changes the current player (unless the current player can play twice). 
 *
 * This function has no side effect: the state is duplicated, not mutated. 
   CARREFUL This variable don't check if move is correct*)
val play: state -> move -> state

(* Returns the list of moves that can be played in the current state, or any superset of it.
 * All_moves will be filtered by is_valid in another part of the program anyway.
 *
 * e.g. in connect 4, it can be a list of all columns (although not all columns are playable). 
 * The argument 'state' can be useful in some games (e.g. chess) *)

val all_moves: state -> move list

(* Indicates if the game is finished:
 *   None = the game is not finised
 *   Some r = the game is finished and the result is r *)
val is_finished: state -> result option

(* Type used in the result of compare. See below. *)
type comparison = Equal | Greater | Smaller

(* This function will be used by the AI, in order to find the best move.
 *
 *   compare player old_result new_result:
 *
 *   compare player r1 r2  returns Equal if r1 and r2 are equivalent.
 *                         returns Greater if r2 is better than r1 (from the point of view of player). 
 *                         returns Smaller if r1 is better than r2 (from the point of view of player). *)
val compare: player -> result -> result -> comparison

(* This function will also be used by the AI. 
 * 
 * Returns the worst possible result for the given player. Useful for computing min or max.
 * The worst for Human is supposed to be the best for Comput, and conversely. *)
val worst_for: player -> result

