note
	description: "Summary description for {SINGLE_PLAYER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SINGLE_PLAYER_STATE

create
	make

feature {ANY}
	make
	do

	end

	single_board:SUDOKU_BOARD -- board of the single player

	timer:TIME -- must be arranged with gui team
end
