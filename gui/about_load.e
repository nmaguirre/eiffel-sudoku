note
	description: " Open a save game {ABOUT_LOAD}."
	author: "Matias Donatti"
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
	 do

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
