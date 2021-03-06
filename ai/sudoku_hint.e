note
	description	: "Summary description for {SUDOKU_HINT}."
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez, Diego Gastaldi"
	date		: "25/09/2013"
	revision	: "v0.2"

class
	SUDOKU_HINT

create
	make_hint,make

feature {NONE} -- Initialization

	pos_x: INTEGER
	pos_y: INTEGER
	value: INTEGER

	make_hint(x,y,v:INTEGER)
		do
			pos_x:=x
			pos_y:=y
			value:=v
		end

	make
		do

		end

feature -- Access

	get_x():INTEGER
	do
		Result := pos_x
	end

	get_y():INTEGER
	do
		Result := pos_y
	end

	get_v():INTEGER
	do
		Result:=value
	end

invariant
	coord_x: pos_x>=0 and pos_x<10
	coord_y: pos_y>=0 and pos_y<10
	value: value>=0 and value<10

end
