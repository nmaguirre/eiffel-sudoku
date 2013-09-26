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

	test_swap_1
		local
			ai: AI_SOLUTION
			bol: BOOLEAN
			i,j: INTEGER
		do
			create ai.make
			from
				i:=1
			until
				i>9
			loop
				from
					j:=1
				until
					j>9
				loop
					bol:=ai.sol_board.set_cell (i, j, 1)
					j:=j+1
				end
				i:=i+1
			end
			ai.swap (1, 2)
			bol:=True
			from
				i:=1
			until
				i>9 or (not bol)
			loop
				from
					j:=1
				until
					j>9 or (not bol)
				loop
					bol:=ai.sol_board.cell_value (i, j)/=1
					j:=j+1
				end
				i:=i+1
			end

			assert ("change every one", bol)
		end
end
