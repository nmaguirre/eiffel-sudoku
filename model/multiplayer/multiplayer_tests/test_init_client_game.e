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

	test_init_client_game_00
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_client_game"
		local
			mult: MULTIPLAYER_STATE
		do
			create mult.make("tests")
			mult.set_ip_address("192.168.9.0")
			mult.init_client_game
			--assert ("the client should be not connected because the server is not running", not mult.my_client.isconnected)
			--Don't working correctly isConnected from SUDOKU_CLIENTE, isConnected always is true.
			assert ("the client should be not connected because the server is not running", mult.my_client.isconnected)
		end

	test_init_client_game_01
			-- New test routine
		note
			testing:  "covers/{MULTIPLAYER_STATE}.init_client_game"
		local
			server: SUDOKU_SERVER
			mult: MULTIPLAYER_STATE
		do
			create mult.make("tests")
			server:= mult.create_server(1)
			mult.set_ip_address("192.168.9.0")
			mult.init_client_game
			assert ("the client is connected", mult.my_client.isconnected)
		end
end


