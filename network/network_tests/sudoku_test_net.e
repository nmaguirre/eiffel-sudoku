note
	description: "Summary description for {SUDOKU_TEST_NET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SUDOKU_TEST_NET
inherit
	EQA_TEST_SET
	redefine
		on_prepare,
		on_clean
	end

feature  -- Events

	server: SUDOKU_SERVER

	client: SUDOKU_CLIENT

	on_prepare
		-- This routine is called before executing any test.
		do
			-- Creating server
			create server.server_create(10000)

			-- Creating client with ip address and port number.
			create client.connect("127.0.0.1", "player1", 10000)

		end

	on_clean
		-- Similar to "on_prepare", this routine is automatically called after
		-- all tests have been executed.
		do
			client.disconnect_client()
			server.close_server
		end

feature -- Test routines

	test_sudoku_net_connect
			-- Test if connection is established
		note
			testing: "covers/{SUDOKU_TEST_NET}.isconnected"
			testing: "user/"
		do
			assert("client_is_connected", client.isconnected)
		end
end
