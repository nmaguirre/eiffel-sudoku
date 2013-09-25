note
	description: "Summary description for {SUDOKU_AI_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUDOKU_AI_TEST

inherit
	EQA_TEST_SET

feature -- Test rutine

	test_swap_0
		local
			ai: AI_SOLUTION
			bol: BOOLEAN
		do
			create ai.make
			ai.sol_board.make
			bol:=ai.sol_board.set_cell(1, 1, 1)
			ai.swap (1, 2)
			assert ("swap 1 por 2", ai.sol_board.cell_value (1, 1)=2)
		end
end
