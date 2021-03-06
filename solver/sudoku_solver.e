note
	description: "Solves a SUDOKU_BOARD."
	author: "Gabriel Mabille, Leonel Gasparrini"
	date: "20/09/13"
	revision: "0.1"

class
	SUDOKU_SOLVER
inherit
    EXECUTION_ENVIRONMENT

create
	init_with_board

feature -- init

	init_with_board(new_model : SUDOKU_BOARD)
		--prepare intern variables, sets the board to solve
	require
		not is_initialized
		--new_model.is_valid
	do
		set_model(new_model)
		is_initialized := True
	ensure
		is_initialized
		has_board_to_solve
	end

feature {NONE}

	init_postits
		-- For each cell which already has a value set corresponding postit to this value
	require
		has_board_to_solve
	local
		row,col : INTEGER			-- index to go through the table of postits
		value : INTEGER				-- contains value of the current_cell
		default_post_it : POSTIT	-- the default post_it we use to create postits board
	do
		create default_post_it.init
		create postits.make_filled (default_post_it, 9, 9)

		from
			row := 1
		until
			row > 9
		loop
			from
				col := 1
			until
				col > 9
			loop
				-- because we don't want each post it from the table to refer to the same postit
				-- we create a new one each time
				create default_post_it.init
				postits[row,col] := default_post_it

				-- if the cell already has a value we have to set write on the postit it is the only
				-- possible value
				value := model.cell_value (row, col)

				-- TESTS :
				-- print("Cell's " + "(r:" +row.out+",c:"+col.out+") value " + value.out)
				-- if value /= 0 then
				--		postits[row,col].set_only_value_possible (value)
				-- 		print(" different from 0 => change postit postit %N")
				-- else
				--		print("%N")
				-- end

				-- COMMENT FOLLOWING IF UNCOMMENTED PREVIOUS TESTS
				if value /= 0 then
					postits[row,col].set_only_value_possible (value)
				end
				col := col + 1
			end
			row := row + 1
		end
	end

feature -- set and get for model (SUDOKU_BOARD)

	set_model(new_model : SUDOKU_BOARD)
		-- Set model to new_model and initialize postits
	require
		--new_model.is_valid
	do
		model := new_model
		has_board_to_solve := True
		init_postits
	ensure
		model = new_model
		--model.is_valid
		has_board_to_solve
	end

	get_model : SUDOKU_BOARD
		-- return current model
	do
		result := model
	end

feature {ANY} -- solving function

	solve_board
		-- Solve board until no changes can be done
	require
		is_initialized
		has_board_to_solve
	local
		changes_done : BOOLEAN 	-- check if in one loop changes have been done
	do
		from
			changes_done := True
		until
			not changes_done
		loop
			-- We assume no changes will be done in this loop
			changes_done := False

			-- First we update every postits
			update_all_postits

			-- Now check postits to apply changes and record if changes have been done
			changes_done := apply_changes_for_one_value_postit

			-- Now if no changes have been done and the board is still not solved
			-- we search if there are cells that are the only one
			-- of there square, row, column that could have a value and we set it
			if not changes_done and then not model.is_solved then
				print("No changes have be done by simple method, let's level up the solver dudes! %N")
				changes_done := Set_val_possible_only_in_one_cell_of_board
			end

--			--print board for test
--			if changes_done then
--				print("Changes have been done%N")
--			else
--				print("NO changes have been done%N")
--			end
--			model.print_sudoku
		end
	end


	apply_changes_for_one_value_postit : BOOLEAN
		-- search for postit with only one possible value and modify boards in consequence
		-- return it changes have been apply
	require
		is_initialized
		has_board_to_solve
	local
		changes_done : BOOLEAN	-- check if in changes have been done while checking all postits
		row,col : INTEGER 		-- index to go through the table of postits
		garbage : BOOLEAN		-- model.set_cell returns boolean for which we have no use
	do
		from
			row := 1
		until
			row > 9
		loop
			from
				col := 1
			until
				col > 9
			loop
				-- if cell has not already been set and if current postit tells us we have only one possible value
				-- then we set this value and record we made a change
				if model.cell_value (row, col) = 0 and then postits[row,col].has_only_one_value_possible then
					garbage := model.set_cell (row, col,postits[row,col].get_only_value_possible)
					changes_done := True
				end
				col := col + 1
			end
			row := row + 1
		end

		result := changes_done
	end

