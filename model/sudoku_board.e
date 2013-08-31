note
	description: "Summary description for {SUDOKU_BOARD}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_BOARD

create
	make, make_with_random_values


feature {EQA_TEST_SET} -- Initialization

feature -- Initialization


	make
			-- Initializes the board as empty
		local
			i, j : INTEGER -- indexes used to pass through the matrix of SUDOKU_CELL
			cell : SUDOKU_CELL
		do
			create cells.make (9, 9)
			from -- index for the rows
				i := 1
			until
				i > 9
			loop
				from -- index for the colums
					j := 1
				until
					j > 9
				loop
					create cell.make
					cells.item (i, j):=cell
					j := j + 1
				end -- colums
				i := i + 1
			end -- rows

		ensure
			board_created: cells /= void and not is_solved
			board_size: cells.count=81
		end

	make_with_random_values(level:INTEGER)
			-- Initializes the board as with some cells set with random numbers
			-- Level is a parameter indicating how many number will be at the start in the bord
		local
			count, random_row, random_col, random_num: INTEGER
			random_sequence: RANDOM
		do
			create cells.make (9, 9)
			create random_sequence.make
			from
				count := 1
			until
				count > level
			loop
				random_sequence.forth
				random_num := random_sequence.item \\ 9 + 1
				random_sequence.forth
				random_row := random_sequence.item \\ 9 + 1
				random_sequence.forth
				random_col := random_sequence.item \\ 9 + 1

				if cell_value(random_row, random_col) = 0 then
					set_cell (random_row, random_col, random_num)
					if is_valid then
						count := count + 1
					else
						unset_cell(random_row, random_col)
					end
				end
			end

		end

feature -- Access

feature -- Measurement

feature -- Status report

	cell_value (row: INTEGER; col: INTEGER): INTEGER
		-- returns value of cell in row and col
	require
		(row > 0 and row < 10) and (col > 0 and col < 10)
	do
		Result := cells.item(row, col).get_value
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
			i > 9 or not filled
		loop
			from -- index for the colums
				j := 1
			until
				j > 9 or not filled
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
            i := 1
        until
            i > 9 or repeated
        loop
            if repeated_element_in_row(i) or repeated_element_in_col(i) then
                repeated:= true
            end
            i := i + 1
        end
        -- now check sub boards valids in the main board.
        from
            i:=1
        until
            i > 9 or repeated
        loop
            from
                j := 1
            until
                j > 9 or repeated
            loop
            	print("Check square at (" + i.out + "," + j.out + ")")
                repeated := repeated_elements_in_square(i,j)
                j:= j + 3
            end
            i := i + 3
        end
        Result := repeated
    end
		-- is the board solved? (valid and complete)
	is_solved: BOOLEAN
    do
        Result:= is_valid and is_complete
    end

feature{EQA_TEST_SET} --feature only for testing

	count_seted_cells:INTEGER --count the cells that have been seted
	local
		i: INTEGER
		j: INTEGER
		count:INTEGER
	do
		count:=0
		from
			i:=1
		until
			i>9
		loop
			from
				j:=1
			until
				j>9
			loop
				if(cell_value(i,j)/=0) then
					count:=count+1
				end
			end
		end
		Result:=count
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
		cells[row,col].set_value (0)
		--set_value(row, col, 0)
    ensure
    	not cells[row,col].is_set
        cell_value(row, col)=0
	end

feature {NONE} -- Implementation

	cells: ARRAY2[SUDOKU_CELL]

    -- Return true if there are repeated elements in each row.
    repeated_element_in_row(row: INTEGER): BOOLEAN
    local
        i, j: INTEGER --Index for the columns.
        repeat : BOOLEAN --True if repeating elements in row.
    do
        repeat := false

        from
            i := 1
        until
            i > 9 or repeat
        loop
            if cell_value(row, i) /= 0 then
                from
                    j:= 1
                until
                    j > 9 or repeat
                loop
                    if i /= j and cell_value(row, i) = cell_value(row, j) then
                        repeat := true
                    end
                    j:= j + 1
                end
            end
            i:= i + 1
        end
        Result:= repeat
    end

    -- Return true if there are repeated elements in each row.
    repeated_element_in_col(col: INTEGER): BOOLEAN
    local
        i, j: INTEGER -- Index for the rows
        repeat : BOOLEAN --true if repeating elements in col.
    do
    	repeat := false
        from
            i := 1
        until
            i > 9 or repeat
        loop
            if cell_value(i, col) /= 0 then
                from
                    j:= 1
                until
                    j > 9 or repeat
                loop
                    if i /= j and cell_value(i, col) = cell_value(j, col) then
                    	repeat := true
                    end
                    j:= j + 1
                end
            end
            i:= i + 1
        end
        Result:= repeat
    end

    -- Return true if there are repeated elements in each row and in each col of square 3x3.
    repeated_elements_in_square(row, col: INTEGER): BOOLEAN
    local
        i, j, i_aux: INTEGER
        aux: ARRAY[INTEGER]
        repeat : BOOLEAN
    do
        --Load sub_board in aux array.
        i_aux:= 1
        create aux.make (1, 9)
        from
            i:= row
        until
            i > row + 2
        loop
            from
                j:= col
            until
                j > col + 2
            loop
                aux[i_aux]:= cell_value(i, j)
                j:= j + 1
                i_aux:= i_aux + 1
            end
            i:= i + 1
        end
        --Verify repeated elements in aux array.
        repeat := false
        from
            i := 1
        until
            i > 9 or repeat
        loop
            if aux[i] /= 0 then
                from
                	--from the one after i to the last one no need to start at 1
                    j := i + 1
                until
                    j > 9 or repeat
                loop
                    if aux[i] = aux[j] then
                        repeat := true
                    end
                    j:= j + 1
                end
            end
            i:= i + 1
        end
        Result:= repeat
    end

feature -- out

	print_sudoku
	local
		row, col : INTEGER
		current_value : INTEGER
	do
		from
			row := 1
		until
			row > 9
		loop
			print("| ")
			from
				col := 1
			until
				col > 9
			loop
				current_value := cell_value(row,col)
				if current_value = 0 then
					print("  | ");
				else
					print(current_value.out + " | ");
				end
				col := col + 1
			end
			print("%N");
			row := row + 1
		end
	end


end
