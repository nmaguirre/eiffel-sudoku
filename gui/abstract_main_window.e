note
	description: "Summary description for {ABSTRACT_MAIN_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_MAIN_WINDOW


inherit
	EV_TITLED_WINDOW
		export
			{ANY} all
		redefine
			is_in_default_state, initialize
		end

	INTERFACE_NAMES
		export
			{ANY} all
		undefine
			default_create, copy
		end


feature{ANY}
--Menu components
	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.

	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)

	help_menu: EV_MENU
			-- "Help" menu for this window (contains About...)

	main_container : EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)
	clock_container : EV_VERTICAL_BOX

	l_table : EV_TABLE

	clock_table :EV_TABLE

	current_menu_bar : EV_MENU_BAR

	menu_solve_item : EV_MENU_ITEM
		-- help to locate the menu Solve


	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window
	frame_item:EV_FRAME --add a frame separator for time under de grid


feature {ANY} -- Size Constants

	Window_title: STRING = "Eiffel Sudoku"
			-- Title of the window.

	Window_width: INTEGER = 280
			-- Initial width for this window.

	Window_height: INTEGER = 320
			-- Initial height for this window.

	mine_icon: EV_PIXMAP

feature{ANY} --controller of windows

	controller: SUDOKU_CONTROLLER

feature{ANY}--INITIALIZE WINDOW

feature --access

	--Description : allows user to set one cell value
	set_value_of_cell(row,col,value : INTEGER; is_settable : BOOLEAN)
	require

			col >= 1 and col <= 9
			row >= 1 and row <= 9
			value >= 0 and value <= 9
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
		current_cell.enable_sensitive --NANDO
		if value = 0 then
			current_cell.enable_edit
			current_cell.set_text ("")
		else
			current_cell.set_text (value.out)
			if not is_settable then
				current_cell.disable_edit
			    set_cell_background_initial_colour(row,col)
			end
		end
	end

