note
	description: " Open a save game {ABOUT_LOAD}."
	author: "Matias Donatti & Gabriel Mabille"
	date: "24/09/13"
	revision: "None"

class
	ABOUT_LOAD

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

create default_create

feature {NONE}

	initialize
		local
			main_container : EV_VERTICAL_BOX
			combo_container : EV_FRAME
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


			--create combo container
			create combo_container.make_with_text ("File to load")
			--create the combo box with names of saved games
			create combo_game.make_with_text ("Empty")
			combo_game.disable_edit
			combo_container.extend (combo_game)

			--create a main container with on top combo_container at the bottom button_container
			create main_container
			main_container.extend (combo_container)
			main_container.extend (button_container)
			main_container.disable_item_expand (combo_container)
			main_container.disable_item_expand (button_container)


			--adding this main container to our window
			extend (main_container)

			--setting the window's title
			set_title (Default_title)

		end

feature {NONE}
	combo_game:EV_COMBO_BOX
		-- combo with save game

	ok_button: EV_BUTTON
		-- "OK" button.

	cancel_button: EV_BUTTON
		-- "cancel" button.

	Default_title: STRING = "Load Game"
		-- Default title for the dialog window.

	dialogb_height : INTEGER = 70
			--Current window's height
	dialogb_width : INTEGER = 370
			--Current window's width

	okb_height : INTEGER = 24
			--Ok_button's height	
	okb_width : INTEGER = 75
			--Ok_button's width

feature --access
	add_load_action_to_button_ok(load:SAVE_AND_LOAD; controller: SUDOKU_CONTROLLER)
		-- Add function load to button ok
		-- /!\ to be added straight after init! If not added
	do
		ok_button.select_actions.extend (agent load.load(combo_game.text))
		ok_button.select_actions.extend (agent controller.set_model (load.get_sudoku_board))
	end

feature{NONE} -- update combo
	update_combo ()
	-- update combo from directory with files save game..
		do
			--add files
		end

end
