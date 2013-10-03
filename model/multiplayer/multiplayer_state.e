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
	name_of_player: STRING

	my_board:SUDOKU_BOARD -- my sudoku board

	adversary_board:SUDOKU_BOARD -- board of the other player

	solved_board:SUDOKU_BOARD -- solved game

	my_client: SUDOKU_CLIENT

	my_server: SUDOKU_SERVER

	make(player_name: STRING_8)
	require
		player_name /= VOID
	do
		name_of_player:= player_name
	end

feature
	--initialize a new game, and starts a server.
	init_server_game(difficulty: INTEGER)
	local
		server: SUDOKU_SERVER
	do
		my_server:= create_server(difficulty)
		my_board:= my_server.ai.get_unsolved_board
		
	end

	--initialize a new game and it waits for the server IP
	init_client_game
	do
		my_client := create_client
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

	set_ip_address(ip: STRING)
	require
		ip_distinct_of_void: ip/=VOID
	do
		ip_address:= ip
	ensure
		ip_correctly: ip=ip_address
	end

feature {TEST_INIT_SERVER_GAME, TEST_INIT_CLIENT_GAME}

	server_port: INTEGER = 1111

	ip_address: STRING

	--creates a server in orden to start a sudoku game
	create_server(difficult_level: INTEGER): SUDOKU_SERVER
	local
		server: SUDOKU_SERVER
	do
		create server.server_create (server_port, difficult_level) -- By default hardcode the ip server with 11111.
		result:= server
	end

	--creates a client from wich connect to a server in order to communicate with other player.
	create_client: SUDOKU_CLIENT
	local
		client: SUDOKU_CLIENT
	do
		create client.connect(ip_address, name_of_player, server_port)
		result:= client
	end

end
