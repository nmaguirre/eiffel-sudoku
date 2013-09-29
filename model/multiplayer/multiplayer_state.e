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
	--initialize a new game, starts a server and returns it
	init_server_game: SUDOKU_SERVER
	do

	end

	--initialize a new game and it waits for the server IP
	init_client_game
	do

	end

	--reports a correct fill in the current sudoku board, in order to reflect changes in the adversary board.
	report_play
	do

	end

	--recieves the coordenades from a move from the adversary and modifies the proper board.
	recieve_adversary_play(cell: COORDS)
	do

	end

	--reports game victory to server in order to inform the adversary
	report_victory
	do

	end

	--reports the current uster decision to leave the game (implying a victory for the opponent)
	report_surrender
	do

	end

feature {NONE}
	--creates a server in orden to start a sudoku game
	create_server
	do

	end

	--creates a client from wich connect to a server in order to communicate with other player.
	create_client
	do

	end

end
