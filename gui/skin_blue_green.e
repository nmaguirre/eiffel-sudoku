note
	description: "Summary description for {SKIN_BLUE_GREEN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SKIN_BLUE_GREEN

inherit
	ABSTRACT_MAIN_WINDOW


create
	default_create

feature {NONE} -- Initialization



feature --access

	set_frame_background_color(frame:EV_FRAME)
	local
		frame_colour:EV_COLOR
	do
		create frame_colour.make_with_rgb(0.5,0.9,0.5)
		frame.set_background_color (frame_colour)
	end

	paint_default_background(cell:CELL_TEXT_FIELD)
	local
		a_color,b_color:EV_COLOR
	do
		create a_color.make_with_rgb(0.5, 0.6, 0.7)
		create b_color.make_with_rgb (0.8, 0.9, 0.9)
		cell.set_paint_default(a_color,b_color)
	end

	--Description : allows user to paint one cell of the GUI in red
	set_cell_background_color_red(row,col : INTEGER)
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
		current_cell.paint_red
	end

	set_cell_background_initial_colour(row,col : INTEGER)
	local
		current_cell : CELL_TEXT_FIELD
	do
		current_cell ?= l_table.item_at_position (col, row)
	    current_cell.paint_initial_blue_green
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
