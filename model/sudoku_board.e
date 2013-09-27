note
	description	: "{SUDOKU_BOARD}.Initialization of the board, comprising 81 cells.Established with random values"
	author		: ""
	date		: "04/09/2013"
	revision	: "0.1"

class
	SUDOKU_BOARD

inherit
	ANY

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
			create cells.make (9, 9) --Need to inicialize cells, because they are void
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
			board_created: cells /= void
			not is_complete
			is_valid
			board_size: cells.count=81
		end

	make_with_random_values(level:INTEGER)
			-- Initializes the board as with some cells set with random numbers
			-- Level is a parameter indicating how many number will be at the start in the bord
		local
			count, random_row, random_col, random_num: INTEGER
			random_sequence: RANDOM
			l_time: TIME
      		l_seed: INTEGER
      		valid: BOOLEAN
		do
			current.make
			create random_sequence.make
			create l_time.make_now
      		l_seed := l_time.hour
      		l_seed := l_seed * 60 + l_time.minute
      		l_seed := l_seed * 60 + l_time.second
      		l_seed := l_seed * 1000 + l_time.milli_second
			create random_sequence.set_seed (l_seed)
			-- change seed
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
				if(cell_value(random_row,random_col)=0)then
					valid:=set_cell (random_row, random_col, random_num)
					if valid then
						count := count + 1
						cells.item (random_row,random_col).is_settable (False) --cell set default can't be set
					else
						unset_cell(random_row,random_col)
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
            repeated:= repeated_element_in_row(i) or repeated_element_in_col(i)
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
	            repeated := repeated_elements_in_square(i,j)
                j:= j + 3
            end
            i := i + 3
        end
        --valid if nothing is repeated
        Result := not repeated
    end
		-- is the board solved? (valid and complete)
	is_solved: BOOLEAN
    do
        Result:= is_complete and then is_valid
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
				j:=j+1
			end
			i:=i+1
		end
		Result:=count
	end



feature -- Status setting

	set_cell (row: INTEGER; col: INTEGER; value: INTEGER): BOOLEAN
    require
        set_cell_row: row>=0 and row<=9
        set_cell_col: col>=0 and col<=9
        set_cell_value: value>=1 and value<=9
	do
		cells.item(row,col).set_value (value)
		Result:=is_insertion_correct(row,col)
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

feature --Control for insertion

	-- Description : this routine allows user to know if a cell's value is in conflicts with another cell's value in the board
	is_insertion_correct (row,col : INTEGER) : BOOLEAN
	do
		-- if insertion is correct in the line, the column and the square then it is definitely correct!
		result := is_insertion_correct_in_row(row,col) and then is_insertion_correct_in_col(row,col) and then is_insertion_correct_in_square(row,col)
	end

	-- Description : this routine allows user to know if a cell's value is in conflicts with another cell's value in the row
	is_insertion_correct_in_row (row,col : INTEGER) : BOOLEAN
	local
		cur_col : INTEGER
		insertion_correct : BOOLEAN
	do
		insertion_correct := True
		from
			cur_col := 1
		until
			cur_col > 9 or not insertion_correct
		loop
			-- if a cell in the row has the same as the cell we are checking then insertion is not correct
			if col /= cur_col and then cell_value(row,col) = cell_value(row,cur_col) then
				insertion_correct := False
			end
			cur_col := cur_col + 1
		end
		result := insertion_correct
	end

	-- Description : this routine allows user to know if a cell's value is in conflicts with another cell's value in the column
	is_insertion_correct_in_col (row,col : INTEGER) : BOOLEAN
	local
		cur_row : INTEGER
		insertion_correct : BOOLEAN
	do
		insertion_correct := True
		from
			cur_row := 1
		until
			cur_row > 9 or not insertion_correct
		loop
			-- if a cell in the column has the same as the cell we are checking then insertion is not correct
			if row /= cur_row and then cell_value(row,col) = cell_value(cur_row,col) then
				insertion_correct := False
			end
			cur_row := cur_row + 1
		end
		result := insertion_correct
	end

	-- Description : this routine allows user to know if a cell's value is in conflicts with another cell's value in the actual square
	is_insertion_correct_in_square (row_cell,col_cell : INTEGER) : BOOLEAN
	local
		cur_row,cur_col : INTEGER
		row_square, col_square : INTEGER
		insertion_correct : BOOLEAN
	do
		insertion_correct := True

		-- coords of the square :
		row_square := ((row_cell-1)//3)*3+1
		col_square := ((col_cell-1)//3)*3+1
		-- print("Coords of the square : (r:" + row_square.out + ",c:" + col_square.out + ")%N")
		from
			--beginning row index of the square
			cur_row := row_square
		until
			--end row index of the square
			cur_row > row_square+2 or not insertion_correct
		loop
			from
				--beginning column index of the square
				cur_col := col_square
			until
				--end column index of the square
				cur_col > col_square+2 or not insertion_correct
			loop
				-- if a cell in the square has the same as the cell we are checking then insertion is not correct
				if (row_cell /= cur_row or col_cell /= cur_col) and then cell_value(row_cell,col_cell) = cell_value(cur_row,cur_col) then
					insertion_correct := False
				end
				cur_col := cur_col + 1
			end
			cur_row := cur_row + 1
		end
		result := insertion_correct
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
                    j:= i + 1
                until
                    j > 9 or repeat
                loop
                    if cell_value(row, i) = cell_value(row, j) then
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
                    j:= i + 1
                until
                    j > 9 or repeat
                loop
                    if cell_value(i, col) = cell_value(j, col) then
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

feature {ANY}
	cell_is_settable(row,col:INTEGER):BOOLEAN
	do
		Result:= cells.item (row, col).settable
	end

	cell_set(row,col:INTEGER):BOOLEAN
	do
		Result := cells.item (row, col).is_set
	end


end
