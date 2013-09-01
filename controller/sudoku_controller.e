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

	set_main_window (first_window: MAIN_WINDOW)
			-- set window reference to this controller
		require
			first_window_void: first_window /= Void
		do
			gui := first_window
		ensure
			window_linked: is_window_linked
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

feature -- Status report

	is_window_linked: BOOLEAN
			--is window linked  with this controller
		do
			Result := (gui /= Void)
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
				col:=col+1
			end
			row:=row+1
		end
	end

feature{ANY}
	reset_game
	local
		new_model:SUDOKU_BOARD
	do
		create new_model.make_with_random_values (32)
		set_model(new_model)
		update_gui

	end

	set_gui(view:MAIN_WINDOW)
	do
		gui:=view
	end

end
