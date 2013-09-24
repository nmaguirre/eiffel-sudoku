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
	init(board:SUDOKU_BOARD)
	do
		game:= board
	end

feature {ANY} -- save on file
	save(name_game:String)
	require
		name_game.length>0
	do
		store_by_name ("./save_load/games/"+name_game)
	end

feature {ANY} -- open from file
	load(name_game:STRING): SAVE_AND_LOAD
	require
		name_game.length>0
	local
		obj_retrieved : ANY
	do
		obj_retrieved := retrieve_by_name ("./save_load/games/"+name_game)
		if attached {SAVE_AND_LOAD} obj_retrieved as file then
			--current.game := file.game
			set_sudoku_board(file.get_sudoku_board())
			return
		end
	end

feature {ANY} -- Access

	get_sudoku_board:SUDOKU_BOARD
	do
		return game
	end

	set_sudoku_board(new_game : SUDOKU_BOARD)
	do
		game:= new_game
	end


feature {NONE}
	game: SUDOKU_BOARD
	--time:clock
end
