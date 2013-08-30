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

feature {NONE} -- Implementation

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

	update_gui
	local
		row,col,current_value : INTEGER
	do
		-- need to change 1 et 9 by lower and upper
		from
			row := 1
		until
			row > 9
		loop
			from
				col := 1
			until
				col > 9
			loop
				current_value := model.cell_value (row, col)
				gui.set_value_of_cell(row,col,current_value)
			end
		end
	end
end
