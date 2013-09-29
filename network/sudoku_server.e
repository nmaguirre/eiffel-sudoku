note
	description: "Summary description for {SUDOKU_SERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_SERVER
inherit
	SOCKET_RESOURCES

	STORABLE
create
	server_create

feature -- attributes
	serverStarted: 	BOOLEAN
	gameStarted:	BOOLEAN
	server_socket: 	NETWORK_STREAM_SOCKET
	socket: 		NETWORK_STREAM_SOCKET

feature -- Init
	server_create(a_port: INTEGER)
		require
				serverStarted = FALSE
		do
			create server_socket.make_server_by_port (a_port)
			server_socket.listen (1)
			server_socket.accept
			socket := server_socket.accepted
			print("Server created")
			serverStarted := TRUE
			gameStarted := TRUE

		ensure
				serverStarted = TRUE
		end


feature -- server action
	start_game(multip_state: MULTIPLAYER_STATE)
		require
				socket /= Void
		local
			--ai: SUDOKU_AI
			--board:SUDOKU_BOARD -- board of mine
			--adversary_board:SUDOKU_BOARD -- board of the other player
			--solved_board:SUDOKU_BOARD -- solved game
			--multip_state: MULTIPLAYER_STATE --multiplayer state
		do
			--create ai.make_with_level (level)
			socket.independent_store (multip_state)

		end

	send_board(a_serialized_board: STRING)
		require
			socket /= Void
		do
			socket.independent_store (a_serialized_board)
		end

	send_state_update(a_state: STRING)
	--sends the updates of the game
		require
			non_void: a_state /= Void
		do
			socket.independent_store (a_state)
		end

	receive_state_update(): STRING
	--receive game updates
	do
			if attached{STRING} socket.retrieved as l_msg then
				Result := l_msg
			end
	ensure
			non_void: Result /= Void
	end

	send_winner_id(a_winner_id: INTEGER)
	--sends the id of the winning player and time of game
		require
				a_winner_id >=1
		do
				socket.independent_store (a_winner_id)
		ensure
				socket /= Void
		end

	receive_winner_id(): INTEGER
		--receive the winner id
		do
				if attached{INTEGER} socket.retrieved as l_msg then
					Result := l_msg
				end
		ensure
			Result >=1
		end



feature
	close_server
		require
			serverStarted = TRUE
		do
			socket.cleanup
			gameStarted := FALSE
			serverStarted :=FALSE
		ensure
				gameStarted = FALSE
				serverStarted = FALSE
		rescue
				if socket /= Void then
					socket.cleanup
				end
		end

	invariant
		socket /= Void


end
