note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_INIT_SERVER_GAME

inherit
	EQA_TEST_SET

feature -- Test routines

	test_init_server_game_00
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_game"
		local
			mult: MULTIPLAYER_STATE
			server: SUDOKU_SERVER
		do
			create mult.make("test")
			server := mult.create_server(1)
			assert ("sever started", server.serverStarted)
		end

	test_init_server_game_01
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_game"
		local
			mult: MULTIPLAYER_STATE
			server: SUDOKU_SERVER
		do
			create mult.make("test")
			server := mult.create_server(2)
			server.close_server
			assert ("sever closed",not server.serverStarted)
		end

		test_init_server_game_02
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_game"
		local
			mult: MULTIPLAYER_STATE
			server: SUDOKU_SERVER
		do
			create mult.make("test")
			server := mult.create_server(2)
			server.close_server
			assert ("sever without violation contracts",not server.assertion_violation)
		end

		test_init_server_game_03
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_game"
		local
			mult: MULTIPLAYER_STATE
			server: SUDOKU_SERVER
		do
			create mult.make("test")
			server := mult.create_server(2)
			server.close_server
			assert ("sever closed",not server.gamestarted)
		end

end


