note
	description: "Summary description for {SUDOKU_SERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_SERVER
inherit
	SOCKET_RESOURCES
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
	send_board(a_serialized_board: STRING)
		require
			socket /= Void
		do

		end

	send_state_update(a_state: STRING)
	--sends the updates of the game
		require
			non_void: a_state /= Void
		do

		end

	receive_state_update(): STRING
	--receive game updates
	do

	ensure
			non_void: Result /= Void
	end

	send_winner_id(a_winner_id: INTEGER; a_time: TIME)
	--sends the id of the winning player and time of game
		require
				a_winner_id >=1
		do

		ensure
				socket /= Void
		end

	receive_winner_id(): TUPLE[winner_id: INTEGER; a_time: TIME]
		--receive the winner id
		do

		ensure
			Result.winner_id >=1
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
