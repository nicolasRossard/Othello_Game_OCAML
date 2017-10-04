open Gamebase_othello
(*#use "gamebase_othello.ml"*)
(* These types are abstract in game.mli *)


(* Je pense que j'ai quelques fonctions que je peux simplifier notamment les dernières *)
(* Othello game *)

(* size of the matrix normally it's 8 *)
let sizeMat = 4;;

(* Matrix and Player who has to play*)
type state = disk matrix * player

(* row and column of the cell *)
type move = int*int

type result = Win of player | EvenGame


(* Printers *)
let state2s (m,p) = Printf.sprintf "%s \n %s to play" (player2s p) (matrix2s m disk2s);;

let move2s (r,c) = Printf.sprintf " %d %d" (r+1) (c+1);;

let result2s = function
  |Win(p) -> (player2s p) ^ " wins"
  |_ -> "Even Game";;


(* Reader*)
let readmove s =
  try Some (Scanf.sscanf s "%d %d" (fun r c -> (r-1,c-1))) (* IMPORTANT r-1?? *)
  with _ -> None;;

(*(*othello *)
  (* initial *)
  let initial = 
  let matrice= Array.make_matrix sizeMat sizeMat E in 
  matrice.(3).(3) <- O ;
  matrice.(3).(4) <- X ;
  matrice.(4).(3) <- X ;
  matrice.(4).(4) <- O;
  (matrice,Human);;*)

(* initial *)
let initial = 
  let matrice= Array.make_matrix sizeMat sizeMat E in 
    matrice.(1).(1) <- O ;
    matrice.(2).(2) <- X ;
    (matrice,Human);;

let turn (_,b) = b

(*Check the cell has a disk *)
let disk_in m (r,c)= 
  try
    not(m.(r).(c) =E) 
  with _->false;;

(* Check if the player can play this move *)
let is_valid state (r,c) = match state with
  |(m,p)-> 
      (* check borders of the matrix *)
      if (r<sizeMat && r>=0 && c<sizeMat && c>=0) then 
        (* check cell is empty*)
        if (m.(r).(c)=E) then 
          (* player can play only if a cell next to his move isn't empty *)
          disk_in m (r+1,c) || disk_in m (r-1,c) || disk_in m (r,c+1) || disk_in m (r,c-1) 
        else false
      else false;;

(* if there is an other disk of the player who played in the same row in the right side and which could be reached (no empty cells between) then the function send back his coordinates else it gives coordinates of disk which was played by the player *)
(* Possibilités pour une ligne (indice allant de façon croissante)
   - SI- Le pion posé n'est pas au bout de la matrice alors

   ------- SI la cellule à côté du pion est:
   ---------------VIDE -> je renvoie l'indice du pion posé
   ---------------NON-VIDE et le pion est le même que celui du joueur -> je renvoie l'indice de ce pion
   -------------- Non-VIDE et pion!= que celui du joueur -> je continue à parcourir la ligne en stockant dans aux l'indice du pion posé par le joueur
   ------- FIN SI
   - SINON - je renvoie l'indice du pion posé
   - FIN SI -
*)
let find_lign_right state move=
  let rec find_lign_right (m,p) (r,c) aux=
    (* check borders of the matrix *)
    if (c+1)<sizeMat then 
      let cell= m.(r).(c+1) in
        if cell = E then aux (* send back last result *)
        else if cell= (disk2p (next p)) then find_lign_right (m,p) (r,c+1) aux (* keep going *)
        else (r,c+1)
    else (* borders of the matrix are reached*)
      aux in
    find_lign_right state move move;;


(* Same for the row in the left side *)
let find_lign_left state move=
  let rec find_lign_left (m,p) (r,c) aux=
    (* check borders of the matrix *)
    if (c-1)>=0 then 
      let cell= m.(r).(c-1) in
        if cell = E then aux (* send back last result *)
        else if cell=disk2p (next p) then find_lign_left (m,p) (r,c-1) aux (* keep going *)
        else (r,c-1)

    else (* borders of the matrix are reached*)
      aux in
    find_lign_left state move move;;


(* Same for the column in the low side*)
let find_column_down state move=
  let rec find_column_down (m,p) (r,c) aux=
    (* check borders of the matrix *)
    if (r+1)<sizeMat then 
      let cell= m.(r+1).(c) in
        if cell = E then aux (* send back last result *)
        else if cell=disk2p (next p) then find_column_down (m,p) (r+1,c) aux (* keep going *)
        else (r+1,c)

    else (* borders of the matrix are reached*)
      aux in
    find_column_down state move move;;

(* ame for the column in the high side*)
let find_column_high state move=
  let rec find_column_high (m,p) (r,c) aux=
    (* check borders of the matrix *)
    if (r-1)>=0 then 
      let cell= m.(r-1).(c) in
        if cell = E then aux (* send back last result *)
        else if cell=disk2p (next p) then find_column_high (m,p) (r-1,c) aux (* keep going *)
        else (r-1,c)

    else (* borders of the matrix are reached*)
      aux in
    find_column_high state move move;;

(* count number of disks on a row for a player *)
let count_score_row t player = 
  let lgth = Array.length t in
  let rec count_score_row t player indice lgth score =
    if (indice < lgth) then
      if (t.(indice) = disk2p player) then
        count_score_row t player (indice+1) lgth (score+1)
      else 
        count_score_row t player (indice+1) lgth score
    else score in 
    count_score_row t player 0 lgth 0;;



(* count number of disks on a matrix for a player *)
let count_score state player_want_his_score = 
  let rec count_score_t (m,p) player indice_row score=
    if (indice_row < sizeMat) then
      (* count per row *)
      count_score_t (m,p) player (indice_row+1) (score+count_score_row m.(indice_row) player)
    else 
      score in 
    count_score_t state player_want_his_score 0 0;;

(* uptade matrix's rows *)
let rec update_row (m,p) r_start r_end =
  if (r_start=r_end) then
    (m,p)
  else match r_start with
    |(r,c) -> m.(r).(c) <- disk2p p;
        update_row (m,p) (r,(c+1)) r_end;;

(* uptade matrix's columns *)
let rec update_column (m,p) c_start c_end =
  if (c_start=c_end) then
    (m,p)
  else match c_start with
    |(r,c) -> m.(r).(c) <- disk2p p;
        update_column (m,p) (r+1,c) c_end;;

(* update matrix, player's move has already been integrated *)
let update_m state move =
  let state_new1=update_row state (find_lign_left state move) (find_lign_right state move) in
  let state_final =update_column state_new1 (find_column_high state move) (find_column_down state move)  in
    state_final;;

(* give a list of all move's possibilities *)
let all_moves (m,p) =
  let lg = Array.length m.(0) in
  let rec all_moves_list row column size aux=
    if row<size then
      if column < size then 
        all_moves_list row (column+1) size ((row,column)::aux)
      else
        (* border of column is reached, back to 0 and increment the row *)
        all_moves_list (row+1) 0 size aux
    else
      (* all cells have been reached *)
      aux in
    all_moves_list 0 0 lg [];;

(* Send true if i exists in the array *)
let find a i =
  let rec find a i n =
    if a.(n)=i then true
    else find a i (n+1)
  in
    try 
      find a i 0
    with _ -> false;;


(* send back the score of each player ((scr1,p1),(scr2,p2)) *)
let get_score (matrix,player) = 
  let lg = Array.length matrix.(0) in
  let rec get_score_ (m,p) row column size ((s1,p1),(s2,p2))=
    if row<size then
      if column < size then 
        (* look who has its cell *)
        if (disk2p p1) = m.(row).(column) then
          get_score_ (m,p) row (column+1) size ((s1+1,p1),(s2,p2))
        else if (disk2p p2) = m.(row).(column) then
          get_score_ (m,p) row (column+1) size ((s1,p1),(s2+1,p2))
        else 
          (* check if a cell is still empty*)
          ((-1,Human),(-1,Comput))
      else get_score_ (m,p) (row+1) 0 size ((s1,p1),(s2,p2))

    else (* send back the score *)
      ((s1,p1),(s2,p2))  in
    get_score_ (matrix,player) 0 0 lg ((0,Human),(0,Comput));; 


(* send true if all cells aren't empty *)
let is_finished_ state =
  let rec is_finished_ (m,p) index=
    if (find m.(index) E) then 
      false
    else is_finished_ (m,p) (index+1) in
    try
      is_finished_ state 0
    with _ -> true;;

(* send result option *)
let is_finished state =
  if is_finished_ state then
    let ((s1,p1),(s2,p2)) = get_score state in
      if (s1<0) then
        raise Not_found (* if one of cells isn't empty *)
      else if s1<s2 then
        Some (Win(p2))
      else if s1>s2 then
        Some (Win(p1))
      else Some (EvenGame)
  else None



(* put disk of the player and update the matrix *)
let play (m,p) (r,c) = 
  if is_valid (m,p) (r,c) then
    let cloned = clone_matrix m in
      cloned.(r).(c) <- disk2p p;
      let (m_new,player)= update_m (cloned,p) (r,c) in
        (m_new, next player)
  else failwith "Move not playable";;

(* This type was given in game.mli.
 * We have to repeat it here. *)
type comparison = Equal | Greater | Smaller

let compare p r1 r2 = match p,r1,r2 with
  |Human , Win Comput , Win Human -> Greater
  |Human , Win Human , Win Comput  -> Smaller	
  |Comput , Win Comput , Win Human -> Smaller
  |Comput , Win Human , Win Comput  -> Greater		 
  |_,_,_ -> Equal
let worst_for = (fun p -> match p with
                  |Human -> Win Comput
                  |Comput -> Win Human);;