feature {ANY} -- Menu Implementation
	is_in_default_state: BOOLEAN
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
					--(height = Window_height) and then
					(title.is_equal (Window_title))
		end

	build_frame
	do
		create frame_item.make_with_text ("Time")
		frame_item.align_text_center
		main_container.extend (frame_item)
		set_frame_background_color(frame_item)
	end

	build_standard_menu_bar
			-- Create and populate `standard_menu_bar'.
		require
		  menu_bar_not_yet_created: standard_menu_bar = Void
		do
			-- Create the menu bar.
			create standard_menu_bar
			-- Add the "File" menu
			build_file_menu
			standard_menu_bar.extend (file_menu)


				-- Add the "Help" menu
			build_help_menu
			standard_menu_bar.extend (help_menu)
		ensure
			menu_bar_created:
				standard_menu_bar /= Void and then
				not standard_menu_bar.is_empty
		end


	build_file_menu
			-- Create and populate `file_menu'.
		require
			file_menu_not_yet_created: file_menu = Void
		local
			menu_item : EV_MENU_ITEM
			separator_item : EV_MENU_SEPARATOR
		do
			create file_menu.make_with_text (Menu_file_item)

			create menu_item.make_with_text (Menu_file_new_item)
			menu_item.select_actions.extend (agent request_about_new) --controller for click in new
 			file_menu.extend (menu_item)    	-- New

			create separator_item.default_create
			file_menu.extend (separator_item) 	-- Separator

            create menu_item.make_with_text (Menu_file_save_item)
            menu_item.select_actions.extend (agent request_about_save) --controller for click in Multiplayer
			file_menu.extend (menu_item)     	-- Save

			create separator_item.default_create
			file_menu.extend (separator_item) 	-- Separator

			create menu_item.make_with_text (Menu_file_open_item)
			menu_item.select_actions.extend (agent request_about_load) --controller for click in Multiplayer
			file_menu.extend (menu_item)       	-- Save As

			create separator_item.default_create
			file_menu.extend (separator_item) 	-- Separator

			create menu_item.make_with_text (Menu_multiplayer_item)
			menu_item.select_actions.extend (agent request_about_multiplayer) --controller for click in Multiplayer
			file_menu.extend (menu_item)    	-- Multiplayer

			create separator_item.default_create
			file_menu.extend (separator_item)  	 -- Separator

			create menu_item.make_with_text (Menu_hint)
			menu_item.select_actions.extend (agent request_about_hint) --controller for click in Get Hint
			file_menu.extend (menu_item)         --hint

			create separator_item.default_create
			file_menu.extend (separator_item)  	 -- Separator

			create menu_item.make_with_text (Menu_top_scores)
			menu_item.select_actions.extend (agent request_about_top_scores) --controller for click in top scores
			file_menu.extend (menu_item) 	 -- Top Scores

			create separator_item.default_create
			file_menu.extend (separator_item)  	 -- Separator

			create menu_solve_item.make_with_text (Menu_file_solve_item)
			file_menu.extend (menu_solve_item) 	 -- Solve


			create separator_item.default_create
			file_menu.extend (separator_item)  	 -- Separator

			create menu_item.make_with_text (Menu_skins)
			menu_item.select_actions.extend (agent request_skin) --controller for click in top scores
			file_menu.extend (menu_item) 	 -- Top Scores


			create separator_item.default_create
			file_menu.extend (separator_item)  	 -- Separator

			-- Create the File/Exit menu item and make it call
			-- `request_about_quit' when it is selected.
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent request_about_quit)
			file_menu.extend (menu_item)

			disable_menu_item_game_not_initializated -- disable some invalid options in the game start
		ensure
			file_menu_created: file_menu /= Void and then not file_menu.is_empty
		end

	build_help_menu
			-- Create and populate `help_menu'.
		require
			help_menu_not_yet_created: help_menu = Void
		local
			menu_item: EV_MENU_ITEM
			about: ABOUT_DIALOG
			separator_item : EV_MENU_SEPARATOR
		do
			create help_menu.make_with_text (Menu_help_item)
                                                -- Help
            create menu_item.make_with_text (Menu_help_about_item)
			menu_item.select_actions.extend (agent request_about_dialog)
			help_menu.extend (menu_item)
		ensure
			help_menu_created: help_menu /= Void and then not help_menu.is_empty
		end

	add_solve_action_to_menu_item
	    --we need controller to be set before adding solve action therefore we should call it in set_controller
	local
		i : INTEGER
	do
		menu_solve_item.select_actions.extend (agent request_about_solve)
	end


	build_sudoku_table
		local
			current_text_field : CELL_TEXT_FIELD
			row,col: INTEGER
			font : EV_FONT

		do
			main_container.enable_sensitive -- the container is unlocked
			create font.default_create
			font.set_weight( (create {EV_FONT_CONSTANTS}).weight_bold)


			from
				row:= 1
			until
				row > 9
			loop
				from
					col := 1
				until
					col > 9
				loop
					create current_text_field.default_create
					current_text_field.add_control_caracter
					current_text_field.set_capacity (1)
					current_text_field.align_text_center
					current_text_field.set_minimum_width_in_characters (1)

					--At begin, the cell isn't setable
					current_text_field.disable_sensitive
					-- gives the current cell its position in the board
					current_text_field.set_position (row, col)

					l_table.put_at_position (current_text_field, col,row,1,1)
					paint_default_background(current_text_field)
					col := col +1
				end
				row := row +1
			end
		end


	build_main_container_default
			-- Create and populate `default_main_container'.
		do
			create l_table
			l_table.resize (9,9)
			l_table.set_border_width (3)
			create main_container
			build_sudoku_table
			main_container.extend (l_table)
		ensure
			main_container_created: main_container /= Void
		end


	build_clock_container
	local
		current_text_field : EV_TEXT_FIELD
		clock: INTEGER
		font : EV_FONT
		text: EV_TEXT
		do
			clock_container.disable_sensitive -- the container is unlocked
			create font.default_create
			font.set_weight( (create {EV_FONT_CONSTANTS}).weight_bold)
			from
				clock:= 1
			until
				clock > 3
			loop
				create current_text_field.default_create
				current_text_field.align_text_center
				--At begin, the cell isn't setable
				current_text_field.disable_edit
				-- gives the current cell its position in the board
				clock_table.put_at_position (current_text_field, clock, 1,1,1)
				clock := clock +1
			end
			current_text_field?= clock_table.at (1)
			current_text_field.set_text("00 ''")
			current_text_field?= clock_table.at (2)
			current_text_field.set_text("00'")
			current_text_field?= clock_table.at (3)
			current_text_field.set_text("00h")
	ensure
		clock_container_created: clock_container /= Void
	end

	build_clock
		-- Create and populate `clock'.
		do
			create clock_table.default_create
			clock_table.resize (3,3)
			clock_table.set_border_width (0)
			create clock_container
			build_clock_container
			clock_container.extend (clock_table)
		end


		initialize
			-- Build the interface for this window.
		local
			text:EV_TEXT
