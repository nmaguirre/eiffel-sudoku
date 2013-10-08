note
	description	: "Belonging to the class tests SUDOKU_AI"
	author		: "Pablo Marconi, Farias Pablo, Dario Astorga, Matias Alvarez, Diego Gastaldi"
	date		: "28/09/2013"
	revision	: "v0.2"

class
	SUDOKU_AI_TEST

inherit
	EQA_TEST_SET

feature -- Test routine get_hint

	test_get_hint_1
			-- Check Method get
		local
			ai: SUDOKU_AI
			hint: SUDOKU_HINT
			x,y,v: INTEGER
		do
			create ai.make_with_level (30)
			hint:=ai.get_hint (ai.unsol_board)
			x:=hint.get_x
			y:=hint.get_y
			v:=hint.get_v
			assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
		end

	test_get_hint_2
			-- New test routine
		local
			ai: SUDOKU_AI
			hint: SUDOKU_HINT
			x,y,v: INTEGER
		do
			create ai.make_with_level (15)
			hint:=ai.get_hint (ai.unsol_board)
			x:=hint.get_x
			y:=hint.get_y
			v:=hint.get_v
			assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
		end
	test_get_hint_3
			-- New test routine
		local
			ai: SUDOKU_AI
			hint: SUDOKU_HINT
			x,y,v: INTEGER
		do
			create ai.make_with_level (10)
			hint:=ai.get_hint (ai.unsol_board)
			x:=hint.get_x
			y:=hint.get_y
			v:=hint.get_v
			assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
		end
	test_get_hint_4
			-- New test routine
		local
			ai: SUDOKU_AI
			hint: SUDOKU_HINT
			x,y,v: INTEGER
		do
			create ai.make_with_level (5)
			hint:=ai.get_hint (ai.unsol_board)
			x:=hint.get_x
			y:=hint.get_y
			v:=hint.get_v
			assert("check value's in the board solutions and board unsolution",ai.get_sol_board.cell_value (x, y) = v)
		end



	test_board_1
			-- New test routine
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (1)
			assert ("test number of solution", ai.nr_of_solutions=1)
		end

	test_board_2
			-- New test routine
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (2)
			assert ("test number of solution with 2 less", ai.nr_of_solutions=1)
		end

	test_board_3
			-- New test routine
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (40)
			assert ("test number of solution", ai.nr_of_solutions>=1)
		end

feature -- Test routine delete_cells

	test_delete_cells_0
		-- New test routine
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (0) -- unsol_board make full
			assert ("test number of solution", ai.nr_of_solutions=1)
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=81)
		end

	test_delete_cells_1
		-- New test routine
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (1) -- unsol_board make full
			assert ("test number of solution", ai.nr_of_solutions=1)
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=80)
		end

	test_delete_cells_2
		-- New test routine
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (2) -- unsol_board make full
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=79)
		end

	test_delete_cells_3
		-- New test routine
		local
			ai:SUDOKU_AI
		do
			create ai.make_with_level (31) -- unsol_board make full
			assert ("test numbers sets cells", ai.get_unsolved_board.count_seted_cells=50)
		end

feature -- Test routine swap

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
			-- values
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

feature -- Test routine generate_solution

	test_generate_solution_1
		local
			ai:SUDOKU_AI
		do
			create ai.make
			ai.generate_solution
			assert("test generate_solution",ai.get_sol_board.is_solved)
		end

end
