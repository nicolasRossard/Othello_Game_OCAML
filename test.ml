#use "game_othello.ml"
(* To execute test.ml on ocaml-top*)
(* In the file game_othello.ml replace: open Gamebase_othello to: #use "gamebase_othello.ml"

   If you want make test for IA function do:
   In the file game_ia_othello.ml replace: open Gamebase_othello to: #use "game_othello.ml" 
then launch ocaml-top test.ml
*)
(* PHASE TEST *)
(* -------------------------------------------------------------------------------*)
(* IS_VALID *)
let mat8 = Array.make_matrix 4 4 E;;
mat8.(0).(0) <- O;;
mat8.(0).(1) <- O;;
mat8.(1).(0) <- X;;
mat8.(1).(1) <- X;;
mat8.(2).(1) <- X;;
mat8.(3).(2) <- X;;
mat8.(3).(3) <- O;;
matrix2s mat8 disk2s;;

is_valid (mat8,Human) (0,3);;
is_valid (mat8,Human) (0,0);;
is_valid (mat8,Human) (0,2);;
is_valid (mat8,Human) (3,1);;
is_valid (mat8,Human) (0,0);;
(* -------------------------------------------------------------------------------*)
(* FIND_COLUMN_HIGH *)

(* 1er cas on est au bout *)
(* renvoie (0,0) *)
let mat1 = Array.make_matrix 4 4 E;;
mat1.(0).(0) <- X;;
matrix2s mat1 disk2s;;
find_column_high (mat1, Human) (0,0);;

(*2eme cas la case en haut est vide*)
(* renvoie (1,0) *)
let mat2 = Array.make_matrix 4 4 E;;
mat2.(1).(0) <- X;;
matrix2s mat2 disk2s;;
find_column_high (mat2, Human) (1,0);;

(*3eme cas on a un pion de l'autre joueur mais on atteint le bout de la colonne donc le joueur n'a pas pris de pions adverses*)
(* renvoie (1,0)*)
let mat3 = Array.make_matrix 4 4 E;;
mat3.(1).(0) <- X;;
mat3.(0).(0) <- O;;
matrix2s mat3 disk2s;;
find_column_high (mat3, Human) (1,0);;

(*4eme cas on a un pion de l'autre joueur mais on une case vide après donc le joueur n'a pas pris de pions adverses*)
(* renvoie (2,0) *)
let mat4 = Array.make_matrix 4 4 E;;
mat4.(2).(0) <- X;;
mat4.(1).(0) <- O;;
matrix2s mat4 disk2s;;
find_column_high  (mat4, Human) (2,0);;

