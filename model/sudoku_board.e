note
	description: "Summary description for {SUDOKU_BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_BOARD

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes the board as empty
		do

		end

	make_with_random_values
			-- Initializes the board as with some cells set with random numbers
		do

		end



feature -- Access

feature -- Measurement

feature -- Status report

	cell_value (row: INTEGER; col: INTEGER): INTEGER
		-- returns value of cell in row and col
	do
		
	end

	is_complete: BOOLEAN
		-- is the board complete (all cells set)

	is_valid: BOOLEAN
		-- is the board valid (no conflicts so far)?

	is_solved: BOOLEAN
		-- is the board solved? (valid and complete)

feature -- Status setting

	set_cell (row: INTEGER; col: INTEGER; value: INTEGER)
	do

	end

	unset_cell (row: INTEGER; col: INTEGER)
	do

	end

feature {NONE} -- Implementation

	cells: ARRAY2[SUDOKU_CELL]


end
