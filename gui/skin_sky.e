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
			initialize
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

feature --access

	set_frame_background_color(frame:EV_FRAME)
	local
		frame_colour:EV_COLOR
	do
		create frame_colour.make_with_rgb (0.3, 0.9, 0.9)
		frame.set_background_color (frame_colour)
	end

	paint_default_background(cell:CELL_TEXT_FIELD)
	local
		a_color,b_color:EV_COLOR
	do
		create a_color.make_with_rgb(0.1, 0.6,0.6)
		create b_color.make_with_rgb (0.3, 0.9, 0.9)
		cell.set_paint_default(a_color,b_color)
	end

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
		paint_default_background(current_cell)
	end

end
