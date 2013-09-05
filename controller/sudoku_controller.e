note
	description	: "{SUDOKU_CONTROLLER}.Receive a number from the GUI then sends it to Model. Checks if sudoku is completed. Update the GUI when creating a board"
	author		: ""
	date		: "04/09/2013"
	revision	: "0.1"

class
	SUDOKU_CONTROLLER

create
	make

feature  -- Initialization

	make
			-- Initialization for `Current'.
		once
			the_instance := current
			create model.make
		end

	set_main_window (first_window: MAIN_WINDOW)
			-- Set window reference to this controller
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
			-- Return reference to this object
		do
			Result := the_instance
		end

feature -- Status report

	is_window_linked: BOOLEAN
			-- Is window linked  with this controller
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
        if model.cell_is_settable(row,col) then --if cell is settable, so change model value.
 			model.set_cell(row, col, value)
        else
        	if value/= model.cell_value (row, col) then --If cell isn't settable and new value =/ model value, can't modifique model value, because value was create for random.
        		      update_gui
        	end
		end
	end


	unset_cell (row,col : INTEGER) --VER se recursiona el update de gui
	require
        unset_cell_row: row>=0 and row<=9
        unset_cell_col: col>=0 and col<=9
	do
		--if cell is not set then we can't do anything
		if model.cell_value (row, col) /= 0 and model.cell_is_settable (row, col)  then -- if cell is settable, I can erase its value.
			model.unset_cell (row, col)
		else
			if model.cell_value(row,col)/=0 then -- if cell isn't settable and default value /=0 should't modifique cell and you should update GUI
				update_gui
			end
		end
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
end
