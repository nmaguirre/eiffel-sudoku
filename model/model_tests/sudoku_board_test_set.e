note
	description: "Summary description for {SUDOKU_BOARD_TEST_SET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_BOARD_TEST_SET

inherit
	EQA_TEST_SET

feature -- Test routines

	test_random_values_count_32

		note
			testing:  "covers/{SUDOKU_BOARD}.make_whit_random_values"
		local
			board:SUDOKU_BOARD
		do
			--create board.make
			create board.make_with_random_values(32)
			print(board.count_seted_cells)
			assert ("count cells seted ok",board.count_seted_cells=32)
		end

		test_make_whit_random_values

			note
				testing:  "covers/{SUDOKU_BOARD}.make_whit_random_values"
			local
				board:SUDOKU_BOARD
			do
				--create board.make
				create board.make_with_random_values(32)
				assert ("count cells seted ok",board.is_valid)
			end

		test_make_whit_random_values_and_is_complete_and_is_solved

			note
				testing:  "covers/{SUDOKU_BOARD}.make_whit_random_values"
			local
				board:SUDOKU_BOARD
			do
				--create board.make
				create board.make_with_random_values(81)
				assert ("board is solved",board.is_solved)
			end

		test_is_complete

			note
				testing:  "covers/{SUDOKU_BOARD}.is_complete"
			local
				board:SUDOKU_BOARD
			do
				--create board.make
				create board.make
				assert ("board not complete",not board.is_complete)
			end

		test_cel_value
			local
				board:SUDOKU_BOARD
				valid: BOOLEAN
			do
				create board.make
				valid:=board.set_cell (1, 1, 1)
				assert("cell value = 1", valid)
			end
end
