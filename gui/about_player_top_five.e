note
	description: "{ABOUT_PLAYER_TOP_FIVE} window that should be raised when a player is making the top five."
	author: "Gabriel Mabille"
	date: "1/10/2013"
	revision: ""

class
	ABOUT_PLAYER_TOP_FIVE

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
		local
			main_container : EV_VERTICAL_BOX
			congrats_text : EV_LABEL
			button_container : EV_HORIZONTAL_BOX
			text_field_container : EV_FRAME
		do
			-- Create the window and set it's dimension
			Precursor
			set_size (dialogb_width,dialogb_height)

			-- Create button_close
			create button_ok.make_with_text_and_action ("Save",agent destroy)
			button_ok.set_minimum_size (okb_width, okb_height)

			-- Create button_cancel
			create button_cancel.make_with_text_and_action ("Cancel",agent destroy)
			button_cancel.set_minimum_size (okb_width, okb_height)

			-- Create text label
			create congrats_text.make_with_text ("Congrats you made it in top_five");
			congrats_text.set_minimum_height (okb_height)

			-- Create text_field
			create text_field_container.make_with_text ("Welcome to top five :")
			create player_name_field.make_with_text ("Enter your name...")
			text_field_container.extend (player_name_field)

			-- Create button_container
			create button_container
			button_container.extend (button_cancel)
			button_container.extend (create {EV_CELL})
			button_container.extend (button_ok)
			button_container.disable_item_expand (button_cancel)
			button_container.disable_item_expand (button_ok)

			-- Create a main container containing everything
			create main_container.default_create
			main_container.extend (congrats_text)
			main_container.extend (text_field_container)
			main_container.extend (button_container)
			main_container.disable_item_expand (button_container)
			main_container.disable_item_expand (congrats_text)

			--adding this main container to our window
			extend (main_container)

			--setting the window's title
			set_title (Default_title)

		end


feature {NONE}


	dialogb_height : INTEGER = 95
			--Current window's height
	dialogb_width : INTEGER = 370
			--Current window's width

	player_name_field : EV_TEXT_FIELD
	-- Allow user to choose name of saved board

	button_cancel : EV_BUTTON
	-- Button cancel

	button_ok : EV_BUTTON
	-- Button ok

	okb_height : INTEGER = 24
			--Ok_button's height	

	okb_width : INTEGER = 75
			--Ok_button's width

	default_title : STRING = "PLAYER_TOP_FIVE"
	-- Window's title



feature{ANY} -- Action

	request_about_adding_player_to_top_five(player : PLAYER_TOP_FIVE; top_five : TOP_FIVE; level : STRING)
		--we assume the player is making it in top_five
	require
		player_can_be_in_top_five : top_five.is_player_making_top_five (player.score)
	do
		--first we set the player name
		player.set_name (player_name_field.text)

		--then we add this player to the top_five
		top_five.add_player_to_top_five (player.name,player.score)

		--finally we save the top_five
		top_five.save (level)
	end

	add_action_set_add_player_to_top_five(player : PLAYER_TOP_FIVE; top_five : TOP_FIVE; level : STRING)
		-- Call request_about_adding_player_to_top_five when button ok is pressed.
		--/!\ Need to be called after initialization of this class
	require
		player_can_be_in_top_five : top_five.is_player_making_top_five (player.score)
	do
		button_ok.select_actions.extend (agent request_about_adding_player_to_top_five(player,top_five,level))
	end

feature{ANY}
	default_name:STRING="Save"


end
