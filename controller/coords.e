note
	description: "Coords for a cell for example"
	author: "Gabriel Mabille"
	date: "10/09/13"
	revision: "None"

expanded class
	COORDS

create
	default_create,
	make_with_param

feature {SUDOKU_CONTROLLER} -- creators

	initialize
	do
		x := 0
		y := 0
	end

	make_with_param(new_x,new_y : INTEGER)
	do
		x := new_x
		y := new_y
	end

feature {SUDOKU_CONTROLLER} -- get and set

	x,y : INTEGER

	set_x(new_x : INTEGER)
	do
		x := new_x
	end

	set_y(new_y : INTEGER)
	do
		y := new_y
	end

end
