note
    description: "Text field for a cell of the SUDOKU board"
    author: ""
    date: "$Date$"
    revision: "$Revision$"

class
    CELL_TEXT_FIELD

inherit
    EV_TEXT_FIELD


feature {ANY} -- Initialization


feature -- Access

    row : INTEGER
    	-- Value of row in a board

    col : INTEGER
    	-- Value of column in a board

feature {NONE}


feature -- Status Setting

    set (value: INTEGER)
		do

		end


    unset
    	do

    	end




end
