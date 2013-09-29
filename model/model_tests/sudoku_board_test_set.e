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

	test_random_values_count_49

		note
			testing:  "covers/{SUDOKU_BOARD}.make_whit_random_values"
		local
			board:SUDOKU_BOARD
			ai: SUDOKU_AI
		do
			create board.make
			create ai.make_with_level (32)
			board:= ai.get_unsolved_board
			print(board.count_seted_cells)
			assert ("count cells seted ok",board.count_seted_cells=49)
		end

		test_make_whit_random_values

			note
				testing:  "covers/{SUDOKU_BOARD}.make_whit_random_values"
			local
				board:SUDOKU_BOARD
				ai: SUDOKU_AI
			do
				create board.make
				create ai.make_with_level (1)
				board:= ai.get_unsolved_board
				assert ("count cells seted ok",board.is_valid)
			end

		test_is_complete

			note
				testing:  "covers/{SUDOKU_BOARD}.is_complete"
			local
				board:SUDOKU_BOARD
			do
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

		test_set_cell
			local
				board:SUDOKU_BOARD
				valid: BOOLEAN
			do
				create board.make
				valid:=board.set_cell (1, 1, 1)
				assert("cell is setted", board.cell_value (1,1) = 1)
			end

		test_unset_cell
			local
				board:SUDOKU_BOARD
				valid: BOOLEAN
			do
				create board.make
				valid:=board.set_cell (1, 1, 1)
				board.unset_cell (1,1)
				assert("cell is unsetted", board.cell_value (1,1) = 0)
			end
end
