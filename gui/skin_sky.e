note
	description: "Summary description for {SKIN_SKY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SKIN_SKY

inherit
	ABSTRACT_MAIN_WINDOW
		redefine
			initialize,
			is_in_default_state
		end

create
	default_create

feature {NONE} -- Initialization


	initialize
			-- Build the interface for this window.
		local
			text:EV_TEXT
		do
			Precursor {ABSTRACT_MAIN_WINDOW}

				-- Create and add the menu bar.
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)

			build_main_container_default
			extend (main_container)

			--creo contenedor reloj
			create text.make_with_text ("Time")
			text.set_minimum_size (2,4)
			text.disable_edit
			main_container.extend (text)
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

	is_in_default_state: BOOLEAN
			-- Is the window in its default state
			-- (as stated in `initialize')
		do
			Result := (width = Window_width) and then
					(height = Window_height) and then
					(title.is_equal (Window_title))
		end

	request_about_quit
		local
			about_window: ABOUT_QUIT
		do
			create about_window
			about_window.add_close_action(Current)
			about_window.show
		end
feature --access



	--Description : allows user to paint one cell of the GUI in red
	set_cell_background_color_red(row,col : INTEGER)
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
		current_cell.paint_sky
	end

	set_cell_background_initial_colour(row,col : INTEGER)
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
	    current_cell.paint_initial_sky
	end

	--Description : allows user to paint one cell of the GUI in red
	set_cell_background_color_default(row,col : INTEGER)
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
		current_cell.paint_red
	end

end
