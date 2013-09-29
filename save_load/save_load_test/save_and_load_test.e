note
	description: "Test for class SAVE_AND_LOAD {SAVE_AND_LOAD_TEST}."
	author: "Matias Donatti"
	date: "25/09/13"
	revision: "0.2"

class
	SAVE_AND_LOAD_TEST

inherit
	EQA_TEST_SET
	redefine
		on_prepare
	end

feature {NONE}

	save_game:SAVE_AND_LOAD
	board:SUDOKU_BOARD
	ai: SUDOKU_AI
	time: TIME_DURATION

	on_prepare
	do
		create time.make_by_fine_seconds (60)
		create board.make
		create ai.make_with_level (32)
		board:= ai.get_unsolved_board
		create save_game.init(board,time)
	end

feature --test to obtain sudoku_board and time

	test_get_sudoku_board_1
		--Test get the board
	local
		board2:SUDOKU_BOARD
		work :BOOLEAN
	do
		save_game.set_sudoku_board (board)

		board2 := save_game.get_sudoku_board
		work := board_equals(board,board2)
		assert ("get_sudoku_board fail", work)
	end

	test_get_time_1
		--Test get the time
	local
		time2: TIME_DURATION
	do
		save_game.set_time (time)
		time2 := save_game.get_time
		assert ("get_time fail", time.is_equal (time2))
	end

feature --test routines for save and load a game (board).

	test_save_1
		-- Test if saving the game in a file worked.
	local
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
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
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
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
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
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
		rescued : BOOLEAN
		passed : BOOLEAN
	do
		if not rescued then
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
		board2,board3:SUDOKU_BOARD
		ai2:SUDOKU_AI
		time2,time3: TIME_DURATION
		work : BOOLEAN
	do
		save_game.set_time (time)
		save_game.set_sudoku_board (board)
		save_game.save ("testLoad")
		-----
		create board3.make
		create ai2.make_with_level (32)
		board3:= ai2.get_unsolved_board
		save_game.set_sudoku_board (board3)
		create time3.make_by_fine_seconds (60)
		save_game.set_time (time3)
		-----
		save_game.load ("testLoad")
		board2:=save_game.get_sudoku_board
		time2:=save_game.get_time
		work := board_equals(board,board2)
		work:=  work and time.is_equal (time2)
		assert ("load fail", work)
	end

feature --test for already_saved
	test_already_saved_1
		--Test if name is saved
	do
		save_game.save ("testAlreadySaved")
		assert("Already_Saved fail", save_game.already_saved)
	end

	test_already_saved_2
		--Test if name is saved
	do
		save_game.save ("testAlreadySaved")
		save_game.load ("testAlreadySaved")
		assert("Already_Saved fail", save_game.already_saved)
	end

	test_already_saved_3
		--Test if name is ""
	do
		assert("Already_Saved fail", not save_game.already_saved)
	end

feature {NONE}

	board_equals(b,b2:SUDOKU_BOARD):BOOLEAN
		--Compare two boards, true if b and b2 are equals.
	local
		i,j:INTEGER
		equals:BOOLEAN
	do
		equals:=true
		from
			i:=1
		until
			i>9 OR NOT equals
		loop
			from
				j:=1
			until
				j>9 OR NOT equals
			loop
				if b.cell_value(i,j)/=b2.cell_value(i,j) then
					equals:= false
				end
				j:=j+1
			end
			i:=i+1
		end
		result := equals
	end

end
