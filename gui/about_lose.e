note
	description	: "Dialog box which shows up in losing case"
	author		: ""
	date		: ""
	revision	: ""

class
	ABOUT_LOSE

inherit
	ABOUT_DIALOG
	redefine
		initialize
	end

create
	default_create

feature {NONE} -- initialize

	initialize
	do
		Precursor
		Current.set_message("Oops, sorry, you lose!")
		Current.set_title ("Defeated!")
	end

end
