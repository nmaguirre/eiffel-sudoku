note
	description: "Summary description for {MULTIPLAYER_STATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLAYER_STATE
inherit
	STORABLE
create
	make

feature {ANY}
	make
	do

	end

	my_board:SUDOKU_BOARD -- board of mine

	adversary_board:SUDOKU_BOARD -- board of the other player

	solved_board:SUDOKU_BOARD -- solved game

	my_client: SUDOKU_CLIENT

feature
	initialize a new game, if the option number is zero, then the feature starts a server, else, it waits for the servers ip.
	init_game(option: INTEGER)

	--reports a correct fill in the current sudoku board, in order to reflect changes in the adversary board.
	report_play()

	--recieves the coordenades from a move from the adversary and modifies the proper board.
	recieve_adversary_play(cell: COORDS)

	--reports game victory to server in order to inform the adversary
	report_victory

	--reports the current uster decision to leave the game (implying a victory for the opponent)
	report_surrender

feature {NONE}
	--creates a server in orden to start a sudoku game
	create_server
	--creates a client from wich connect to a server in order to communicate with other player.
	create_client
end

end
