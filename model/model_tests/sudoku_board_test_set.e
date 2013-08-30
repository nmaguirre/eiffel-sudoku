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
			-- Cell is unset after default creation
		note
			testing:  "covers/{SUDOKU_BOARD}.make_whit_random_values"
		local
			board:SUDOKU_BOARD
		do
			--create board.make
			create board.make_with_random_values
			assert ("count cells seted ok",board.count_seted_cells=32)
		end
end
