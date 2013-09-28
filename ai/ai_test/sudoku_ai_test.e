note
	description	: ""
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez, Diego Gastaldi"
	date		: "27/09/2013"
	revision	: "v0.1"

class
	SUDOKU_AI_TEST

inherit
	EQA_TEST_SET

feature -- Test nr_of_solutions

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
end