feature {NONE} -- update all postits, telling for each cell which values are possible or not

	update_all_postits
		-- updates all postits of the board on values that are possible to put in cell at (row,col)
		-- thanks to a brief analize of the row, the column and the square in which is the cell.
	require
		is_initialized
		has_board_to_solve
	local
		row,col : INTEGER
	do
		from
			row := 1
		until
			row > 9
		loop
			from
				col := 1
			until
				col > 9
			loop
				update_post_it(row,col)
				col := col + 1
			end
			row := row + 1
		end
	end


	update_post_it(row,col : INTEGER)
		-- updates the postit at (row,col) on values that are possible to put in cell at (row,col)
		-- thanks to a brief analize of the row, the column and the square in which is the cell.
	require
		is_initialized
		has_board_to_solve
	do
--		-- TESTS
--		print("Before update :" + "%N")
--		print("postits(r:"+ row.out + ",c:" + col.out + ") = " + postits[row,col].to_string)
--		print("%N")
		update_post_it_with_row(row,col)
--		print("After update row:" + "%N")
--		print("postits(r:"+ row.out + ",c:" + col.out + ") = " + postits[row,col].to_string)
--		print("%N")
		update_post_it_with_col(row,col)
--		print("After update col:" + "%N")
--		print("postits(r:"+ row.out + ",c:" + col.out + ") = " + postits[row,col].to_string)
--		print("%N")
		update_post_it_with_square(row,col)
