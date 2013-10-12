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
    -- Name of the current player.
	name_of_player: STRING

    -- Instance of the connection of the client.
	my_client: SUDOKU_CLIENT

    -- Instance of the connection of the server.
	my_server: SUDOKU_SERVER

    -- Constructor of the class. Take the name of the player.
	make(player_name: STRING_8)
	require
		player_name /= VOID
	do
		name_of_player:= player_name
	end

feature
	--initialize a new game, and starts a server.
	init_server_game(difficulty: INTEGER)
    require
        connection_not_available: is_connected = False
	local
		server: SUDOKU_SERVER
	do
		my_server:= create_server(difficulty)
        is_connected := True
		my_server.send_ai
    ensure
        connection_available: is_connected = True
	end

	--initialize a new game and it waits for the server IP
	init_client_game
    require
        connection_not_available: is_connected = False
	do
		my_client := create_client
        is_connected := True
    ensure
        connection_available: is_connected = True
	end

	--reports a correct fill in the current sudoku board, in order to reflect changes in the adversary board.
	report_play(row,col: INTEGER)
    require
        connection_available: is_connected = True
	do
        if is_client_game then
			my_client.send_cell_position(row,col)
		else
			my_server.send_cell_position(row,col)
        end
    ensure
        connection_available: is_connected = True
	end

	--recieves the coordenades from a move from the adversary and modifies the proper board.
	receive_adversary_play
    require
        connection_available: is_connected = True
	local
	    coords : TUPLE[INTEGER,INTEGER]
	do
	-- must be updated the gui of the adversary board!
		if is_client_game then
			coords := my_client.receive_cell_position
		else
			coords := my_server.receive_cell_position
		end
    ensure
        connection_available: is_connected = True
	end

	--reports game victory to server in order to inform the adversary
	report_victory
    require
        connection_available: is_connected = True
	do
        if is_client_game then
			my_client.send_winner_id(2) -- this parameter must be the ID of the current client.
		else
			my_server.send_winner_id(1)
		end
    ensure
        connection_available: is_connected = True
	end

    -- Modified the ip address.
	set_ip_address(ip: STRING)
	require
		ip_distinct_of_void: ip/=VOID
        connection_not_available: is_connected = False
	do
		ip_address:= ip
	ensure
		ip_correctly: ip=ip_address
        connection_not_available: is_connected = False
	end

    --Returns true iff server or client it's running.
	is_connected: BOOLEAN

	--Reports to the adversary that I surrendered, i.e. he's the winner
    report_surrender
    require
        connection_available: is_connected = True
	do
		if is_client_game then
			my_client.send_winner_id (1) 
			my_client.disconnect_client
		else
			my_server.send_winner_id (2)
			my_server.close_server
		end
	end

	-- Return true iff anybody sent me something.
	receive_something: BOOLEAN
    require
        connection_available: is_connected = True
	do
        if is_server_game then
            Result:= my_server.socket.is_readable
        else
            Result:= my_client.socket.is_readable
        end
    ensure
        connection_available: is_connected = True
	end

    -- Returns true iff the player is the server.
    is_server_game: BOOLEAN
    do
		Result := is_connected and my_server /= Void and my_client = Void
    end

    -- Returns true iff the player is the client.
	is_client_game: BOOLEAN
	do
		Result := is_connected and my_client /= Void and my_server = Void
    end


feature {TEST_INIT_SERVER_GAME, TEST_INIT_CLIENT_GAME}

    -- Port of the server HARCODED.
	server_port: INTEGER = 1111

    -- ip address of the client.
	ip_address: STRING

	--creates a server in orden to start a sudoku game
	create_server(difficult_level: INTEGER): SUDOKU_SERVER
    require
        connection: is_connected = False
	local
		server: SUDOKU_SERVER
	do
		create server.server_create (server_port, difficult_level) -- By default hardcode the ip server with 11111.
		is_connected:= True
		result:= server
	end

	--creates a client from wich connect to a server in order to communicate with other player.
	create_client: SUDOKU_CLIENT
    require
        connection: is_connected = False
	local
		client: SUDOKU_CLIENT
	do
		create client.connect(ip_address, name_of_player, server_port)
		is_connected:= True
		result:= client
	end

end
