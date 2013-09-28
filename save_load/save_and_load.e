note
	description: " Class to save (or load) a game {SAVE_AND_LOAD}."
	author: "Matias Donatti"
	date: "24/09/13"
	revision: "$Revision$"

class
	SAVE_AND_LOAD

inherit
	STORABLE

create
	init

feature {ANY} --Initialize
	init(board:SUDOKU_BOARD;init_time:TIME_DURATION)
	once
		the_instance:=current
		time:=init_time
		game := board
		name_game := ""
	end

feature {ANY} -- save on file
	save(new_name_game:String)
		--Save game with name new_name_game
	require
		new_name_game.count>0
	do
		store_by_name ("./save_load/games/"+new_name_game)
		name_game := new_name_game
	end

feature {ANY} -- open from file
	load(new_name_game:STRING)
		--Open game with name new_name_game
	require
		new_name_game.count>0
	local
		obj_retrieved : ANY
	do
		obj_retrieved := retrieve_by_name ("./save_load/games/"+new_name_game)
		if attached {SAVE_AND_LOAD} obj_retrieved as file then
			set_sudoku_board(file.get_sudoku_board())
			name_game := new_name_game
		end
	end

feature {ANY} -- Access

	get_sudoku_board:SUDOKU_BOARD
		-- Obtain board saved
	do
		result:= game
	end

	set_sudoku_board(new_game : SUDOKU_BOARD)
		-- Changed board
	do
		game:= new_game
	end

	get_time:TIME_DURATION
		-- Obtain time saved
	do
		result:= time
	end

	set_time(new_time : TIME_DURATION)
		-- Changed time
	do
		time:= new_time
	end

	already_saved:BOOLEAN
		-- Verify if the game already saved
	do
		result := not name_game.is_equal ("")
	end

feature {NONE}
	the_instance: SAVE_AND_LOAD
	time: TIME_DURATION
	game: SUDOKU_BOARD
	name_game:STRING
		--Name of game current
end
