note
	description	: "Main window for this application"
	author		: "Generated by the New Vision2 Application Wizard."
	date		: "16/09/2013"
	revision	: "1.0.0"

class
	MAIN_WINDOW

inherit
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
		end

	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialization


	initialize
			-- Build the interface for this window.
		do
			Precursor {EV_TITLED_WINDOW}

				-- Create and add the menu bar.
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)

			build_main_container_default
			extend (main_container)

				-- Execute `request_close_window' when the user clicks
				-- on the cross in the title bar.
			close_request_actions.extend (agent request_about_quit)

				-- Set the title of the window
			set_title (Window_title)

				-- Set the initial size of the window
			set_size (Window_width, Window_height)

			disable_user_resize

		end

	is_in_default_state: BOOLEAN
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
					(height = Window_height) and then
					(title.is_equal (Window_title))
		end

feature --access

	--Description : allows user to set one cell value
	set_value_of_cell(row,col,value : INTEGER)
		require
			col >= 1 and col <= 9
			row >= 1 and row <= 9
			value >= 0 and value <= 9
		local
			current_cell : CELL_TEXT_FIELD
		do
			current_cell ?= l_table.item_at_position (col, row)
			current_cell.enable_edit --NANDO
			if value = 0 then
				current_cell.set_text ("")
			else
				current_cell.paint_initial
				current_cell.set_text (value.out)
				current_cell.disable_edit
			end
		end



	--Description : allows user to paint one cell of the GUI in red
	set_cell_background_color_red(row,col : INTEGER)
	require
		col >= 1 and col <= 9
		row >= 1 and row <= 9
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
		current_cell.paint_red
	end

	set_cell_background_initial_colour(row,col : INTEGER)
	require
		col >= 1 and col <= 9
		row >= 1 and row <= 9
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
	    current_cell.paint_initial
	end

	--Description : allows user to paint one cell of the GUI in red
	set_cell_background_color_default(row,col : INTEGER)
	require
		col >= 1 and col <= 9
		row >= 1 and row <= 9
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
		current_cell.paint_default
	end

feature {NONE} -- Menu Implementation

	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.

	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)

	help_menu: EV_MENU
			-- "Help" menu for this window (contains About...)

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

	menu_solve_item : EV_MENU_ITEM
		-- help to locate the menu Solve

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

			create menu_item.make_with_text (Menu_file_saveas_item)
			menu_item.select_actions.extend (agent request_about_save_as) --controller for click in Multiplayer
			file_menu.extend (menu_item)       	-- Save As

			create separator_item.default_create
			file_menu.extend (separator_item) 	-- Separator

			create menu_item.make_with_text (Menu_file_open_item)
			file_menu.extend (menu_item)    	-- Open


			create separator_item.default_create
			file_menu.extend (separator_item) 	-- Separator

			create menu_item.make_with_text (Menu_multiplayer_item)
<<<<<<< HEAD
			menu_item.select_actions.extend (agent request_multiplayer)
=======
			menu_item.select_actions.extend (agent request_about_multiplayer) --controller for click in Multiplayer
>>>>>>> nando
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
            create menu_item.make_with_text (Menu_help_contents_item)
            help_menu.extend (menu_item)		 -- Contents and Index

            create separator_item.default_create
			help_menu.extend (separator_item)  	 -- Separator

			create menu_item.make_with_text (Menu_help_about_item)
			menu_item.select_actions.extend (agent request_about_dialog)
			help_menu.extend (menu_item)
		ensure
			help_menu_created: help_menu /= Void and then not help_menu.is_empty
		end


feature {NONE} -- ToolBar Implementation

feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window


feature -- Implementation, Close event

	request_close_window
		do
				-- Destroy the window
			destroy;
				-- End the application
				--| TODO: Remove this line if you don't want the application
				--|       to end when the first window is closed..
			(create {EV_ENVIRONMENT}).application.destroy
		end


feature -- Implementation, Open About Quit to ask if a user really want to quit the application

	request_about_quit
		local
			about_window: ABOUT_QUIT
		do
			create about_window
			about_window.add_close_action(Current)
			about_window.show
		end


feature -- Implementation, Open Solve to ask if the player want to solve or not the sodoku

	request_about_solve
		local
			about_window: ABOUT_SOLVE
		do
			create about_window
			about_window.add_solve_action(controller)
			about_window.show
		end


	add_solve_action_to_menu_item
	    --we need controller to be set before adding solve action therefore we should call it in set_controller
	local
		i : INTEGER
	do
		menu_solve_item.select_actions.extend (agent request_about_solve)
	end


feature -- Implementation, Open About

	request_about_dialog
		local
			about_window: ABOUT_DIALOG
		do
			create about_window
			about_window.show
		end

feature -- Implementation, Open About Win

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
				current_cell.paint_default
				current_cell.disable_edit
				col:=col+1
			end
			row:=row+1
		end

		create about_window
		about_window.show
		disable_menu_item_game_not_initializated
	end



feature {NONE} -- Implementation

	main_container : EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)

	l_table : EV_TABLE

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
					current_text_field.disable_edit
					-- gives the current cell its position in the board
					current_text_field.set_position (row, col)

					l_table.put_at_position (current_text_field, col,row,1,1)
					current_text_field.paint_default
					col := col +1
				end
				row := row +1
			end
		end


	build_main_container_default
			-- Create and populate `default_main_container'.
		require
			main_container_not_yet_created: main_container = Void
		do
			create l_table
			l_table.resize (9,9)
			l_table.set_border_width (0)
			create main_container
			build_sudoku_table
			main_container.extend (l_table)
		ensure
			main_container_created: main_container /= Void
		end

