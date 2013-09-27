note
	description: "Summary description for {ABOUT_SAVE}."
	author: "Gaston Cucatti"
	date: "$Date$"
	revision: "$Revision$"

class
	ABOUT_SAVE

inherit
	EV_DIALOG
	redefine
		initialize
	end

	INTERFACE_NAMES
		export {NONE} all
		undefine
			default_create, copy
		end

create
	default_create

feature {NONE} -- Initialize

initialize
--I add a button for close the windows, please delete it when you implemented this class. regards. Nando
		local
			main_container : EV_VERTICAL_BOX
			button_container : EV_HORIZONTAL_BOX
		do
			--create the window and set it's dimension
			Precursor
			set_size (dialogb_width,dialogb_height)

			--create button_close
			create ok_button.make_with_text_and_action ("Close",agent destroy)
			ok_button.set_minimum_size (okb_width, okb_height)

			create main_container.default_create
			main_container.extend (ok_button)
			--adding this main container to our window
			extend (main_container)

			--setting the window's title
			set_title (Default_title)

		end


feature {ANY}

	name_file_to_save : EV_TEXT_FIELD
	-- Allow user to choose name of saved board

	button_cancel : EV_BUTTON
	-- Button cancel

	button_ok : EV_BUTTON
	-- Button ok

	default_title : STRING = "ABOUT_SAVE"
	-- Window's title

feature{ANY} -- Action

	add_save_action_to_button_ok(save : SAVE_AND_LOAD)
		-- Add save action to button ok.
		--/!\ Need to be called after initialization of this class
	do
		button_ok.select_actions.extend (agent save.save(name_file_to_save.text))
	end

feature{ANY}
	default_name:STRING="Save"

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

end
