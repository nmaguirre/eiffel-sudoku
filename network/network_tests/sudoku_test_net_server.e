note
	description: "Summary description for {SUDOKU_TEST_NET_SERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	SUDOKU_TEST_NET_SERVER
inherit
	EQA_TEST_SET

feature -- Test routines

	test_sudoku_net_server_init
			-- New test routine
		note
			testing:  "covers/{SUDOKU_TEST_NET_SERVER}"
		local
			l_server: SUDOKU_SERVER
		do
			create l_server.server_create(10000,37)
			assert("not_void", l_server = void)
		end

end