feature {ANY}
	request_about_new
		local
			select_level:ABOUT_NEW

		do
			create select_level
			select_level.set_controller (controller)
			select_level.show
			enable_menu_item_game_initializated
		end


feature {ANY} -- setters
		set_controller(ctller:SUDOKU_CONTROLLER)
	require
		ctller /= Void
	do
		controller:=ctller
		set_controller_for_each_cell
		-- once the controller is set we can now add the solve action to the menu
		add_solve_action_to_menu_item
	end

feature {NONE} -- setter private

	-- Set the controller in each cell
	set_controller_for_each_cell
	require
		controller /= Void
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

feature{NONE}
	request_about_top_scores
	do
		--print("Missing implementation of GUI/request_about_top_scores")
	end


feature {NONE} -- Implementation / Constants

	Window_title: STRING = "Eiffel Sudoku"
			-- Title of the window.

	Window_width: INTEGER = 280
			-- Initial width for this window.

	Window_height: INTEGER = 280
			-- Initial height for this window.

	mine_icon: EV_PIXMAP

	controller: SUDOKU_CONTROLLER

	current_menu_bar : EV_MENU_BAR

feature {NONE}
	request_about_hint
	local
	hint : ABOUT_HINT
	do
		--print("Should implementate request_about_hint in gui/MAIN_WINDOW")
		create hint
		hint.add_hint_action (controller)
		hint.show
	end

<<<<<<< HEAD
feature {NONE}
	request_multiplayer
		local
			multiplayer_window:MULTIPLAYER_WINDOW

		do
			create multiplayer_window
			multiplayer_window.show
		end
=======
	request_about_save
	do
		print("Should implementate request_about_save in gui/MAIN_WINDOW")
	end

	request_about_save_as
	do
		print("Should implementate request_about_save_as in gui/MAIN_WINDOW")
	end
>>>>>>> nando

	request_about_multiplayer
	do
		print("Should implementate request_about_multiplayer in gui/MAIN_WINDOW")
	end


feature{ANY}
--Disable the follow options: save, save all, get hint and solve in file menu.
	disable_menu_item_game_not_initializated
	do
		file_menu.i_th(3).disable_sensitive -- Save
		file_menu.i_th(4).disable_sensitive -- Save All
		file_menu.i_th(10).disable_sensitive -- Hint
		file_menu.i_th(14).disable_sensitive -- Solve

	end

--Enable the follow options: save, save all, get hint and solve in file menu.
	enable_menu_item_game_initializated
	do
		file_menu.i_th(3).enable_sensitive -- Save
		file_menu.i_th(4).enable_sensitive -- Save All
		file_menu.i_th(10).enable_sensitive -- Hint
		file_menu.i_th(14).enable_sensitive -- Solve
	end

end
