note
	description: "Test for class SAVE_AND_LOAD {SAVE_AND_LOAD_TEST}."
	author: "Matias Donatti"
	date: "25/09/13"
	revision: "None"

class
	SAVE_AND_LOAD_TEST

inherit
	EQA_TEST_SET

feature --test to obtain sudoku_board

	test_get_sudoku_board_1
	local
		board,board2:SUDOKU_BOARD
		save_game:SAVE_AND_LOAD
		i,j:INTEGER
		fail :BOOLEAN
	do
		create board.make_with_random_values (32)
		create save_game.init(board)
		board2 := save_game.get_sudoku_board
		from
			i:=1
		until
			i>9 OR fail
		loop
			from
				j:=1
			until
				j>9 OR fail
			loop
				if board.cell_value (i,j)/=board2.cell_value (i,j) then
					fail:= True
				end
				j:=j+1
			end
			i:=i+1
		end
		assert ("get_sudoku_board fail", not fail)
	end



feature --test routines for save and load a game (board).

	test_save_1
		-- Test if saving the game in a file worked.
	local
		board:SUDOKU_BOARD
		save_game:SAVE_AND_LOAD
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
			create board.make_with_random_values (32)
			create save_game.init(board)
			save_game.save ("")
			passed:=True
		end
		assert ("save broke", not passed)
	rescue
		if (not rescued) then
			rescued := True
			retry
		end
	end

	test_save_2
		-- Test if saving the game in a file worked.
	local
		board:SUDOKU_BOARD
		save_game:SAVE_AND_LOAD
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
			create board.make_with_random_values (32)
			create save_game.init(board)
			save_game.save ("testSave")
			passed:=True
		end
		assert ("save broke",  passed)
	rescue
		if (not rescued) then
			rescued := True
			retry
		end

	end

	test_load_1
		-- Test if load the game from a file worked.
	local
		board:SUDOKU_BOARD
		save_game:SAVE_AND_LOAD
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
			create board.make_with_random_values (32)
			create save_game.init(board)
			save_game.save ("testLoad")
			save_game.load ("testLoad")
			passed:=True
		end
		assert ("load broke",  passed)
	rescue
		if (not rescued) then
			rescued := True
			retry
		end

	end

	test_load_2
		-- Test if load the game from a file worked.
	local
		board:SUDOKU_BOARD
		save_game:SAVE_AND_LOAD
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
			create board.make_with_random_values (32)
			create save_game.init(board)
			save_game.load ("")
			passed:=True
		end
		assert ("save broke", not passed)
	rescue
		if (not rescued) then
			rescued := True
			retry
		end
	end

	test_load_3
		-- Test if load the game from a file worked.
	local
		board,board2:SUDOKU_BOARD
		save_game:SAVE_AND_LOAD
		rescued : BOOLEAN
		passed,fail : BOOLEAN
		i,j:INTEGER
	do
		create board.make_with_random_values (32)
		create save_game.init(board)
		save_game.save ("testLoad")
		save_game.load ("testLoad")
		board2:=save_game.get_sudoku_board
		from
			i:=1
		until
			i>9 OR fail
		loop
			from
				j:=1
			until
				j>9 OR fail
			loop
				if board.cell_value (i,j)/=board2.cell_value (i,j) then
					fail:= True
				end
				j:=j+1
			end
			i:=i+1
		end
		assert ("save fail", not fail)
	end


end
