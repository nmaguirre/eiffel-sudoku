note
	description: "Summary description for {RANDOM_NUMBER_TEST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	RANDOM_NUMBER_TEST

inherit
	EQA_TEST_SET

feature -- Test routines

	test_random_integer
		note
			testing : "random = 1 .. 9 "
			local
				random_number: RANDOM_NUMBER
				random_gen : INTEGER
			do
				create random_number.make
				random_gen := random_number.random_integer
				assert("in the interval" , random_gen > 0 and random_gen < 10)
			end
end
