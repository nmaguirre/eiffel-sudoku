note
	description: "Summary description for {ABSTRACT_MAIN_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ABSTRACT_MAIN_WINDOW


inherit
	EV_TITLED_WINDOW
	INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy
		end



feature --access

	--Description : allows user to set one cell value
	set_value_of_cell(row,col,value : INTEGER)
	require

			col >= 1 and col <= 9
			row >= 1 and row <= 9
			value >= 0 and value <= 9
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
feature {NONE} -- Menu Implementation

	standard_menu_bar: EV_MENU_BAR
			-- Standard menu bar for this window.
	deferred
	end
	file_menu: EV_MENU
			-- "File" menu for this window (contains New, Open, Close, Exit...)
	deferred
	end

	help_menu: EV_MENU
			-- "Help" menu for this window (contains About...)
	deferred
	end
	build_standard_menu_bar
			-- Create and populate `standard_menu_bar'.
		require
		  menu_bar_not_yet_created: standard_menu_bar = Void
		deferred

		ensure
			menu_bar_created:
				standard_menu_bar /= Void and then
				not standard_menu_bar.is_empty
		end

	menu_solve_item : EV_MENU_ITEM
		-- help to locate the menu Solve
	deferred
	end

	build_file_menu
			-- Create and populate `file_menu'.
		require
			file_menu_not_yet_created: file_menu = Void
		deferred
		ensure
			file_menu_created: file_menu /= Void and then not file_menu.is_empty
		end

	build_help_menu
			-- Create and populate `help_menu'.
		require
			help_menu_not_yet_created: help_menu = Void
		deferred
		ensure
			help_menu_created: help_menu /= Void and then not help_menu.is_empty
		end


feature {NONE} -- ToolBar Implementation

feature {NONE} -- StatusBar Implementation

	standard_status_bar: EV_STATUS_BAR
			-- Standard status bar for this window
	deferred
	end

feature -- Implementation, Close event

	request_close_window
	deferred
	end


feature -- Implementation, Open About Quit to ask if a user really want to quit the application

	request_about_quit
	deferred
	end

feature -- Implementation, Open Solve to ask if the player want to solve or not the sodoku

	request_about_solve
	deferred
	end

	add_solve_action_to_menu_item
	    --we need controller to be set before adding solve action therefore we should call it in set_controller
	deferred
	end

feature -- Implementation, Open About

	request_about_dialog
	deferred
	end

feature -- Implementation, Open About Win

	request_about_winning_congrats
	deferred
	end



feature {NONE} -- Implementation

	main_container : EV_VERTICAL_BOX
			-- Main container (contains all widgets displayed in this window)
	clock_container : EV_VERTICAL_BOX

	l_table : EV_TABLE
	clock_table :EV_TABLE

	build_sudoku_table
	deferred
	end

	build_main_container_default
			-- Create and populate `default_main_container'.
		deferred
		ensure
			main_container_created: main_container /= Void
		end

	build_clock_container
	deferred
	ensure
		clock_container_created: clock_container /= Void
	end


	build_clock
	deferred
	end



feature {ANY}
	request_about_new
	deferred
	end

feature {ANY} -- setters
	set_controller(ctller:SUDOKU_CONTROLLER)
	require
		ctller /= Void
	deferred
	end

feature {NONE} -- setter private

	-- Set the controller in each cell
	set_controller_for_each_cell
	require
		controller /= Void
	deferred
	end

feature{NONE}
	request_about_top_scores
	deferred
	end

feature {NONE} -- Implementation / Constants

	Window_title: STRING = "Eiffel Sudoku"
			-- Title of the window.

	Window_width: INTEGER = 280
			-- Initial width for this window.

	Window_height: INTEGER = 300
			-- Initial height for this window.

	mine_icon: EV_PIXMAP


	controller: SUDOKU_CONTROLLER


	current_menu_bar : EV_MENU_BAR

feature {NONE}

	request_about_hint
	deferred
	end

feature {NONE}
	request_about_multiplayer
	deferred
	end

	request_about_save
	deferred
	end

	request_about_save_as
	deferred
	end


feature{ANY}
--Disable the follow options: save, save all, get hint and solve in file menu.
	disable_menu_item_game_not_initializated
	deferred
	end
--Enable the follow options: save, save all, get hint and solve in file menu.
	enable_menu_item_game_initializated
	deferred
	end



end
