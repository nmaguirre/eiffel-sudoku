note
    description	: "Text field for a cell of the SUDOKU board"
    author		: ""
    date		: "Date"
    revision	: "Revision"

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
			set_v2(current.text.to_integer)
--			if not set(current.text.to_integer) then
--				paint_red
--			else
--				paint_default
--			end
		else
			if current.text.is_empty then
				print("No value entered. %N---> Need to unset cell %N")
				unset
			else
				print("Value entered : " + current.text + "%N" + "---> Reset %N")
				current.remove_text
				unset
			end
		end
	end


feature -- Status Setting
	paint_red
	local
		color: EV_COLOR
	do
		create color.make_with_rgb (1, 0, 0)
		current.set_background_color (color)
	end

	paint_default
		local
	a_color,b_color: EV_COLOR

		do
			create a_color.make_with_rgb(0.6,0.6,0.6)
			create b_color.make_with_rgb (0.9,0.9,0.9)
			if ((((row+2)//3)+((col+2)//3))\\2)= 0  then
				current.set_background_color (b_color)
			else
				current.set_background_color (a_color)
			end

		end

--    set (value: INTEGER):BOOLEAN
--        require
--            value>=0 and value<=9
--        do
--            Result:=controller.set_cell(row, col, value)
--        end

    set_v2 (value: INTEGER)
    require
        value>=0 and value<=9
    do
        controller.set_cell_v2(row, col, value)
    end


    unset
    do
    	controller.unset_cell(row,col)
    	paint_default
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
