note
	description	: "{SUDOKU_CONTROLLER}.Receive a number from the GUI then sends it to model.board. Checks if sudoku is completed. Update the GUI when creating a board"
	author		: "E. Marchisio, Marconi-Alvarez-Farias-Astorga"
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
			create multiplayer_controller.make
			create multiplayer_model.make (" ") --Add this line because we had the problem "multiplayer_model void"
			init_red_cells_list
			create current_level.make_empty
			create multiplayer_controller.make  -- Creates the controller for the multiplayer_window
			create model.make(Void)
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

	set_main_window (first_window: ABSTRACT_MAIN_WINDOW)
			-- Set window reference to this controller
		require
			first_window_void: first_window /= Void
		do
			gui := first_window
		ensure
			window_linked: is_window_linked
		end


	set_model (first_model: SINGLE_PLAYER_STATE)
		require
			model_void: first_model /= void
		do
			model := first_model
			update_gui
		end

	get_controller: SUDOKU_CONTROLLER
			-- Return reference to this object
		do
			Result := the_instance
		end

	set_multiplayer_controller_view(view : MULTIPLAYER_WINDOW)
	require
		valid_view: view /= Void
	do
		multiplayer_controller.set_multiplayer_window(view)
	end

feature -- Status report

	is_window_linked: BOOLEAN
			-- Is window linked  with this controller
		do
			Result := (gui /= Void)
		end

feature {NONE} -- Implementation

	the_instance: SUDOKU_CONTROLLER

	multiplayer_controller : SUDOKU_MULTIPLAYER_CONTROLLER

	gui: ABSTRACT_MAIN_WINDOW

	updating_gui:BOOLEAN
	you_lose : BOOLEAN
	you_win : BOOLEAN

feature {ANY} -- readable parameters

	model: SINGLE_PLAYER_STATE

	multiplayer_model: MULTIPLAYER_STATE

	current_level : STRING

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
        if model.board.cell_is_settable(row,col) then --if cell is settable, so change model value.
 			Result:=model.board.set_cell(row, col, value)
        else
        	if value/= model.board.cell_value (row, col) then --If cell isn't settable and new value =/ model value, can't modifique model value, because value was create for random.
        		update_gui_cell(row, col, model.board.cell_value(row, col))
        	end
        	Result:=True
		end
		-- After setting a cell ask if board is solved if so... tell user he WON
		if model.board.is_solved then
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
		not_receiving : BOOLEAN
		lose: ABOUT_LOSE
		win: ABOUT_WIN
	do
		if (not you_win and not you_lose) then
			-- check if I'm playing multiplayer and I had received a message
			if multiplayer_model.is_connected and multiplayer_model.receive_something then
				from
				until not_receiving
				loop
					if multiplayer_model.is_server_game then
						if attached{TUPLE[INTEGER,INTEGER]} multiplayer_model.my_server.socket.retrieved as l_msg then
							multiplayer_controller.paint_cell(l_msg.integer_32_item(1), l_msg.integer_32_item(2))
						end
						-- Si llego un integer quiere decir que gano el otro, o que se retiro. FALTA VERIFICAR ESTO!!
						if attached{INTEGER} multiplayer_model.my_server.socket.retrieved as l_msg then 
							you_lose := True
						end
					end
					if multiplayer_model.is_client_game then
						if attached{TUPLE[INTEGER,INTEGER]} multiplayer_model.my_client.socket.retrieved as l_msg then
							multiplayer_controller.paint_cell(l_msg.integer_32_item(1), l_msg.integer_32_item(2))
						end
						-- Si llego un integer quiere decir que gano el otro, o que se retiro. FALTA VERIFICAR ESTO!!
						if attached{INTEGER} multiplayer_model.my_client.socket.retrieved as l_msg then
							you_lose := True
						end
					end
					not_receiving := not multiplayer_model.receive_something
				end
			end
	
			-- we are informing to set_cell if we are updating or not the gui
			-- if not it means we have to set the cells from the model
			if not updating_gui then
				update_timer
		        if model.board.cell_is_settable(row,col) then --if cell is settable, so change model value.
		 			insertion_correct := model.board.set_cell(row, col, value)
		 			if(multiplayer_model.is_connected and insertion_correct) then
						multiplayer_model.report_play(row,col)
					end
		        else
		        	if value /= model.board.cell_value (row, col) then --If cell isn't settable and new value =/ model value, can't modifique model value, because value was create for random.
		        		update_gui_cell(row, col, model.board.cell_value(row, col))
		        		gui.set_cell_background_initial_colour (row, col)
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
				if model.board.is_solved then
					if multiplayer_model.is_connected then 
						if not you_lose then
							you_win := True
							multiplayer_model.report_victory
							create win.default_create
							win.show
							gui.set_non_editable_board
						end
					else
						winning_procedure
					end
				end
				if you_lose then
					create lose.default_create
					lose.show
					gui.set_non_editable_board
				end
			end
		end -- end if --
	end


	-- Unsets the cell in the model at the (row,col) position.
	unset_cell (row,col : INTEGER) --VER se recursiona el update de gui
	require
        unset_cell_row: row>=0 and row<=9
        unset_cell_col: col>=0 and col<=9
	do
		-- we are informing to set_cell if we are updating or not the gui
		-- if not it means we have to unset the cells from the model
		if not  updating_gui  then
			--if cell is not set then we can't do anything
			if model.board.cell_value (row, col) /= 0 and model.board.cell_is_settable (row, col)  then -- if cell is settable, I can erase its value.
				model.board.unset_cell (row, col)
				check_red_cells
			else
				if model.board.cell_value(row,col)/=0 then -- if cell isn't settable and default value /=0 should't modifique cell and you should update GUI
					update_gui_cell(row, col, model.board.cell_value(row, col))
				end
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
					-- model.board.cell_value returns the element in the board at the specified position
					update_gui_cell(row, col, model.board.cell_value(row, col))
					col := col + 1
				end
				row := row + 1
			end
			updating_gui := false
			--now that the gui is update we can check if the model is solved
			if model.board.is_solved then
				gui.request_about_winning_congrats
			end
		end

	-- Updates at the GUI only the cell of coords (row, column) of the board with the value "value".
	update_gui_cell(row, column, value: INTEGER)
		require
			update_gui_cell_row: row >= 0 and row <= 9
			update_gui_cell_column: column >= 0 and column <= 9
			update_gui_cell_value: value >= 0 and value <= 9
		do
			gui.set_value_of_cell(row, column, value, model.board.cell_is_settable(row,column))
			if is_already_present(row,column) then
				gui.set_cell_background_color_red(row,column)
			end
		end


	set_current_level(new_level : STRING)
		--sets the current_level
	require
		is_a_valid_level_name : new_level.is_equal ("easy") or new_level.is_equal ("medium") or new_level.is_equal ("hard")
	do
		current_level.copy (new_level)
	end

