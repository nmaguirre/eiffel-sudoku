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
	do
		Precursor
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

end
