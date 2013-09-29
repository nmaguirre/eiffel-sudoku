note
	description: "Summary description for {ABOUT_SKIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ABOUT_SKIN
inherit
	EV_DIALOG
		redefine
			initialize
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
			-- Populate the dialog box.
		local
			main_horizontal_box: EV_HORIZONTAL_BOX

			right_vertical_box: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			ev_cell: EV_CELL
		do
			Precursor




			create message_label
			message_label.align_text_left

			create skin_1_button.make_with_text ("Skin_1")
			skin_1_button.set_minimum_size (75, 75)
			--skin_1_button.select_actions.extend (agent skin)


			create skin_2_button.make_with_text ("Skin_2")
			skin_2_button.set_minimum_size (75, 75)
			--skin_2_button.select_actions.extend (agent skin)

			create skin_3_button.make_with_text ("Skin_3")
			skin_3_button.set_minimum_size (75, 75)
			--skin_3_button.select_actions.extend (agent skin)



			create buttons_box
			buttons_box.extend (create {EV_CELL}) -- Fill in empty space on left
			buttons_box.extend (skin_1_button)
			buttons_box.disable_item_expand (skin_1_button)
			buttons_box.extend (skin_2_button)
			buttons_box.disable_item_expand (skin_2_button)
			buttons_box.extend (skin_3_button)
			buttons_box.disable_item_expand (skin_3_button)

			create right_vertical_box
			right_vertical_box.set_padding (7)
			right_vertical_box.extend (buttons_box)
			right_vertical_box.disable_item_expand (buttons_box)

			create main_horizontal_box
			main_horizontal_box.set_border_width (7)
			create ev_cell
			ev_cell.set_minimum_width (40)
			main_horizontal_box.extend (ev_cell)
			main_horizontal_box.disable_item_expand (ev_cell)
			main_horizontal_box.extend (right_vertical_box)
			extend (main_horizontal_box)

			set_default_push_button (skin_1_button)
			set_default_push_button (skin_2_button)
			set_default_push_button	(skin_3_button)

			set_title (Default_title)
			set_size (100, 100)
		end

feature
		set_controller(crt:SUDOKU_CONTROLLER)

		do
			if crt = void then
				print("asdasd")
			end

			controller:=crt
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

	skin_1_button: EV_BUTTON
			-- "skin_1" button.

	skin_2_button: EV_BUTTON
			--"skin_2" button


	skin_3_button: EV_BUTTON
			--"skin_3" button

feature {NONE}
	request_about_easy_level
	do
		controller.reset_game(37)
		current.destroy
	end

feature {NONE}
	request_about_medium_level
	do
		controller.reset_game(32)
		current.destroy
	end

feature {NONE}
	request_about_hard_level
	do
		controller.reset_game(30)
		current.destroy
	end



feature {NONE} -- Implementation / Constants

	Default_title: STRING = "Select skin"
			-- Default title for the dialog window.

	gui: MAIN_WINDOW

	controller:SUDOKU_CONTROLLER

end -- class ABOUT_SKIN

