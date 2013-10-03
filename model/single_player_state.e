note
	description: "Summary description for {SINGLE_PLAYER_STATE}."
	author: "E. Marchisio"
	date: "10/01/2013"
	revision: "$Revision$"

class
	SINGLE_PLAYER_STATE

inherit
	STORABLE

create
	make, make_level

feature {ANY}

	make
	do
		create ai.make
		--timer should start?--
	end

	make_level(level:INTEGER)
	do
		create ai.make_with_level(level)
	end

	-- creates the timer
	make_timer
	do
		create timer.make
	end

	timer:CLOCK -- the clock

	-- Returns a hint for the respective board
	get_hint:SUDOKU_HINT
	do
		Result:= ai.get_hint(board)
	end

	-- Returns the current board
	board:SUDOKU_BOARD
	do
		Result:= ai.get_unsolved_board
	end

	get_hint_number:INTEGER
	do
		Result:= ai.get_hint_counter
	end

feature {NONE}

	ai:SUDOKU_AI -- AI that will contains the unsolved board and the solved board

feature {ANY}

	hint_not_settable(row,col: INTEGER)
	do
		ai.one_cell_not_settable(row,col)
	end

end
