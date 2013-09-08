note
	description	: "Dialog box which shows up in winning case"
	author		: "Gabriel Mabille."
	date		: "2013/9/08 19:47:23"
	revision	: "1.0.0"

class
	ABOUT_WIN

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
		Current.set_message("Congrats you won!")
		Current.set_title ("Congratulation")
	end

end
