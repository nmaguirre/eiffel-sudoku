note
	description: "Summary description for {MULTIPLAYER_STATE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLAYER_STATE
create
	make

feature {ANY}
	make
	do

	end

	my_board:SUDOKU_BOARD -- board of mine

	adversary_board:SUDOKU_BOARD -- board of the other player

	solved_board:SUDOKU_BOARD -- solved game

end
