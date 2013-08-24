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

	-- Return true iff the board is complete (all cells are seted with a nonzero value)
	is_complete: BOOLEAN
	local
		i, j : INTEGER -- indexes used to pass through the matrix of SUDOKU_CELL
		filled: BOOLEAN -- flag that indicates if the current cell is filled with a nonzero value
	do
		filled := true
		from -- index for the rows
			i := 1
		until
			i > 9 and filled
		loop
			from -- index for the colums
				j := 1
			until
				j > 9 and filled
			loop
				if cell_value(i,j) = 0 then
					filled := false
				end
				j := j + 1
			end -- colums
			i := i + 1
		end -- rows
		Result := filled
	end

        -- is the board valid (no conflicts so far)?
	is_valid: BOOLEAN
    local
        i, j: INTEGER
        repeated: BOOLEAN
    do
        --first check all rows and columns.
        j:= 1
        from
            i:= 1
        until
            i > 9 and not repeated
        loop
            if repeated_element_in_row(i) or repeated_element_in_col(i) then
                repeated:= true
            end
        end
        -- now check sub boards valids in the main board.
        from 
            i:=1
        until
            i > 9 and not repeated
        loop
            from
                j:=1
            until
                j > 9 and not repeated
            loop
                repeated:= repeated_elements_in_square(i,i)
                j:= j + 3
            end
            i:= i + 3
        end
        Result:= repeated
    end
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

    -- Return true iff there are not repeated elements in each row.
    repeated_element_in_row(row: INTEGER): BOOLEAN
    local
        i, j: INTEGER --Index for the columns.
        flag: BOOLEAN --False if repeating elements in row.
    do
        flag:= true
        from
            i := 1
        until
            i > 9 and flag
        loop
            if cell_value(row, i) /= 0 then
                from
                    j:= 1
                until
                    j > 9 and flag
                loop
                    if i /= j and cell_value(row, i) = cell_value(row, j) then
                        flag := false
                    end
                    j:= j + 1
                end
            end
            i:= i + 1
        end
        Result:= flag
    end

    -- Return true iff there are not repeated elements in each row.
    repeated_element_in_col(col: INTEGER): BOOLEAN
    local
        i, j: INTEGER -- Index for the rows
        flag: BOOLEAN --False if repeating elements in col.
    do
        flag:= true
        from
            i := 1
        until
            i > 9 and flag
        loop
            if cell_value(i, col) /= 0 then
                from
                    j:= 1
                until
                    j > 9 and flag
                loop
                    if i /= j and cell_value(i, col) = cell_value(j, col) then
                        flag := false
                    end
                    j:= j + 1
                end
            end
            i:= i + 1
        end
        Result:= flag
    end

    -- Return true iff there are not repeated elements in each row and in each col of square 3x3.
    repeated_elements_in_square(row, col: INTEGER): BOOLEAN
    local
        i, j, i_aux: INTEGER
        aux: ARRAY[INTEGER]
        flag: BOOLEAN
    do
        --Load sub_board in aux array.
        i_aux:= 1
        create aux.make (1, 9)
        from
            i:= row
        until
            i > row + 3
        loop
            from
                j:= col
            until
                j > col + 3
            loop
                aux[i_aux]:= cell_value(i, j)
                j:= j + 1
                i_aux:= i_aux + 1
            end
            i:= i + 1
        end
        --Verify repeated elements in aux array.
        flag:= true
        from
            i := 1
        until
            i > 9 and flag
        loop
            if aux[i] /= 0 then
                from
                    j:= 1
                until
                    j > 9 and flag
                loop
                    if i /= j and aux[i] = aux[j] then
                        flag := false
                    end
                    j:= j + 1
                end
            end
            i:= i + 1
        end
        Result:= flag
    end
end
