note
	description: "Summary description for {SUDOKU_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_CLIENT
inherit
	SOCKET_RESOURCES

	STORABLE

create
	connect

feature

	isConnected : BOOLEAN
	gameStarted : BOOLEAN
	socket: NETWORK_STREAM_SOCKET

feature --Init

	connect(a_IP_ADDR: STRING; a_player_name: STRING; a_port: INTEGER) --Connect
		require
				isConnected = FALSE
				a_IP_ADDR /= VOID
		do
			create socket.make_client_by_port (a_port, a_IP_ADDR)
			socket.connect
			isConnected := TRUE
			gameStarted := TRUE
			print("CONNECTED")
		ensure
				isConnected = TRUE
		end


feature --Client actions


	send_state_update(a_state: STRING)
	--send to other player
		require
				a_state /= VOID
				isConnected = TRUE
				gameStarted = TRUE
		do
			socket.independent_store (a_state)
		end

	receive_solved_board(): SUDOKU_BOARD
	--receives a solved board
		do
			if attached{SUDOKU_BOARD} socket.retrieved as l_msg then
				Result := l_msg
			end
		end

	receive_ai(): SUDOKU_AI
	--receives a solved board
		do
			if attached{SUDOKU_AI} socket.retrieved as l_msg then
				Result := l_msg
			end
		end

	receive_unsolved_board(): SUDOKU_BOARD
	--receives a unsolved board
		do
			if attached{SUDOKU_BOARD} socket.retrieved as l_msg then
				Result := l_msg
			end
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

	receive_state_update():STRING
	--receive the updates of the game
	require
		socket /= Void
		do
				if attached{STRING} socket.retrieved as l_msg then
					Result := l_msg
				end
		ensure
			non_void: Result /= Void
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
	disconnect_client()
		require
			isConnected = TRUE
		do
			socket.cleanup
			isConnected := FALSE
			gameStarted := FALSE

		ensure
				isConnected = FALSE
		rescue
				if socket /= Void then
					socket.cleanup
				end
	end

		invariant
			socket /= Void

end
