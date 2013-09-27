note
	description: "Summary description for {MULTIPLAYER_WINDOW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLAYER_WINDOW

inherit
	EV_DIALOG
		redefine
			initialize
		end


create
	default_create

feature {NONE} -- Initialization


	initialize
			-- Populate the dialog box.
		local
			main_horizontal_box: EV_HORIZONTAL_BOX

			right_vertical_box: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			ev_cell: EV_CELL
		do
			Precursor


			build_main_container_default
			extend (main_container)


			set_size (120,120)


			set_title (Default_title)


		end


feature -- Element change

	set_message (a_message: STRING)
		do
			message_label.set_text (a_message)
		end

feature {NONE} -- Implementation

	message_label: EV_LABEL
			-- Label situated on the top of the dialog,
			-- contains the message.

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
			main_container.disable_sensitive -- the container is unlocked
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




feature {NONE} -- Implementation / Constants

	Default_title: STRING = "Player 2"
			-- Default title for the dialog window.

	gui: MAIN_WINDOW

	controller:SUDOKU_CONTROLLER

end -- class MULTIPLAYER_WINDOW

