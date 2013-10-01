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
    color:EV_COLOR

feature {NONE}

feature --init

	--Should be called straight after cell's init because it add the character control function in each cell
	add_control_caracter
	do
		current.change_actions.extend (agent control_text_v2)
	end

	control_text
	obsolete
		"use control_text_v2 instead"
	do
		if current.text.is_integer and (current.text.to_integer>0) and (current.text.to_integer<10) then
			print("Value entered : " + current.text.to_integer.out + "%N ---> OK %N")
			if not set(current.text.to_integer) then
				paint_red
			else
				--paint_default
			end
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

	control_text_v2
	do
		if current.text.is_integer and (current.text.to_integer>0) and (current.text.to_integer<10) then
			print("Value entered : " + current.text.to_integer.out + "%N ---> OK %N")
			set_v2(current.text.to_integer)
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
		c: EV_COLOR
	do
		create c.make_with_rgb (1, 0, 0)
		current.set_background_color (c)
	end

	paint_initial
	local
		c: EV_COLOR
	do
		create c.make_with_rgb (0.700, 0.700, 0.800)
		current.set_background_color (c)
	end


	paint_initial_desert
	local
		c: EV_COLOR
	do
		create c.make_with_rgb (0.6, 0.40, 0.300)
		current.set_background_color (c)
	end

	--SKIN Fede
	paint_initial_blue_green
	local
		c: EV_COLOR
	do
		create c.make_with_rgb (0.5, 0.9, 0.5)
		current.set_background_color (c)
	end
	--End SKIN Fede

	paint_initial_sky
	local
		c: EV_COLOR
	do
		create c.make_with_rgb (0.300, 0.300, 0.800)
		current.set_background_color (c)
	end

	set_paint_default(a_color,b_color:EV_COLOR)
		do
			if ((((row+2)//3)+((col+2)//3))\\2)= 0  then
				current.set_background_color (b_color)
				color:=b_color
			else
				current.set_background_color (a_color)
				color:=a_color
			end

		end

	paint_default
	local
		do
		if (color=Void) then
			create color.make_with_rgb (0.5,0.9,0.5)
		end
			current.set_background_color (color)
		end


	paint_sky
	local
	a_color,b_color: EV_COLOR

		do
			create a_color.make_with_rgb(0.5,0.5,0.9)
			create b_color.make_with_rgb (0.7,0.8,0.9)
			if ((((row+2)//3)+((col+2)//3))\\2)= 0  then
				current.set_background_color (b_color)
			else
				current.set_background_color (a_color)
			end
	end

	paint_desert
	local
	a_color,b_color: EV_COLOR

		do
			create a_color.make_with_rgb(0.75, 0.45, 0.100)
			create b_color.make_with_rgb (0.8, 0.80, 0.400)
			if ((((row+2)//3)+((col+2)//3))\\2)= 0  then
				current.set_background_color (b_color)
			else
				current.set_background_color (a_color)
			end
	end

	--SKIN Fede
	paint_default_blue_green
	local
	a_color,b_color: EV_COLOR

		do
			create a_color.make_with_rgb(0.5, 0.6, 0.7)
			create b_color.make_with_rgb (0.8, 0.9, 0.9)
			if ((((row+2)//3)+((col+2)//3))\\2)= 0  then
				current.set_background_color (b_color)
			else
				current.set_background_color (a_color)
			end

	end
	--End SKIN Fede


    set (value: INTEGER):BOOLEAN
    obsolete
    	"use set_v2 instead"
    require
        value>=0 and value<=9
    do
        Result:=controller.set_cell(row, col, value)
    end

    set_v2 (value: INTEGER)
    require
        value>=0 and value<=9
    do
        controller.set_cell_v2(row, col, value)
    end

	unset
	do
		controller.unset_cell (row, col)
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
