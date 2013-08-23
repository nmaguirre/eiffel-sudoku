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
    controller: SUDOKU_CONTROLLER

feature -- Access

    row : INTEGER
    	-- Value of row in a board

    col : INTEGER
    	-- Value of column in a board

feature {NONE}


feature -- Status Setting

    set (value: INTEGER)
        require
            value>=0 and value<=9
        do
            controller.set_cell(row, col, value)
        end

    unset
    	do
            controller.model.set_cell(row, col, 0)
    	end

feature -- Controller setting

    set_controller(cont: SUDOKU_CONTROLLER)
    do
        controller:= cont
    end
end
