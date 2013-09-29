note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_INIT_CLIENT_GAME

inherit
	EQA_TEST_SET

feature -- Test routines

	test_init_client_game
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_client_game"
		local
			client : SUDOKU_CLIENT
			mult: MULTIPLAYER_STATE
		do
			create mult.make("tests")
			mult.init_client_game
			create client.connect ("192.168.9.0","test",11111)
			assert ("the client is connected", client.isconnected)
		end

end


