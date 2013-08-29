note
	description: "Summary description for {SUDOKU_CONTROLLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_CONTROLLER

create
	make

feature  -- Initialization

	make
			-- Initialization for `Current'.
		once
			the_instance := current
		end

	set_model (first_model: SUDOKU_BOARD)
		require
			model_void: first_model /= void
		do
			model := first_model
		end

	get_controller: SUDOKU_CONTROLLER
			-- return reference to this object
		do
			Result := the_instance
		end

feature {NONE} -- Implementation

	the_instance: SUDOKU_CONTROLLER

	model: SUDOKU_BOARD

	gui: MAIN_WINDOW

feature {ANY}

 	set_cell (row: INTEGER; col: INTEGER; value: INTEGER)
    require
        set_cell_row: row>=0 and row<=9
        set_cell_col: col>=0 and col<=9
        set_cell_value: value>=1 and value<=9
	do
        model.set_cell(row, col, value)
	end

end
