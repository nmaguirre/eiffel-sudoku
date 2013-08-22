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
		require
			true
		do

		ensure
			board_created: cells /= void and not is_complete and is_valid and not is_solved
			board_size: cells.count=81
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

	--Description: This rutine inserts value "value" passed as parameter into a cell at row "row" and column "col"
	--Require: The require should be cell = Void
	--Ensure: The ensure should be cell /= Void and value dont exist in row and column
	set_cell (row: INTEGER; col: INTEGER; value: INTEGER)
    require
        set_cell_row: row>=1 and row<=9
        set_cell_col: col>=1 and col<=9
        set_cell_value: value>=1 and value<=9
	do
<<<<<<< HEAD

=======
		cells.item(row,col).set_value (value)
    ensure
        cell_value(row, col) = value
>>>>>>> 0456584b79bf29b8652b3e5694c47edacbcdea49
	end

	unset_cell (row: INTEGER; col: INTEGER)
	do

	end

feature {NONE} -- Implementation

	cells: ARRAY2[SUDOKU_CELL]


end
