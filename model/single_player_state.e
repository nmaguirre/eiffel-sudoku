note
	description: "Summary description for {SINGLE_PLAYER_STATE}."
	author: "E. Marchisio"
	date: "09/29/2013"
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
		create board.make
		create ai.make
		--timer should start?--
	end

	make_level(level:INTEGER)
	do
		create ai.make_with_level(level)
		board := ai.get_unsolved_board
		---timer must start---
	end

	board:SUDOKU_BOARD -- the current board

	ai:SUDOKU_AI -- AI that will contains the unsolved board and the solved board

	timer:TIME -- must be arranged with gui team


end
