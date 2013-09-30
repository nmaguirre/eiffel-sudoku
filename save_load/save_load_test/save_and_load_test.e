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
	game:SINGLE_PLAYER_STATE

	on_prepare
	do
		create game.make_level (32)
		create save_game.init(game)
		save_game.set_single_player_state (game)
	end

feature --test to obtain player state

	test_get_single_player_state_1
		--Test get the player state
	local
		game2:SINGLE_PLAYER_STATE
		work :BOOLEAN
	do
		--save_game.set_single_player_state (game)
		game2 := save_game.get_single_player_state
		work:= game = game2
		assert ("get_single_player_state worked", work)
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
		assert ("save work",  passed)
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
		assert ("load worked",  passed)
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
		assert ("load broke", not passed)
	rescue
		if (not rescued) then
			rescued := True
			retry
		end
	end

	test_load_3
		-- Test if load the game from a file worked.
	local
		game2,game3:SINGLE_PLAYER_STATE
		work : BOOLEAN
	do
	--	save_game.set_single_player_state(game)
		save_game.save ("testLoad")
		-----
		create game3.make_level (37)
		create save_game.init(game3)
		-----
		save_game.load ("testLoad")
		game2:=save_game.get_single_player_state
		work := game = game2
		assert ("load worked", work)
	end

feature --test for already_saved
	test_already_saved_1
		--Test if name is saved
	do
		save_game.save ("testAlreadySaved")
		assert("Already_Saved worked", save_game.already_saved)
	end

	test_already_saved_2
		--Test if name is saved
	do
		save_game.save ("testAlreadySaved")
		save_game.load ("testAlreadySaved")
		assert("Already_Saved worked", save_game.already_saved)
	end

	test_already_saved_3
		--Test if name is ""
	do
		assert("Already_Saved worked", not save_game.already_saved)
	end

end