--			frame_item:EV_FRAME
		do
			Precursor {EV_TITLED_WINDOW}
				-- Create and add the menu bar.
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)

			build_main_container_default
			extend (main_container)

			build_frame
			build_clock
			main_container.extend (clock_container)

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_about_quit)

				-- Set the title of the window
			set_title (Window_title)

				-- Set the initial size of the window
			set_size (Window_width, Window_height)

			disable_user_resize
		end


feature {ANY} -- setters

	set_controller(ctller:SUDOKU_CONTROLLER)
	do
		controller:=ctller
		set_controller_for_each_cell
		-- once the controller is set we can now add the solve action to the menu
		add_solve_action_to_menu_item
	end

-- Set the controller in each cell
	set_controller_for_each_cell
	local
		current_cell : CELL_TEXT_FIELD
		row, col : INTEGER
	do
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
				current_cell ?= l_table.item_at_position (col, row)
				current_cell.set_controller (controller)
				col := col + 1
			end
			row := row + 1
		end
	end




feature{ANY}
--Features that drive the menu option availables

--Disable the follow options: save, save all, get hint and solve in file menu.
	disable_menu_item_game_not_initializated
	do
		file_menu.i_th(3).disable_sensitive -- Save
		file_menu.i_th(09).disable_sensitive -- Hint
		file_menu.i_th(13).disable_sensitive -- Solve
		file_menu.i_th(15).disable_sensitive -- Skin
	end

--Enable the follow options: save, save all, get hint and solve in file menu.
	enable_menu_item_game_initializated
	do
		file_menu.i_th(3).enable_sensitive -- Save
		file_menu.i_th(09).enable_sensitive -- Hint
		file_menu.i_th(13).enable_sensitive -- Solve
		file_menu.i_th(15).enable_sensitive -- Skin
	end

--Disable Get Hnt option in File Menu
	disable_get_hint
	do
		file_menu.i_th(09).disable_sensitive
	end


feature{ANY}
-- Feature for updte the clock

		set_clock_second(timer: TIME_DURATION)
		local
			text_field: EV_TEXT_FIELD
		do
			text_field?=clock_table.at(1)
			text_field.set_text(timer.second.out+"''")
		end

		set_clock_minute(timer:TIME_DURATION)
		local
			text_field: EV_TEXT_FIELD
		do
			text_field?=clock_table.at(2)
			text_field.set_text(timer.minute.out+"'")
		end

		set_clock_hour(timer: TIME_DURATION)
		local
			text_field: EV_TEXT_FIELD
		do
			text_field?=clock_table.at(3)
			text_field.set_text(timer.hour.out +"h")
		end


feature{ANY} -- Buttons controllers implementation

