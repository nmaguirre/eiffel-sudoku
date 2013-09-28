note
	description	: "Belonging to the class test sudoku_ai"
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez, Diego Gastaldi"
	date		: "27/09/2013"
	revision	: "v0.1"

class
	SUDOKU_AI_TEST

inherit
	EQA_TEST_SET

feature -- Test nr_of_solutions

	test_get_hint_1
		local
			ai: SUDOKU_AI
			x,y,v: INTEGER
			do
				create ai.make_with_level (30)
				v:=ai.get_hint (ai.get_unsolved_board).get_v
				x:=ai.get_hint (ai.get_unsolved_board).get_x
				y:=ai.get_hint (ai.get_unsolved_board).get_y
				assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
			end

	test_get_hint_2
		local
			ai: SUDOKU_AI
			x,y,v: INTEGER
			do
				create ai.make_with_level (15)
				v:=ai.get_hint (ai.get_unsolved_board).get_v
				x:=ai.get_hint (ai.get_unsolved_board).get_x
				y:=ai.get_hint (ai.get_unsolved_board).get_y
				assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
			end

	test_get_hint_3
		local
			ai: SUDOKU_AI
			x,y,v: INTEGER
			do
				create ai.make_with_level (10)
				v:=ai.get_hint (ai.get_unsolved_board).get_v
				x:=ai.get_hint (ai.get_unsolved_board).get_x
				y:=ai.get_hint (ai.get_unsolved_board).get_y
				assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
			end
	test_get_hint_4
		local
			ai: SUDOKU_AI
			x,y,v: INTEGER
			do
				create ai.make_with_level (5)
				v:=ai.get_hint (ai.get_unsolved_board).get_v
				x:=ai.get_hint (ai.get_unsolved_board).get_x
				y:=ai.get_hint (ai.get_unsolved_board).get_y
				assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
			end

	test_board_1
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (1)
			assert ("test number of solution", ai.nr_of_solutions=1)
		end

	test_board_2
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (2)
			assert ("test number of solution with 2 less", ai.nr_of_solutions=1)
		end

	test_board_3
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (40)
			assert ("test number of solution", ai.nr_of_solutions>=1)
		end

	test_delete_cells_0
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (0) -- unsol_board make full

			assert ("test number of solution", ai.nr_of_solutions=1)
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=81)
		end

	test_delete_cells_1
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (1) -- unsol_board make full

			assert ("test number of solution", ai.nr_of_solutions=1)
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=80)
		end

	test_delete_cells_2
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (2) -- unsol_board make full
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=79)
		end

	test_delete_cells_3
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (31) -- unsol_board make full
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=50)
		end

	test_swap_1
		local
			ai:SUDOKU_AI
			i,j:INTEGER
			valid: BOOLEAN
		do
			create ai.make_with_level (0) -- unsol_board make full
			ai.get_sol_board.make
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
					valid:=ai.get_sol_board.set_cell (i, j, 1)

					j := j + 1
				end
				i := i + 1
			end

			ai.swap (1, 2)

			valid:= True
			from
				i := 1
			until
				i > 9 or not valid
			loop
				from
					j := 1
				until
					j>9 or not valid
				loop
					valid := ai.get_sol_board.cell_value (i, j) = 2
					j := j + 1
				end
				i := i + 1
			end
			assert ("test swap method", valid)
		end

	test_swap_2
		local
			ai:SUDOKU_AI
			i,j:INTEGER
			valid, change, collateral_changes: BOOLEAN
		do
			create ai.make_with_level (0) -- unsol_board make full
			ai.get_sol_board.make
			valid:=ai.get_sol_board.set_cell (1, 1, 1)
			valid:=ai.get_sol_board.set_cell (1, 2, 2)
			-- values ​​change
			ai.swap (1, 2)

			change := ( ai.get_sol_board.cell_value (1, 1) = 2 ) and ( ai.get_sol_board.cell_value (1, 2) = 1 )
			collateral_changes:= True
			from
				i := 1
			until
				i > 9 or not collateral_changes
			loop
				from
					j := 1
				until
					j>9 or not collateral_changes
				loop
					if not((i = 1 and j = 1) or (i = 1 and j = 2)) then
						collateral_changes := ai.get_sol_board.cell_value (i, j) /= 0
					end
					j := j + 1
				end
				i := i + 1
			end


			assert ("test swap method", change and not collateral_changes)
		end


feature -- Test generate_solution

	test_generate_solution_1
		local
			i,j,n: INTEGER_32
			l: ARRAY2[INTEGER]
			random1, random2:INTEGER
			ai:SUDOKU_AI
			valid: BOOLEAN
		do
			create ai.make_with_level (1)
			ai.get_sol_board.make

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
					if not ai.sol_board.set_cell (i,j,n)  then
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
				n > 100 -- numbers of swaps
			loop
				--create random_number.make
				random1 := 2 --random_number.random_integer
				random2 := 4 --random_number.random_integer
				ai.swap(random1,random2)
				n := n + 1
			end
			valid := ai.get_sol_board.is_solved
			assert("test generate_solution",valid)
		end

end