(*5eme cas on trouve à la fin un pion identique à celui du joueur donc on récupère tous les pions entre les deux*)
(* renvoie (0,0) l'adresse du pion *)
let mat5 = Array.make_matrix 4 4 E;;
mat5.(0).(0) <- X;;
mat5.(1).(0) <- O;;
mat5.(2).(0) <- O;;
mat5.(3).(0) <- X;;
matrix2s mat5 disk2s;;
find_column_high (mat5, Human) (3,0);;


(* -------------------------------------------------------------------------------*)
(* FIND_COLUMN_DOWN *)
(* 1er cas on est au bout *)
(* renvoie (3,0) *)
let mat1 = Array.make_matrix 4 4 E;;
mat1.(3).(0) <- X;;
matrix2s mat1 disk2s;;
find_column_down (mat1, Human) (3,0);;

(*2eme cas la case en bas est vide*)
(* renvoie (0,2) *)
let mat2 = Array.make_matrix 4 4 E;;
mat2.(0).(2) <- X;;
matrix2s mat2 disk2s;;
find_column_down (mat2, Human) (0,2);;


(*3eme cas on a un pion de l'autre joueur mais on atteint le bout de la colonne donc le joueur n'a pas pris de pions adverses*)
(* renvoie (2,0)*)
let mat3 = Array.make_matrix 4 4 E;;
mat3.(2).(0) <- X;;
mat3.(3).(0) <- O;;
matrix2s mat3 disk2s;;
find_column_down (mat3, Human) (2,0);;

(*4eme cas on a un pion de l'autre joueur mais on une case vide après donc le joueur n'a pas pris de pions adverses*)
(* renvoie (1,0) *)
let mat4 = Array.make_matrix 4 4 E;;
mat4.(1).(0) <- X;;
mat4.(2).(0) <- O;;
matrix2s mat4 disk2s;;
find_column_down  (mat4, Human) (1,0);;

(*5eme cas on trouve à la fin un pion identique à celui du joueur donc on récupère tous les pions entre les deux*)
(* renvoie (3,0) l'adresse du pion *)
let mat5 = Array.make_matrix 4 4 E;;
mat5.(0).(0) <- X;;
mat5.(1).(0) <- O;;
mat5.(2).(0) <- O;;
mat5.(3).(0) <- X;;
matrix2s mat5 disk2s;;
find_column_down (mat5, Human) (0,0);;

(* -------------------------------------------------------------------------------*)
(* FIND_LIGN_LEFF *)
(* 1er cas on est au bout *)
(* renvoie (0,0) *)
let mat1 = Array.make_matrix 4 4 E;;
mat1.(0).(0) <- X;;
matrix2s mat1 disk2s;;
find_lign_left (mat1, Human) (0,0);;

(*2eme cas la case a gauch est vide*)
(* renvoie (0,2) *)
let mat2 = Array.make_matrix 4 4 E;;
mat2.(0).(2) <- X;;
matrix2s mat2 disk2s;;
find_lign_left (mat2, Human) (0,2);;

(*3eme cas on a un pion de l'autre joueur mais on atteint le bout de la ligne donc le joueur n'a pas pris de pions adverses*)
(* renvoie (0,1)*)
let mat3 = Array.make_matrix 4 4 E;;
mat3.(0).(1) <- X;;
mat3.(0).(0) <- O;;
matrix2s mat3 disk2s;;
find_lign_left (mat3, Human) (0,1);;

(*4eme cas on a un pion de l'autre joueur mais on une case vide après donc le joueur n'a pas pris de pions adverses*)
(* renvoie (0,3) *)
let mat4 = Array.make_matrix 4 4 E;;
mat4.(0).(3) <- X;;
mat4.(0).(2) <- O;;
mat4.(0).(1) <- O;;

matrix2s mat4 disk2s;;
find_lign_left (mat4, Human) (0,3);;

(* 5eme cas on trouve à la fin un pion identique à celui du joueur donc on récupère tous les pions entre*)
(* renvoie (0,0) l'adresse du pion *)
let mat5 = Array.make_matrix 4 4 E;;
mat5.(0).(0) <- X;;
mat5.(0).(1) <- O;;
mat5.(0).(2) <- O;;
mat5.(0).(3) <- X;;
matrix2s mat5 disk2s;;
find_lign_left (mat5, Human) (0,3);;

(* -------------------------------------------------------------------------------*)
(* FIND_LIGN_RIGHT *)
(* Idem pour colonne indice croissant *)
(* Idem pour colonne indice décroissant *)
(* étude des possibilités *)
(* 1er cas on est au bout *)
(* renvoie (0,3) *)
let mat1 = Array.make_matrix 4 4 E;;
mat1.(0).(3) <- X;;
matrix2s mat1 disk2s;;
find_lign_right (mat1, Human) (0,3);;
(*2eme cas la case a droite est vide*)
(* renvoie (0,2) *)
let mat2 = Array.make_matrix 4 4 E;;
mat2.(0).(2) <- X;;
matrix2s mat2 disk2s;;
find_lign_right (mat2, Human) (0,2);;
(*3eme cas on a un pion de l'autre joueur mais on atteint le bout de la ligne donc le joueur n'a pas pris de pions adverses*)
(* renvoie (0,2)*)
let mat3 = Array.make_matrix 4 4 E;;
mat3.(0).(2) <- X;;
mat3.(0).(3) <- O;;
matrix2s mat3 disk2s;;
find_lign_right (mat3, Human) (0,2);;

(*4eme cas on a un pion de l'autre joueur mais on une case vide après donc le joueur n'a pas pris de pions adverses*)
(* renvoie (0,0) *)
let mat4 = Array.make_matrix 4 4 E;;
mat4.(0).(0) <- X;;
mat4.(0).(1) <- O;;
mat4.(0).(2) <- O;;

matrix2s mat4 disk2s;;
find_lign_right (mat4, Human) (0,0);;

(* 5eme cas on trouve à la fin un pion identique à celui du joueur donc on récupère tous les pions entre*)
(* renvoie (0,3) l'adresse du pion *)
let mat5 = Array.make_matrix 4 4 E;;
mat5.(0).(0) <- X;;
mat5.(0).(1) <- O;;
mat5.(0).(2) <- O;;
mat5.(0).(3) <- X;;
matrix2s mat5 disk2s;;
find_lign_right (mat5, Human) (0,0);;
(* -------------------------------------------------------------------------------*)
(* TEST FIND MATRIX QCQ *)
let mat6 = Array.make_matrix 4 4 E;;
mat6.(0).(0) <- X;;
mat6.(0).(1) <- O;;
mat6.(1).(0) <- X;;
mat6.(0).(0) <- O;;
mat6.(1).(1) <- X;;
mat6.(2).(2) <- X;;
mat6.(0).(2) <- O;;
mat6.(1).(3) <- X;;
mat6.(1).(2) <- O;;
mat6.(0).(3) <- X;;
mat6.(3).(2) <- O;;
matrix2s mat6 disk2s;;
find_lign_right (mat6, Human) (0,3);;
find_lign_left (mat6, Human) (1,3);;
find_column_down (mat6, Human) (1,3);;
find_column_high (mat6, Comput) (3,2);;

(* -------------------------------------------------------------------------------*)
(* COUNT SCORE ROW ; COUNT SCORE *)
let a = Array.make_matrix 4 4 E;;
Array.length a.(0);;
a.(0).(0)<- X;;
a.(0).(1)<- X;;
a.(1).(0)<- O;;
a.(1).(1)<- O;;
a.(1).(2)<- O;;
matrix2s a disk2s;;
count_score_row a.(1) Human;;
let res = count_score (a,Human) Human;;
let res = count_score (a,Human) Comput;;
(* -------------------------------------------------------------------------------*)
(* UPDATE *)
let mat6 = Array.make_matrix 4 4 E;;
mat6.(0).(1) <- O;;
mat6.(1).(0) <- X;;
mat6.(0).(0) <- O;;
mat6.(1).(1) <- X;;
mat6.(2).(2) <- X;;
mat6.(0).(2) <- O;;
mat6.(1).(3) <- X;;
mat6.(1).(2) <- O;;
mat6.(0).(3) <- X;;
mat6.(3).(2) <- O;;
matrix2s mat6 disk2s;;

let (new_m,p) = update_row (mat6,Human) (1,1) (1,3);;
matrix2s new_m disk2s;;


let (new_m,p) = update_column (mat6,Comput) (0,2) (3,2);;
matrix2s new_m disk2s;;


let mat8 = Array.make_matrix 4 4 E;;
mat8.(0).(0) <- O;;
mat8.(0).(1) <- O;;
mat8.(1).(0) <- X;;
mat8.(1).(1) <- X;;
mat8.(2).(1) <- X;;
mat8.(3).(2) <- X;;
mat8.(3).(3) <- O;;
matrix2s mat8 disk2s;;

let (n,p) =update_m (mat8,Comput) (3,1);;
matrix2s n disk2s;;
(* -------------------------------------------------------------------------------*)
(* PLAY *)
let mat8 = Array.make_matrix 4 4 E;;
mat8.(0).(0) <- O;;
mat8.(0).(1) <- O;;
mat8.(1).(0) <- X;;
mat8.(1).(1) <- X;;
mat8.(2).(1) <- X;;
mat8.(3).(2) <- X;;
mat8.(3).(3) <- O;;
matrix2s mat8 disk2s;;

play(mat8,Comput) (3,1);;

(* -------------------------------------------------------------------------------*)
(* All_moves *)
let mat8 = Array.make_matrix 2 2E;;
all_moves (mat8,Human);;
(* -------------------------------------------------------------------------------*)
(* IS_FINISHED_ *)
let mat8 = Array.make_matrix 2 2E;;
mat8.(0).(0) <- O;;
mat8.(0).(1) <- O;;
mat8.(1).(0) <- X;;
mat8.(1).(1) <- X;;

matrix2s mat8 disk2s;;
is_finished(mat8,Human);;
let mat8 = Array.make_matrix 2 2E;;
mat8.(0).(0) <- O;;
mat8.(0).(1) <- O;;
mat8.(1).(0) <- X;;


matrix2s mat8 disk2s;;
is_finished(mat8,Human);;


(* -------------------------------------------------------------------------------*)
(* GET_SCORE *)
let mat8 = Array.make_matrix 2 2E;;
mat8.(0).(0) <- X;;
mat8.(0).(1) <- X;;
mat8.(1).(0) <- X;;
mat8.(1).(1) <- O;;

get_score (mat8,Human);;
mat8.(1).(1) <- E;;
get_score (mat8,Human);;
(* -------------------------------------------------------------------------------*)
