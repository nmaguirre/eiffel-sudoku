note
	description: "window showing the top five players {ABOUT_TOP_FIVE}."
	author: "Justine Compagnon & Gabriel Mabille"
	date: "24/09/2013"
	revision: "NONE"

class
	ABOUT_TOP_FIVE

inherit

	EV_DIALOG
		redefine
			initialize
		end

feature {NONE} -- Initialization

	initialize
		local
			main_container : EV_VERTICAL_BOX
			score_container : EV_FRAME
			button_container : EV_HORIZONTAL_BOX
		do
			--create the window and set it's dimension
			Precursor
			set_size (dialogb_width,dialogb_height)

			--create button_ok
			create ok_button.make_with_text_and_action ("Close",agent destroy)
			ok_button.set_minimum_size (okb_width, okb_height)

			--create button_container
			create button_container
			button_container.extend (create {EV_CELL})
			button_container.extend (create {EV_CELL})
			button_container.extend (ok_button)
			button_container.disable_item_expand (ok_button)


			--create score container
			create score_container.make_with_text ("Top scores")
			--create score array and setting it's minimum size
			create array_visible
			array_visible.set_minimum_size (arrayv_width, arrayv_height)
			--adding score array to score_container
			score_container.extend (array_visible)


			--create a main container with on top score_container at the bottom button_container
			create main_container
			main_container.extend (score_container)
			main_container.extend (button_container)
			main_container.disable_item_expand (score_container)
			main_container.disable_item_expand (button_container)


			--adding this main container to our window
			extend (main_container)

			--setting the window's title
			set_title (Default_title)

		end


feature -- Update window

	update_array_visible (top_five: TOP_FIVE)
	-- add player from top five to array visible
		do
			--add one player and his score in each line
		end


feature {NONE} -- Implementation

	dialogb_height : INTEGER = 380
			--Current window's height
	dialogb_width : INTEGER = 370
			--Current window's width

	ok_button: EV_BUTTON
			-- "OK" button.

	okb_height : INTEGER = 24
			--Ok_button's height	
	okb_width : INTEGER = 75
			--Ok_button's width

	array_visible: EV_MULTI_COLUMN_LIST
			-- Array visible containing the top five players

	arrayv_height : INTEGER = 340
			--Array_visible's height	
	arrayv_width : INTEGER = 380
			--Array_visible's width	



feature {NONE} -- Implementation / Constants

	Default_title: STRING = "TOP FIVE"
			-- Default title for the dialog window.

end
