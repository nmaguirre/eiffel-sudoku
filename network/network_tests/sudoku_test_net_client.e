note
	description: "Summary description for {SUDOKU_TEST_NET_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SUDOKU_TEST_NET_CLIENT
inherit
	EQA_TEST_SET

feature -- Test routines

	test_sudoku_client_init
			-- New test routine
		note
			testing: "covers/{SUDOKU_TEST_NET_CLIENT}"
			testing: "user/"
		local
			l_client: SUDOKU_CLIENT
		do
			-- Creating with ip address and port number.
			create l_client.connect("127.0.0.1", "player1", 10000)

			assert("client_not_void", l_client /= void)
		end

end
