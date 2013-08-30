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

feature --init

	--Should be called straight after cell's init because it add the character control function in each cell
	add_control_caracter
	do
		current.change_actions.extend (agent control_text)
	end

	control_text
	do
		if current.text.is_integer and (current.text.to_integer>0) and (current.text.to_integer<10) then
			print("Value entered : " + current.text.to_integer.out + "%N ---> OK %N")
			-- set(current.text.to_integer)
		else
			if current.text.is_empty then
				print("No value entered. %N---> Need to unset cell %N")
				-- unset
			else
				print("Value entered : " + current.text + "%N" + "---> Reset %N")
				current.remove_text
				-- unset
			end
		end
	end

feature -- Status Setting

    set (value: INTEGER)
        require
            value>=0 and value<=9
        do
            controller.set_cell(row, col, value)
        end

    unset
    	do
    		current.set_text (" ");
            controller.set_cell(row, col, 0)
    	end

feature -- Controller setting

    set_controller(cont: SUDOKU_CONTROLLER)
    do
        controller:= cont
    end

feature -- Position Setting

	set_position(newrow, newcol : INTEGER)
	require
		newrow > 0 and newrow <= 9
		newcol > 0 and newcol <= 9
	do
		row := newrow
		col := newcol
	end

end
