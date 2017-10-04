# Othello_Game_OCAML
Réalisation du jeu Othello (Reversi) avec le langage OCAML



------------------------
I. Jeu: Othello (ou Reversi)
-------------------------

Définition wikipedia: https://fr.wikipedia.org/wiki/Othello_(jeu)#R.C3.A8gles_du_jeu 
"Othello (aussi connu sous le nom Reversi) est un jeu de société combinatoire abstrait opposant deux joueurs.

Il se joue sur un tablier unicolore de 64 cases, 8 sur 8, appelé othellier. Les joueurs disposent de 64 pions bicolores, noirs d'un côté et blancs de l'autre. En début de partie, quatre pions sont déjà placés au centre de l'othellier : deux noirs, en e4 et d5, et deux blancs, en d4 et e5. Chaque joueur, noir et blanc, pose l'un après l'autre un pion de sa couleur sur l'othellier selon des règles précises. Le jeu s'arrête quand les deux joueurs ne peuvent plus poser de pion. On compte alors le nombre de pions. Le joueur ayant le plus grand nombre de pions de sa couleur sur l'othellier a gagné."

**** IMPORTANT: ****
Les règles adaptées mises en place:
- plateau de 16 cases (4 x 4) seulement un pion blanc O (Ordinateur) et un pion noir X (Joueur) sont posés. les lignes commencent à 1 et les colonnes aussi
- un joueur ne peut jouer que sur les cases vides qui ont au moins une case voisine non-vide (case horizontale ou verticale pas en diagonale). Un joueur doit jouer même s'il ne capture pas de pions adverses
- Si un joueur pose un pion X à l'extrémité d'un alignement des pions adverses contigues et que l'autre extrémité est occupé par un de ses pions alor tous les pions de l'adverse qui sont entre les deux pions du joueurs sont capturés et deviennent des pions du joueur
- Quand toutes les cases du plateau sont pleines on compte le nombre de pions pour chaque joueur (Egalité ou Victoire d'un joueur )
 ****** FIN ********


------------------------
II. Organisation
------------------------

J'ai commencé par coder game.ml et game_othello.ml en parallèle en réalisant des tests pour chaque fonction (cf test.ml)
Puis j'ai essayé de jouer à othello sans utiliser l'IA pour vérifier si toutes mes fonctions étaient correctes. Pour faire une partie à deux joueurs (l'un s'appelle Human, l'autre Comput) faire:

ocamlbuild gameplay_n.native
./gameplay_n.native

J'ai terminé par faire la fonction best_move et je l'ai testée pour les deux jeux. J'ai utilisé le cache que nous avions fait pendant le cours pour améliorer la fonction best_move -> best_move_cache (c'est cette fonction qui est utilisée dans le gameplay). Comme vous l'avez prédit c'est seulement 10 lignes mais c'était difficile de les trouver !

Toutes mes fonctions sont expliquées directement dans les fichiers.ml

...................................
. Bonne Lecture & Bonne Partie :D .
...................................

------------------------
III. Game_othello.ml
------------------------

Le plus dur a été de réaliser la mise à jours du plateaeu en fonction du pion posé et du coup des pions qui ont été capturés
Voici l'arbre des fonctions utilisées et de leurs sous-sousfonctions:
function: 
(* Mets à jour le plateau avec le mouvement du joueur mais ne mets pas à jours le joueur ! *)
update_m state move
	-> update_row
		-> find_lign_left
		-> find_lign_right
			
	-> update_column
		-> find_column_high
		-> find_column_down	

(* Fonction non-utilisées utilisable même pour une matrice vide*)
count_score state player
	->count_score_row
=> renvoie le score pour un joueur

(* Fonction utilisable qu'à la fin de la partie. J'aurai pu ignorer les cases vides de pions mais c'était pour vérifier que is_finished fonctionnait correctement *)
get_score state
	-> get_score_ state 0 0 lg ((0,Human),(0,Comput));;  (* 0 0 sont les coordonnées de la premières case du plateau *)

=> renvoie le score de type ((scr1,p1),(scr2,p2))

is_finished state 
	-> is_finished_ state (* renvoie vrai si toutes les cases sont remplies *)
	-> get_score state
=> result option

Critique:
Certaines fonctions peuvent être optimisées notamment je pense la partie de la mise à jours de la matrice. Notamment si update_m mets à jours le joueur et clone la matrice ça devient la fonction play.


------------------------
IV. Phase de test
------------------------

J'ai effectué quelques tests dans le fichier test.ml. 
Pour l'exécuter sur ocaml-top j'ai mis toutes les explications dans le fichier test.ml


------------------------
V. Annexes
------------------------

Comment exécuter mon code:

Dans first_game:

	ocamlbuild gameplay.native
	./gameplay.native

Dans othello_game:

	- Partie H vs C
		ocamlbuild gameplay_othello.native
		./gameplay_othello.native

	- Partie H vs H
		ocamlbuild gameplay_n.native
		./gameplay_n.native

	- Lancer la phase de test
	Suivre les consignes dans le fichier