feature{ANY}

	reset_game(level:INTEGER)
		--local
			--new_model:SINGLE_PLAYER_STATE
		do
			create model.make_level(level)
			-- need to reset the list of red cells
			nbr_red_cells := 0
			update_gui
			model.make_timer
			update_timer
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
			if model.board.is_insertion_correct (coords.x,coords.y) or model.board.cell_value (coords.x,coords.y)=0 then -- position in board that contain a available value or haven't value should't be paint red
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
		create solver.init_with_board (model.board)
		solver.solve_board
		update_gui
	end

	update_timer
	do
		model.timer.update_time_duration
		gui.set_clock_second(model.timer.time_duration)
		gui.set_clock_minute(model.timer.time_duration)
		gui.set_clock_hour(model.timer.time_duration)
	end

	get_hint
	local
		hint:SUDOKU_HINT
	do
		if (model.get_hint_number > 0) then
			hint:=model.get_hint
			set_cell_v2(hint.get_x, hint.get_y, hint.get_v) --set model value
			gui.set_value_of_cell(hint.get_x, hint.get_y, hint.get_v,false)-- set gui value
			model.hint_not_settable(hint.get_x,hint.get_y)
			if model.get_hint_number=0 then
				gui.disable_get_hint
			end
		end
	end


feature -- winning_procedure

	winning_procedure
		--Check if the current player is making the top five and add him to the top_five of the current_level
	local
		top_five : TOP_FIVE
		current_player : PLAYER_TOP_FIVE
		player_is_good : BOOLEAN
		window_top_five : ABOUT_PLAYER_TOP_FIVE
	do
		--we create a player with its score
		create current_player.make
		model.timer.update_time_duration
		current_player.set_score (current_player.calculate_score (model.timer.time_duration))

		--if there is a top_five for the current level we load it, else we create it
		create top_five.init
		if (not top_five.retrieve (current_level)) then
			top_five.save (current_level)
		end

		-- we check if the player
		--is making it into the top_five
		player_is_good := top_five.is_player_making_top_five (current_player.score)
		if player_is_good then
			--we ask the player its name
			create window_top_five.default_create

			--we add the player to the top five and save the top_file thanks to the window
			window_top_five.add_action_add_player_to_top_five(current_player,top_five,current_level)
			window_top_five.show
		else
			-- gui.request_about_winning_congrats
			gui.request_about_winning_congrats
		end
	end

feature {ANY}

	-- the server start a new game with the respective difficulty
	server_connect(difficulty: INTEGER)
	do
		create multiplayer_model.make("SERVER")
		multiplayer_model.init_server_game(difficulty)
		create model.make(multiplayer_model.my_server.ai)
		multiplayer_controller.load_board(model.board)
		update_gui
		nbr_red_cells := 0
		model.make_timer
		update_timer
	end

	-- the client connects to the respective ip_adress
	client_connect(ip_address: STRING)
	do
		create multiplayer_model.make ("CLIENT")
		multiplayer_model.set_ip_address (ip_address)
		multiplayer_model.init_client_game
		create model.make (multiplayer_model.my_client.receive_ai)
		multiplayer_controller.load_board(model.board)
		update_gui
		nbr_red_cells := 0
		model.make_timer
		update_timer
	end

	-- the board isn't settable anymore because a player won the game
	non_settable_board
	local
		i, j : INTEGER
	do
		from
			i := 1
		until i > 9
		loop
			from
				j := 1
			until j > 9
			loop
				gui.set_value_of_cell(i, j, model.board.cell_value(i,j), false)
				j := j + 1	
			end
			i := i + 1
		end
	end

feature{ANY}
	--Feature that returns a hint number available
	how_many_hint:INTEGER
	do
		Result:= model.get_hint_number
	end
	
end
