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
	ai: SUDOKU_AI

feature -- Init
	server_create(a_port: INTEGER;level: INTEGER)
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
			create ai.make_with_level (level)

		ensure
				serverStarted = TRUE
		end


feature -- server action
	send_board_solved()
	--send solved board	
		require
				socket /= Void
		do
			socket.independent_store (ai.get_sol_board)
		end

	send_board_unsolved()
	--send unsolved board	
		require
					socket /= Void
			do
				socket.independent_store (ai.get_unsolved_board)
			end

	send_board(a_serialized_board: STRING)
	--send serialized board	
		require
			socket /= Void
		do
			socket.independent_store (a_serialized_board)
		end

	send_ai
		require
			non_void: socket /= Void
		do
			socket.independent_store (ai)
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

	send_cell_position(x: INTEGER; y: INTEGER)

		require
			(x > 0 and x < 10) and (y > 0 and y < 10)

		local
			server_tuple : TUPLE[INTEGER, INTEGER]
		do
			server_tuple := [x,y]
			socket.independent_store (server_tuple)

		ensure
			socket /= Void
		end

	receive_cell_position():TUPLE[x: INTEGER;y: INTEGER]
		do
			if attached{TUPLE[INTEGER, INTEGER]} socket.retrieved as l_msg then
				Result := l_msg
			end
		ensure
			Result.x >= 1 and Result.x <= 9
			Result.y >= 1 and Result.y <= 9
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
