(* There are two players, called Human and Comput. *)
type player = Human | Comput

(* X human O comput E empty cell *)
type disk = X | O | E

(* show disk of player *)
val disk2p: player -> disk

(* next Human is Comput 
 * next Comput is Human *)
val next: player -> player

(* to_string *)
val player2s: player -> string
val disk2s: disk -> string



(*** Helper functions on matrices. *)

type 'a matrix = 'a array array

val clone_matrix: 'a matrix -> 'a matrix

(* Finds a cell which satisfies the predicate (p). 
 * Returns Some (row, col) if the cell at (row, col) satisfies p.
 * Returns None if no cell satisfies p. *)
val find_cell: 'a matrix -> ('a -> bool) -> (int * int) option

(* matrix2s mat v2s : maps a matrix to a printable string.
 *                    v2s maps a single value to a string (of fixed length, e.g. always 2 characters). *)
val matrix2s: 'a matrix -> ('a -> string) -> string


(* Personal explications 
   find_cell: renvoie tuple (ligne,colonne) s'il trouve une cellle contenant le prédicate
   matrix2s -> affiche la matrice correctement*)
