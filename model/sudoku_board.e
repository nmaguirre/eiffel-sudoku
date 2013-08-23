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
	require
		(row > 0 and row < 10) and (col > 0 and col < 10)
	do
		Result := cells.item(row, col).value
	ensure
		Result >= 0 and Result < 10
	end

	is_complete: BOOLEAN
		-- is the board complete (all cells set)

	is_valid: BOOLEAN
		-- is the board valid (no conflicts so far)?

		-- is the board solved? (valid and complete)
	is_solved: BOOLEAN
    do
        Result:= is_valid and is_complete
    end

feature -- Status setting

	set_cell (row: INTEGER; col: INTEGER; value: INTEGER)
    require
        set_cell_row: row>=0 and row<=9
        set_cell_col: col>=0 and col<=9
        set_cell_value: value>=1 and value<=9
	do
		cells.item(row,col).set_value (value)
    ensure
        cell_value(row, col) = value
	end

	--Description: this routine unsets the value of the cell at row "row" and column "col"
	--Require: the value of the cell is diferent from Void and value<=9 and value>=1
	--Ensure: the value of the cell is Void
	unset_cell (row: INTEGER; col: INTEGER)
    require
        cell_value(row, col)>=1 and cell_value(row, col)<=9
	do
    ensure
        cell_value(row, col)=Void
	end

feature {NONE} -- Implementation

	cells: ARRAY2[SUDOKU_CELL]

end
