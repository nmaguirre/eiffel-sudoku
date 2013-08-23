note
	description: "Summary description for {SUDOKU_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_CONTROLLER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do

		end

feature {SUDOKU_BOARD, MAIN_WINDOW} -- Implementation

	model: SUDOKU_BOARD

	gui: MAIN_WINDOW

end
