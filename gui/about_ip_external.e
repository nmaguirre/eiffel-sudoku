note
	description: "Implements a window that asks to the user the ip of an external server in multiplayer game."
	author: "Federico Franco"
	date: "$Date$"
	revision: "$Revision$"

class
	ABOUT_IP_EXTERNAL

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
			text_field_container : EV_FRAME
		do
			-- Create the window and set it's dimension
			Precursor
			set_size (dialogb_width,dialogb_height)

			-- Create button_close
			create button_ok.make_with_text_and_action ("Ok",agent press_button_ok)
			button_ok.set_minimum_size (okb_width, okb_height)

			-- Create button_cancel
			create button_cancel.make_with_text_and_action ("Cancel",agent destroy)
			button_cancel.set_minimum_size (okb_width, okb_height)


			-- Create text_field
			create text_field_container.make_with_text ("External server IP")
			create ip_external.make_with_text ("Put IP...")
			text_field_container.extend (ip_external)

			-- Create button_container
			create button_container
			button_container.extend (button_cancel)
			button_container.extend (create {EV_CELL})
			button_container.extend (button_ok)
			button_container.disable_item_expand (button_cancel)
			button_container.disable_item_expand (button_ok)

			-- Create a main container with on top combo_container at the bottom button_container
			create main_container.default_create
			main_container.extend (text_field_container)
			main_container.extend (button_container)
			main_container.disable_item_expand (button_container)

			--adding this main container to our window
			extend (main_container)

			--setting the window's title
			set_title (Default_title)

		end


feature {NONE}


	dialogb_height : INTEGER = 70
			--Current window's height
	dialogb_width : INTEGER = 370
			--Current window's width

	ip_external : EV_TEXT_FIELD
	-- Allow user to choose name of saved board

	button_cancel : EV_BUTTON
	-- Button cancel

	button_ok : EV_BUTTON
	-- Button ok

	okb_height : INTEGER = 24
			--Ok_button's height	

	okb_width : INTEGER = 75
			--Ok_button's width

	default_title : STRING = "External IP"
	-- Window's title

	controller:SUDOKU_CONTROLLER

feature{NONE} -- Action

	press_button_ok
	do
		controller.client_connect(ip_external.text)
		Current.destroy
	end



feature{ANY}
	default_name:STRING="External Server IP Insert"

	set_controller(cont: SUDOKU_CONTROLLER)
	do
		controller:= cont
	end
end
