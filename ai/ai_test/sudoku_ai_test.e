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
end