--		print("After update square:" + "%N")
--		print("postits(r:"+ row.out + ",c:" + col.out + ") = " + postits[row,col].to_string)
--		print("%N")
--		io.read_character
	end


	update_post_it_with_row (row,col : INTEGER)
		-- updates the postit at (row,col) on values that are possible to put in cell at (row,col)
		-- thanks to a brief analize of the row in which is the cell.
	require
		is_initialized
		has_board_to_solve
	local
		cur_col : INTEGER
		cur_value : INTEGER
	do
		if not postits[row,col].has_only_one_value_possible then

			from
				cur_col := 1
			until
				cur_col > 9
			loop
				-- we have to set to false all values present in this row
				cur_value := model.cell_value(row,cur_col);
				if  cur_value /= 0 then
					postits[row,col].put (False, cur_value)
				end
				cur_col := cur_col + 1
			end
		end
	end

	update_post_it_with_col (row,col : INTEGER)
		-- updates the postit at (row,col) on values that are possible to put in cell at (row,col)
		-- thanks to a brief analize of the col in which is the cell.
	require
		is_initialized
		has_board_to_solve
	local
		cur_row : INTEGER
		cur_value : INTEGER
	do
		if not postits[row,col].has_only_one_value_possible then

			from
				cur_row := 1
			until
				cur_row > 9
			loop
				-- we have to set to false all values present in this col
				cur_value := model.cell_value(cur_row,col);
				if  cur_value /= 0 then
					postits[row,col].put (False, cur_value)
				end
				cur_row := cur_row + 1
			end
		end
	end

	update_post_it_with_square (row_cell,col_cell : INTEGER)
		-- updates the postit at (row,col) on values that are possible to put in cell at (row,col)
		-- thanks to a brief analize of the square in which is the cell.
	require
		is_initialized
		has_board_to_solve
	local
		cur_row,cur_col : INTEGER
		row_square, col_square : INTEGER
		cur_value : INTEGER
	do
		if not postits[row_cell,col_cell].has_only_one_value_possible then

			-- coords of the square :
			row_square := ((row_cell-1)//3)*3+1
			col_square := ((col_cell-1)//3)*3+1
			-- print("Coords of the square : (r:" + row_square.out + ",c:" + col_square.out + ")%N")
			from
				--beginning row index of the square
				cur_row := row_square
			until
				--end row index of the square
				cur_row > row_square+2
			loop
				from
					--beginning column index of the square
					cur_col := col_square
				until
					--end column index of the square
					cur_col > col_square+2
				loop
					-- we have to set to false all values present in this square
					cur_value := model.cell_value(cur_row,cur_col);
					if  cur_value /= 0 then
						postits[row_cell,col_cell].put (False, cur_value)
					end
					cur_col := cur_col + 1
				end
				cur_row := cur_row + 1
			end
		end

	end

feature {NONE} --functions that set values who are possible only in a cell of column, row or square


	Set_val_possible_only_in_one_cell_of_board : BOOLEAN
	-- search for each value from 1 to 9, in the postit of each cell of the board if she is the only one that could have a value
	-- from its line, column, square
	-- if it's the case it put it in the board
	require
		is_initialized
		has_board_to_solve
	local
		changes_done : BOOLEAN
		row,col,row_square,col_square : INTEGER
	do
		from
			row:=1
		until
			row > 9
		loop
			changes_done := (changes_done or Set_val_possible_only_in_one_cell_of_row (row))
			row := row + 1
		end
		from
			col:=1
		until
			col > 9
		loop
			changes_done := (changes_done or Set_val_possible_only_in_one_cell_of_col (col))
			col := col + 1
		end
		from
			row_square := 1
		until
			row_square > 7
		loop
			from
				col_square := 1
			until
				col_square > 7
			loop
				changes_done := (changes_done or Set_val_possible_only_in_one_cell_of_square(row_square,col_square))
				col_square := col_square + 3
			end
			row_square := row_square + 3
		end
		result := changes_done
	end

	Set_val_possible_only_in_one_cell_of_row (row_cell : INTEGER):BOOLEAN
	--search in the postit of each cell of a line if a number is possible in only one of them
	--if it's the case it put it in the board
	require
		is_initialized
		has_board_to_solve
	local
		nbr_cell_with_val: INTEGER
		val,col,record_col: INTEGER
		current_postit_has_the_value : BOOLEAN
		current_cell_has_one_value : BOOLEAN
		value_taken : BOOLEAN
		changes_done : BOOLEAN
	do
		from
			val:= 1
		until
			val > 9
		loop
			nbr_cell_with_val:= 0
			value_taken := False
			from
				col:=1
			until
				col > 9 or nbr_cell_with_val > 1 or value_taken
			loop
				--check if in postit the current value is allowed for the cell linked to the postit
				current_postit_has_the_value := postits[row_cell,col].at (val)
				--check if current cell is not already set
				current_cell_has_one_value := postits[row_cell,col].has_only_one_value_possible
				-- if we found the value and the post it is not already set, we can say that the current cell could have the value
				-- else if we found the value and the post it is already set it means the value is taken we don't have to check other
				-- cells
				if (current_postit_has_the_value) then
					if not (current_cell_has_one_value) then
						nbr_cell_with_val:= nbr_cell_with_val + 1
						record_col:= col
					else
						value_taken := True
					end
				end
				col:= col + 1
			end
			-- if value was not taken by a cell and only one cell could have it then we have to set it in this cell
			-- and remember changes have been done
			if not value_taken and nbr_cell_with_val = 1 then
				postits[row_cell,record_col].set_only_value_possible (val)
				changes_done := True
			end
			val:= val + 1
		end
		result := changes_done
	end

	Set_val_possible_only_in_one_cell_of_col (col_cell : INTEGER):BOOLEAN
	--search in the postit of each cell of a column if a number is possible in only one of them
	--if it's the case it put it in the board
	require
		is_initialized
		has_board_to_solve
	local
		nbr_cell_with_val: INTEGER
		val,row,record_row: INTEGER
		current_postit_has_the_value : BOOLEAN
		current_cell_has_one_value : BOOLEAN
		value_taken : BOOLEAN
		changes_done : BOOLEAN
	do
	from
			val:= 1
		until
			val > 9
		loop
			nbr_cell_with_val:= 0
			value_taken := False
			from
				row:=1
			until
				row > 9 or nbr_cell_with_val > 1 or value_taken
			loop
				--check if in postit the current value is allowed for the cell linked to the postit
				current_postit_has_the_value := postits[row,col_cell].at (val)
				--check if current cell is not already set
				current_cell_has_one_value := postits[row,col_cell].has_only_one_value_possible
				-- if we found the value and the post it is not already set, we can say that the current cell could have the value
				-- else if we found the value and the post it is already set it means the value is taken we don't have to check other
				-- cells
				if (current_postit_has_the_value) then
					if not (current_cell_has_one_value) then
						nbr_cell_with_val:= nbr_cell_with_val + 1
						record_row:= row
					else
						value_taken := True
					end
				end
				row:= row + 1
			end
			-- if value was not taken by a cell and only one cell could have it then we have to set it in this cell
			-- and remember changes have been done
			if not value_taken and nbr_cell_with_val = 1 then
				postits[record_row,col_cell].set_only_value_possible (val)
				changes_done := True
			end
			val:= val + 1
		end
		result := changes_done
	end

	Set_val_possible_only_in_one_cell_of_square (col_square,row_square : INTEGER):BOOLEAN
	--search in the postit of each cell of a square if a number is possible in only one of them
	--if it's the case it put it in the board
	require
		is_initialized
		has_board_to_solve
	local
		nbr_cell_with_val: INTEGER
		cur_row,cur_col : INTEGER
		val,cur_value : INTEGER
		record_row,record_col: INTEGER
		current_postit_has_the_value : BOOLEAN
		current_cell_has_one_value : BOOLEAN
		value_taken : BOOLEAN
		changes_done : BOOLEAN
		do
			-- print("Coords of the square : (r:" + row_square.out + ",c:" + col_square.out + ")%N")
			from
				val:= 1
			until
				val > 9
			loop
				nbr_cell_with_val:= 0
				from
					--beginning row index of the square
					cur_row := row_square
				until
					--end row index of the square
					cur_row > row_square+2 or nbr_cell_with_val > 1 or value_taken
				loop
					from
						--beginning column index of the square
						cur_col := col_square
					until
						--end column index of the square
						cur_col > col_square+2 or nbr_cell_with_val > 1 or value_taken
					loop
						--check if in postit the current value is allowed for the cell linked to the postit
						current_postit_has_the_value := postits[cur_row,cur_col].at (val)
						--check if current cell is not already set
						current_cell_has_one_value := postits[cur_row,cur_col].has_only_one_value_possible
						-- if we found the value and the post it is not already set, we can say that the current cell could have the value
						-- else if we found the value and the post it is already set it means the value is taken we don't have to check other
						-- cells
						if (current_postit_has_the_value) then
							if not (current_cell_has_one_value) then
								nbr_cell_with_val:= nbr_cell_with_val + 1
								record_row:= cur_row
								record_col:= cur_col
							else
								value_taken := True
							end
						end
						cur_col := cur_col + 1
					end
					cur_row := cur_row + 1
				end
				-- if value was not taken by a cell and only one cell could have it then we have to set it in this cell
				-- and remember changes have been done
				if not value_taken and nbr_cell_with_val = 1 then
					postits[record_row,record_col].set_only_value_possible (val)
					changes_done:= True
				end
				val:= val + 1
			end
			result := changes_done
		end



feature {ANY} -- intern public variables

	-- Give information whether object has been initialize or not
	is_initialized : BOOLEAN
	-- Give information whether board is set are not
	has_board_to_solve : BOOLEAN

feature {NONE} --intern private variables

	-- Contains current model we are working with
	model : SUDOKU_BOARD

	-- A table of post_its that will remember for each cell which values are possible
	postits : ARRAY2[POSTIT]

feature {ANY} -- TEST

	generate_model : SUDOKU_BOARD
		-- generate the sudoku from solver/sudoku_solved.jpg
	local
		garbage : BOOLEAN
		board : SUDOKU_BOARD
	do
		create board.make

		-- row 1
		garbage := board.set_cell (1,1,5)
		garbage := board.set_cell (1,2,3)
		garbage := board.set_cell (1,5,7)
		-- row 2
		garbage := board.set_cell (2,1,6)
		garbage := board.set_cell (2,4,1)
		garbage := board.set_cell (2,5,9)
		garbage := board.set_cell (2,6,5)
		-- row 3
		garbage := board.set_cell (3,2,9)
		garbage := board.set_cell (3,3,8)
		garbage := board.set_cell (3,8,6)
		-- row 4
		garbage := board.set_cell (4,1,8)
		garbage := board.set_cell (4,5,6)
		garbage := board.set_cell (4,9,3)
		-- row 5
		garbage := board.set_cell (5,1,4)
		garbage := board.set_cell (5,4,8)
		garbage := board.set_cell (5,6,3)
		garbage := board.set_cell (5,9,1)
		-- row 6
		garbage := board.set_cell (6,1,7)
		garbage := board.set_cell (6,5,2)
		garbage := board.set_cell (6,9,6)
		-- row 7
		garbage := board.set_cell (7,2,6)
		garbage := board.set_cell (7,7,2)
		garbage := board.set_cell (7,8,8)
		-- row 8
		garbage := board.set_cell (8,4,4)
		garbage := board.set_cell (8,5,1)
		garbage := board.set_cell (8,6,9)
		garbage := board.set_cell (8,9,5)
		-- row 9
		garbage := board.set_cell (9,5,8)
		garbage := board.set_cell (9,8,7)
		garbage := board.set_cell (9,9,9)


		--print this sudoku
		print("Sudoku generated : %N");
		board.print_sudoku
		print("%N");

		result := board
	end

	print_postits
	local
		row,col : INTEGER
	do
		from
			row := 1
		until
			row > 9
		loop
			from
				col := 1
			until
				col > 9
			loop
				print("postits(r:"+ row.out + ",c:" + col.out + ") = " + postits[row,col].to_string)
				print("%N")
				col := col + 1
			end
			row := row + 1
		end
	end

end
