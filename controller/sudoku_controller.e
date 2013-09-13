note
	description	: "{SUDOKU_CONTROLLER}.Receive a number from the GUI then sends it to Model. Checks if sudoku is completed. Update the GUI when creating a board"
	author		: "E. Marchisio"
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
			the_instance := Current

			init_red_cells_list

			create model.make
		end

	init_red_cells_list
	local
		default_coords : COORDS
	do
			--initialize array with 81 coords set at (0,0) and set current_cell_number_zero
			default_coords.initialize
			create list_red_cells.make_filled (default_coords, 1, 81)
			nbr_red_cells := 0
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

	updating_gui:BOOLEAN

feature {ANY}

	-- Sets the cell in the model at the (row,col) position with the "value" value.
	-- Returns True iff the the model has been successfully setted or if the position
	--				can't be changed because it's not settable
	set_cell (row: INTEGER; col: INTEGER; value: INTEGER):BOOLEAN
	obsolete
		"use set_cell_v2 instead"
    require
        set_cell_row: row>=0 and row<=9
        set_cell_col: col>=0 and col<=9
        set_cell_value: value>=1 and value<=9
	do
        if model.cell_is_settable(row,col) then --if cell is settable, so change model value.
 			Result:=model.set_cell(row, col, value)
        else
        	if value/= model.cell_value (row, col) then --If cell isn't settable and new value =/ model value, can't modifique model value, because value was create for random.
        		update_gui_cell(row, col, model.cell_value(row, col))
        	end
        	Result:=True
		end
		-- After setting a cell ask if board is solved if so... tell user he WON
		if model.is_solved then
			gui.request_about_winning_congrats
		end
	end

	-- Sets the cell in the model at the (row,col) position with the "value" value.
    -- Returns True if the the model has been successfully setted or if the position
    -- can't be changed because it's not settable
    set_cell_v2 (row: INTEGER; col: INTEGER; value: INTEGER)
    require
        set_cell_row: row>=0 and row<=9
        set_cell_col: col>=0 and col<=9
        set_cell_value: value>=1 and value<=9
    local
    	insertion_correct : BOOLEAN
	do
		-- we are informing to set_cell if we are updating or not the gui
		-- if not it means we have to set the cells from the model
		if not  updating_gui  then

	        if model.cell_is_settable(row,col) then --if cell is settable, so change model value.
	 			insertion_correct := model.set_cell(row, col, value)
	        else
	        	if value /= model.cell_value (row, col) then --If cell isn't settable and new value =/ model value, can't modifique model value, because value was create for random.
	        		update_gui_cell(row, col, model.cell_value(row, col))
	        	end
	        	insertion_correct := True
			end

			-- we control here if this insertion was correct
			if insertion_correct then
				gui.set_cell_background_color_default(row,col)
			else
				gui.set_cell_background_color_red(row,col)
				add_coord_red_cell(row,col)
			end

			-- check current conflicts
			check_red_cells


			-- After setting a cell ask if board is solved if so... tell user he WON
			if model.is_solved then
				gui.request_about_winning_congrats
			end
		end
	end


	-- Unsets the cell in the model at the (row,col) position.
	unset_cell (row,col : INTEGER) --VER se recursiona el update de gui
	require
        unset_cell_row: row>=0 and row<=9
        unset_cell_col: col>=0 and col<=9
	do
		--if cell is not set then we can't do anything
		if model.cell_value (row, col) /= 0 and model.cell_is_settable (row, col)  then -- if cell is settable, I can erase its value.
			model.unset_cell (row, col)
			check_red_cells
		else
			if model.cell_value(row,col)/=0 then -- if cell isn't settable and default value /=0 should't modifique cell and you should update GUI
				update_gui_cell(row, col, model.cell_value(row, col))
			end
		end
	end

	-- Updates the GUI of the whole cells of the board.
	update_gui
		local
			row, col : INTEGER
		do
			updating_gui := true
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
					-- model.cell_value returns the element in the board at the specified position
					update_gui_cell(row, col, model.cell_value(row, col))
					col := col + 1
				end
				row := row + 1
			end
			updating_gui := false
		end

	-- Updates at the GUI only the cell of coords (row, column) of the board with the value "value".
	update_gui_cell(row, column, value: INTEGER)
		require
			update_gui_cell_row: row >= 0 and row <= 9
			update_gui_cell_column: column >= 0 and column <= 9
			update_gui_cell_value: value >= 0 and value <= 9
		do
			gui.set_value_of_cell(row, column, value)
		end

feature{ANY}

	reset_game(level:INTEGER)
		local
			new_model:SUDOKU_BOARD
		do
			create new_model.make_with_random_values (level)
			set_model(new_model)
			update_gui
			-- need to reinitialisate list of red cells
			nbr_red_cells := 0
		end

feature {NONE} -- control of red cells

	-- Contains coords of all cells painted in red
	list_red_cells : ARRAY[COORDS]
	-- Contains the current number of red cells
	nbr_red_cells : INTEGER

	-- Add an element to the list of cells painted in red
    add_coord_red_cell(row,col:INTEGER)
    local
        coord:COORDS;
    do
    	if not is_already_present(row,col) then
        	create coord.make_with_param(row,col)
        	nbr_red_cells := nbr_red_cells + 1
        	list_red_cells.put(coord,nbr_red_cells)
    	end
    end

	-- Decription : Return if a cell is already present in the list
	is_already_present(row,col : INTEGER) : BOOLEAN
	local
		index : INTEGER
		already_present : BOOLEAN
		current_coords : COORDS
	do
		from
			index := list_red_cells.lower
		until
			index > nbr_red_cells or already_present
		loop
			current_coords := list_red_cells.at (index)
			already_present := current_coords.x = row and current_coords.y = col
			index := index + 1
		end

		result := already_present
	end

	-- Check if some cells are not in conflict anymore
	check_red_cells
	local
		cell_index : INTEGER
		coords : COORDS
	do
		from
			cell_index := 1
		until
			cell_index > nbr_red_cells
		loop

			-- we get the coords
			coords := list_red_cells.at (cell_index)

			-- if at this position the cell is no longer in conflict with another we change its color
			-- and delete it from the list
			if model.is_insertion_correct (coords.x,coords.y) then
				gui.set_cell_background_color_default (coords.x, coords.y)

				-- to delete it from the list we put the last coords at the place of the current coords
				-- and we reduce the number of red_cells
				list_red_cells.put (list_red_cells.at (nbr_red_cells), cell_index)
				nbr_red_cells := nbr_red_cells - 1
			-- else we just check the next one
			else
				cell_index := cell_index + 1
			end
		end
	end


	feature --solve the game

	solve_game
	local
		solver:SUDOKU_SOLVER
	do
		create solver.init_with_board (model)
		print("Start solve %N")
		solver.solve_board
		print("Stop solve %N")
		update_gui
	end



end