-- Implementation, Close event
	request_close_window
		do
				-- Destroy the window
			destroy;
				-- End the application
				--| TODO: Remove this line if you don't want the application
				--|       to end when the first window is closed..
			(create {EV_ENVIRONMENT}).application.destroy
		end

	request_about_load
		local
			load: ABOUT_LOAD
			save_load: SAVE_AND_LOAD
		do
			create load
			create save_load.init (controller.model)
			load.add_load_action_to_button_ok (save_load,controller)
			enable_menu_item_game_initializated
			load.show
		end

-- Implementation, Open Solve to ask if the player want to solve or not the sodoku
	request_about_solve
		local
			about_window: ABOUT_SOLVE
		do
			create about_window
			about_window.add_solve_action(controller)
			about_window.show
		end

-- Implementation, Open About
	request_about_dialog
		local
			about_window: ABOUT_DIALOG
		do
			create about_window
			about_window.show
		end

-- Implementation, Open About Win
	request_about_winning_congrats

	local
		about_window: ABOUT_WIN
		row,col:INTEGER
		current_cell:CELL_TEXT_FIELD
	do
		from
			row:=1
		until
			row=10
		loop
			from
				col:=1
			until
				col=10
			loop
				current_cell ?= l_table.item_at_position (col, row)
				paint_default_background(current_cell)
				current_cell.disable_edit
				col:=col+1
			end
			row:=row+1
		end

		create about_window
		about_window.show
		disable_menu_item_game_not_initializated
	end

	request_about_new
		local
			select_level:ABOUT_NEW

		do
			create select_level
			select_level.set_controller (controller)
			select_level.show
			enable_menu_item_game_initializated
		end

	request_about_top_scores
		local
			top: ABOUT_TOP_FIVE
			current_top_five : TOP_FIVE
		do
			create top
			create current_top_five.init
			if (current_top_five.retrieve (controller.current_level)) then
				top.update_array_visible (current_top_five)
			end
			top.show
		end

	request_about_hint
	local
	hint : ABOUT_HINT
	do
		create hint.make(controller)
		--hint.add_hint_action (controller)
		hint.show
	end

	request_about_multiplayer
		local
			multiplayer_window:MULTIPLAYER_WINDOW
			about_multiplayer:ABOUT_MULTIPLAYER

		do
			create multiplayer_window
			multiplayer_window.show
			create about_multiplayer
			about_multiplayer.set_controller (controller)
			about_multiplayer.set_multiplayer_window (multiplayer_window)
			about_multiplayer.show
		end

	request_about_save
	local
		load_window: ABOUT_SAVE
		save_load : SAVE_AND_LOAD
	do
		create load_window.default_create
		create save_load.init (controller.model)
		load_window.add_save_action_to_button_ok (save_load)
		load_window.show
	end

	-- Implementation, Open About Quit to ask if a user really want to quit the application
	request_about_quit
		local
			about_window: ABOUT_QUIT
		do
			create about_window
			about_window.add_close_action(Current)
			about_window.show
		end

--skin selection
	request_skin
		local
			select_skin:ABOUT_SKIN
		do
			create select_skin
			select_skin.set_controller(controller)
			current.destroy
			select_skin.show
   end

feature{ANY} --SKINS implements following features

	set_frame_background_color(frame:EV_FRAME)
	require
		frame_not_void: frame /= Void
	deferred
	end

	--Allow set cell background color considering 3*3 square
	paint_default_background(cell:CELL_TEXT_FIELD)
	require
		cell_not_void: cell /= void
		deferred
	end

		--Description : allows user to paint one cell of the GUI in red
	set_cell_background_color_red(row,col : INTEGER)
	require
		col >= 1 and col <= 9
		row >= 1 and row <= 9
	deferred
	end

	set_cell_background_initial_colour(row,col : INTEGER)
	require
		col >= 1 and col <= 9
		row >= 1 and row <= 9
	deferred
	end

	--Description : allows user to paint one cell of the GUI in red
	set_cell_background_color_default(row,col : INTEGER)
	require
		col >= 1 and col <= 9
		row >= 1 and row <= 9
	deferred
	end
end
