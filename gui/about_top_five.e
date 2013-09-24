note
	description: "window showing the top five players {ABOUT_TOP_FIVE}."
	author: "Justine Compagnon & Gabriel Mabille"
	date: "24/09/2013"
	revision: "NONE"

class
	ABOUT_TOP_FIVE

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


feature {NONE} -- Initialization

	initialize
		do
			--create the window (dimension & button )

		end


feature -- Update window

	update_array_visible (top_five: TOP_FIVE)
	-- add player from top five to array visible
		do
			--add one player and his score in each line
		end


feature {NONE} -- Implementation

	array_visible: EV_MULTI_COLUMN_LIST
			-- Array visible containing the top five players


feature {NONE} -- Implementation / Constants

	Default_title: STRING = "TOP FIVE"
			-- Default title for the dialog window.




end
