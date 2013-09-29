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

	test_init_server_game
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_game"
		local
			mult: MULTIPLAYER_STATE
			server: SUDOKU_SERVER
		do
			create mult.make
			server := mult.init_server_game
			assert ("sever started", server.serverStarted)
		end

end


