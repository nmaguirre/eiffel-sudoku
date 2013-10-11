note
	description	: ""
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez, Diego Gastaldi"
	date		: "26/09/2013"
	revision	: "v0.2"

class
	SUDOKU_AI

create
	make,make_with_level

feature -- attributes

	sol_board: SUDOKU_BOARD
	unsol_board: SUDOKU_BOARD
	hint_counter: INTEGER

feature {SUDOKU_AI_TEST} -- Initialization

	make
		do
			create sol_board.make
		end

	make_with_level(level:INTEGER)
		-- Generates a board with "level" erased cells
		local
			unity:BOOLEAN
		do
         	if level = 37 then hint_counter :=  5
         	else if level = 32  then hint_counter :=  7
         	else if level = 30 then hint_counter := 10
            end
         	end
         	end
			create sol_board.make -- Solution board
			generate_solution
			unity := False
			from
				unity := False
			until
				unity = True
			loop
				create unsol_board.make -- Unsolved board
				unsol_board.deep_copy(sol_board)
				delete_cells(level)
				cell_not_settable
				unity := (nr_of_solutions = 1)
			end
		end


	generate_solution
		-- Generates a valid and complete solution board
		require
			board: sol_board/= Void
		local
			i,j,n: INTEGER_32
			l: ARRAY2[INTEGER]
			random_number:RANDOM_NUMBER
			random1, random2:INTEGER
		do
			create l.make_filled (0,9,9)
			n := 1
			from
				i := 1
			until
				i > 9
			loop
				from
					j := 1
				until
					j > 9
				loop
					if i = 2 and j = 1 then
						n := 4
					else if i = 3 and j = 1  then
						n := 7
					else if i = 4 and j = 1  then
						n := 2
					else if i = 5 and j = 1  then
						n := 5
					else if i = 6 and j = 1  then
						n := 8
					else if i = 7 and j = 1  then
						n := 3
					else if i = 8 and j = 1  then
						n := 6
					else if i = 9 and j = 1  then
						n := 9
					end
					end
					end
					end
					end
					end
					end
					end
					if not sol_board.set_cell (i,j,n)  then
						print ("%N error set_cell %N")
					end
					j := j + 1
					n :=  ((n+1) \\ 10)
					if n = 0 then
						n:= 1
					end
				end
				i := i + 1
			end

			from
				n := 1
			until
				n > 100 -- Numbers of swaps
			loop
				create random_number.make
				random1 := random_number.random_integer
				random2 := random_number.random_integer
				swap(random1,random2)
				n := n + 1
			end
		ensure
			sol_board.is_solved
		end

	swap(n,m:INTEGER)
		-- Swap  every value 'n' with 'm'
		require
			(n>0 and n<10) and (m>0 and m<10)
		local
			i,j:INTEGER
		do
			from
				i := 1
			until
				i > 9
			loop
				from
					j := 1
				until
					j > 9
				loop
					if sol_board.cell_value (i,j) = n then
						if sol_board.set_cell (i,j,m) then
							-- print ("swaping...")
						end
					else if sol_board.cell_value (i,j) = m then
						if sol_board.set_cell (i,j,n) then
							-- print ("swaping...")
						end
					end
					end
					j := j + 1
				end
				i := i + 1
			end
		end

	delete_cells(level: INTEGER)
		-- Deleted "level" cells to the unsol_board method
		require
			correct_level: level>=0
			correct_unsol_board: unsol_board /= Void and unsol_board.is_valid
		local
			n_borrados:INTEGER
			random: RANDOM_NUMBER
			random1, random2:INTEGER
		do
			from
				n_borrados := level
			until
				n_borrados < 1
			loop
			  	create random.make
				random1:= random.random_integer
				random2:= random.random_integer
				if unsol_board.cell_set (random1,random2) then
					unsol_board.unset_cell (random1,random2)
					n_borrados := n_borrados - 1
			   	end
			end
	 	end

feature -- Hint routine

	get_hint(board: SUDOKU_BOARD):SUDOKU_HINT
	-- This Method create two random numbers and check positions in the board
		local
			random: RANDOM_NUMBER
			pos_x: INTEGER
			pos_y: INTEGER
			set: BOOLEAN
			hint: SUDOKU_HINT
		do
			from
				set:=False
			until
				set=True
			loop
				create random.make
				pos_x:= random.random_integer
				pos_y:= random.random_integer
				if not (board.cell_set (pos_x,pos_y)) then
					create hint.make_hint (pos_x, pos_y, sol_board.cell_value (pos_x,pos_y)) --check positions in the board
					set:= True
				end
			end  -- end loop
			hint_counter := hint_counter - 1
			Result:= hint
		end -- end do

feature -- Access

	solve
	-- solves unsol_board
		do
			unsol_board.deep_copy(sol_board)
		end

	get_unsolved_board:SUDOKU_BOARD
		do
			Result := unsol_board
		end

	get_sol_board:SUDOKU_BOARD
		do
			Result := sol_board
		end

	get_solution(x,y:INTEGER):INTEGER
		do
			Result := sol_board.cell_value (x,y)
		end

	get_hint_counter: INTEGER
		do
			Result := hint_counter
		end

	set_hitn_counter(counter :INTEGER)
		do
			hint_counter := counter
		ensure
			counter_hitn_set: hint_counter = counter
		end

feature --nr_of_solutions

	nr_of_solutions: INTEGER
		--This method generate numbers of solutions stored in the variable res
	 	local
	 		i,j,k,res:INTEGER
			in_conflict,found:BOOLEAN
	 	do
	 		in_conflict := not unsol_board.is_valid
	 		if in_conflict or unsol_board.is_complete then
	 			if not in_conflict then
	 				res := 1
	 			else
	 				res := 0
	 			end
	 		else
				from
					i := 1
				until
					i > 9 or found
				loop
					from
						j := 1
					until
						j > 9 or found
					loop
						if unsol_board.cell_value(i,j) = 0 then
							found := True
							from
								k := 1
							until
								k > 9
							loop
								if unsol_board.set_cell(i,j,k) then
									res := res + nr_of_solutions  --Call recursive for count solutions
									unsol_board.unset_cell(i,j)
								else
									unsol_board.unset_cell(i,j)
								end
								k := k + 1
							end
						end
						j := j + 1
					end
					i := i + 1
				end
	 		end
	 		Result := res
	 	end

feature {NONE}

	cell_not_settable
		-- Make "not seteable" cells with value`s
		local
			row,col:INTEGER
		do
			from
				row:=1
			until
				row>9
			loop
				from
					col:=1
				until
					col>9
				loop
					if	unsol_board.cell_value(row,col) /= 0	then
						one_cell_not_settable(row,col)
					end
					col:=col+1
				end
				row:=row+1
			end
		end

feature {ANY}

	one_cell_not_settable(row,col: INTEGER)
		-- Make "not seteable" cell with value in the unsol_board
		do
			unsol_board.define_not_settable(row,col)
		end

invariant
	invariant_clause: True -- Your invariant here

end
