note
	description: "Summary description for {SUDOKU_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_CLIENT
inherit
	SOCKET_RESOURCES

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

		end

	receive_board(): STRING
	--receives a board
		do

		end


	send_winner_id(a_winner_id: INTEGER; a_time: TIME)
	--sends the id of the winning player and time of game
		require
				a_winner_id >=1
		do

		ensure
				socket /= Void
		end

	receive_winner_id(): TUPLE[winner_id: INTEGER; time: TIME]
		--receive the winner id
		do

		ensure
			Result.winner_id >=1
		end

	receive_state_update():STRING
	--receive the updates of the game
	require
		socket /= Void
		do

		ensure
			non_void: Result /= Void
		end

feature
	disconnect_client()
		require
			isConnected = TRUE
		do

		ensure
				isConnected = FALSE
		end

		invariant
			socket /= Void

end
