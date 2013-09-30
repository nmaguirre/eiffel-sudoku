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
			create ok_button.make_with_text_and_action ("Open",agent destroy)
			ok_button.set_minimum_size (okb_width, okb_height)

			-- Create button_cancel
			create button_cancel.make_with_text_and_action ("Cancel",agent destroy)
			button_cancel.set_minimum_size (okb_width, okb_height)

			--create button_container
			create button_container
			button_container.extend (create {EV_CELL})
			button_container.extend (button_cancel)
			button_container.extend (ok_button)
			button_container.disable_item_expand (button_cancel)
			button_container.disable_item_expand (ok_button)

			--create combo container
			create combo_container.make_with_text ("File to load")
			--create the combo box with names of saved games
			create combo_game.make_with_text ("Empty")
			combo_game.disable_edit
			combo_container.extend (combo_game)
			--updating combobox
			update_combo()

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

	button_cancel: EV_BUTTON
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
		ok_button.select_actions.extend (agent controller.set_model (load.get_single_player_state))
	end

feature{NONE} -- update combo
	update_combo ()
	-- update combo from directory with files save game..
		local
			save_dir : DIRECTORY
			save_path : STRING
			all_file_added : BOOLEAN
			file_found_is_system_shortcut : BOOLEAN
			current_list_item : EV_LIST_ITEM
		do
			-- Create directory
			save_path := "./save_load/games/"
			create save_dir.make (save_path)
			save_dir.open_read
			-- Now let's go through directory :
			from
				save_dir.start
			until
				all_file_added
			loop
				save_dir.readentry
				--if last_entry = void we read everything
				if save_dir.last_entry_32 = Void then
					all_file_added := true
					print("In update combo : no more files to be found %N")
				else
					file_found_is_system_shortcut := (save_dir.last_entry_32.is_equal (".") or save_dir.last_entry_32.is_equal (".."))
					if (not file_found_is_system_shortcut) then
						-- we created a new item to be added to the combo_game
						-- in this item we have to put the file_path
						print("In update combo : found file : " + save_dir.last_entry_32 + "%N")
						create current_list_item.make_with_text (save_dir.last_entry_32)
						combo_game.extend (current_list_item)
					end
				end
			end


		end

end
